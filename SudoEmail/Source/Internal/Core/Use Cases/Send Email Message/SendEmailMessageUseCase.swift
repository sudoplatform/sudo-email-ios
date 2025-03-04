//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SudoLogging

/// Core use case representation of a operation to send an email message via a user's account.
class SendEmailMessageUseCase {

    // MARK: - Properties

    /// Email account repository used to look up the encryption status of other email addresses.
    let emailAccountRepository: EmailAccountRepository

    /// Email message repository used to send the email message.
    let emailMessageRepository: EmailMessageRepository

    /// Email domain repository used to retrieve the supported email domains.
    let emailDomainRepository: DomainRepository

    /// Email Configuration Data Repository used to get runtime configurations.
    let emailConfigDataRepository: EmailConfigurationDataRepository

    /// Email Crypto Service used to send email messages with E2E encryption.
    let emailCryptoService: EmailCryptoService

    /// Utility class to unseal email messages.
    let emailMessageUnsealerService: EmailMessageUnsealerService

    /// RFC 822 Message Processor used to handle the encoding and parsing of the email message content.
    let rfc822MessageDataProcessor: Rfc822MessageDataProcessor

    /// Logs diagnostic and error information.
    var logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `SendEmailMessageUseCase`.
    init(
        emailAccountRepository: EmailAccountRepository,
        emailMessageRepository: EmailMessageRepository,
        emailDomainRepository: DomainRepository,
        emailConfigDataRepository: EmailConfigurationDataRepository,
        emailCryptoService: EmailCryptoService,
        emailMessageUnsealerService: EmailMessageUnsealerService,
        rfc822MessageDataProcessor: Rfc822MessageDataProcessor,
        logger: Logger = .emailSDKLogger
    ) {
        self.emailAccountRepository = emailAccountRepository
        self.emailMessageRepository = emailMessageRepository
        self.emailDomainRepository = emailDomainRepository
        self.emailConfigDataRepository = emailConfigDataRepository
        self.emailCryptoService = emailCryptoService
        self.emailMessageUnsealerService = emailMessageUnsealerService
        self.rfc822MessageDataProcessor = rfc822MessageDataProcessor
        self.logger = logger
    }

    // MARK: - Methods

    /// Executes the use case.
    /// - Parameters:
    ///   - input: Input parameters used to send email message.
    /// - Returns: SendEmailMessageResult
    func execute(withInput input: SendEmailMessageInput) async throws -> SendEmailMessageResult {
        let (senderEmailAddressId, emailMessageHeader, body, attachments, inlineAttachments, replyingMessageId, forwardingMessageId) = (
            input.senderEmailAddressId,
            input.emailMessageHeader,
            input.body,
            input.attachments,
            input.inlineAttachments,
            input.replyingMessageId,
            input.forwardingMessageId
        )

        let config = try await emailConfigDataRepository.getConfigurationData()

        let domains = try await emailDomainRepository.fetchConfiguredDomains()

        let allRecipients = (emailMessageHeader.to + emailMessageHeader.cc + emailMessageHeader.bcc).map { it in it.address }

        let allRecipientsInternal = !allRecipients.isEmpty && allRecipients.allSatisfy { recipient in
            domains.contains { domain in
                recipient.contains(domain.name)
            }
        }

        if allRecipientsInternal {
            // Lookup public key information for each internal recipient and sender
            var recipientsAndSender = allRecipients
            recipientsAndSender.append(emailMessageHeader.from.address)
            let emailAddressesPublicInfo = try await emailAccountRepository.lookupPublicInfo(
                emailAddresses: recipientsAndSender,
                cachePolicy: .remoteOnly
            )

            // Check whether internal recipient addresses and associated public keys exist in the platform
            let isInNetworkAddresses = allRecipients.allSatisfy { recipient in
                emailAddressesPublicInfo.contains { info in
                    info.emailAddress == recipient
                }
            }
            if !isInNetworkAddresses {
                throw SudoEmailError.inNetworkAddressNotFound("At least one email address does not exist in network")
            }

            if allRecipients.count > config.encryptedEmailMessageRecipientsLimit {
                throw SudoEmailError.limitExceeded("Cannot send encrypted message to more than \(config.encryptedEmailMessageRecipientsLimit) recipients")
            }
            // Process encrypted email message
            let encryptedRfc822Data = try await processAndBuildEmailMessage(
                emailMessageHeader: emailMessageHeader,
                body: body,
                attachments: attachments,
                inlineAttachments: inlineAttachments,
                encryptionStatus: EncryptionStatus.ENCRYPTED,
                emailAddressesPublicInfo: emailAddressesPublicInfo,
                replyMessageId: replyingMessageId,
                forwardMessageId: forwardingMessageId,
                emailMessageMaxOutboundMessageSize: config.emailMessageMaxOutboundMessageSize
            )
            let hasAttachments = !attachments.isEmpty || !inlineAttachments.isEmpty
            return try await emailMessageRepository.sendEmailMessage(
                withRFC822Data: encryptedRfc822Data,
                emailAccountId: senderEmailAddressId,
                emailMessageHeader: emailMessageHeader,
                hasAttachments: hasAttachments,
                replyingMessageId: replyingMessageId,
                forwardingMessageId: forwardingMessageId
            )
        } else {
            if allRecipients.count > config.emailMessageRecipientsLimit {
                throw SudoEmailError.limitExceeded("Cannot send message to more than \(config.emailMessageRecipientsLimit) recipients")
            }
            // Process non-encrypted email message
            let rfc822Data = try await processAndBuildEmailMessage(
                emailMessageHeader: emailMessageHeader,
                body: body,
                attachments: attachments,
                inlineAttachments: inlineAttachments,
                encryptionStatus: EncryptionStatus.UNENCRYPTED,
                replyMessageId: replyingMessageId,
                forwardMessageId: forwardingMessageId,
                emailMessageMaxOutboundMessageSize: config.emailMessageMaxOutboundMessageSize
            )
            return try await emailMessageRepository.sendEmailMessage(
                withRFC822Data: rfc822Data,
                emailAccountId: senderEmailAddressId
            )
        }
    }

    private func processAndBuildEmailMessage(
        emailMessageHeader: InternetMessageFormatHeader,
        body: String,
        attachments: [EmailAttachment],
        inlineAttachments: [EmailAttachment],
        encryptionStatus: EncryptionStatus,
        emailAddressesPublicInfo: [EmailAddressPublicInfoEntity] = [],
        replyMessageId: String? = nil,
        forwardMessageId: String? = nil,
        emailMessageMaxOutboundMessageSize: Int
    ) async throws -> Data {
        // Generate unencrypted RFC822 email data
        var rfc822Data = try buildMessageData(
            emailMessageHeader: emailMessageHeader,
            body: body,
            attachments: attachments,
            inlineAttachments: inlineAttachments,
            isHtml: true,
            encryptionStatus: EncryptionStatus.UNENCRYPTED,
            replyMessageId: replyMessageId,
            forwardMessageId: forwardMessageId
        )

        if encryptionStatus == EncryptionStatus.ENCRYPTED {
            // For each recipient, encrypt the rfc822 with the recipient's public key
            // and store the encrypted payload as an attachment
            let keys = emailAddressesPublicInfo.map { KeyEntity(type: .publicKey, keyId: $0.keyId, keyData: Data($0.publicKey.utf8)) }
            let encryptedEmailMessage = try emailCryptoService.encrypt(data: rfc822Data, keys: Set(keys))
            let secureAttachments = encryptedEmailMessage.toList()

            // Encode the RFC 822 data with the secureAttachments
            rfc822Data = try buildMessageData(
                emailMessageHeader: emailMessageHeader,
                body: body,
                attachments: secureAttachments,
                inlineAttachments: inlineAttachments,
                isHtml: false,
                encryptionStatus: EncryptionStatus.ENCRYPTED,
                replyMessageId: replyMessageId,
                forwardMessageId: forwardMessageId
            )
        }

        if rfc822Data.count > emailMessageMaxOutboundMessageSize {
            logger.error("Email message size exceeded. Limit: \(emailMessageMaxOutboundMessageSize) bytes. Message size: \(rfc822Data.count)")
            throw SudoEmailError.messageSizeLimitExceeded("Email message size exceeded. Limit: \(emailMessageMaxOutboundMessageSize) bytes")
        }

        return rfc822Data
    }

    private func buildMessageData(
        emailMessageHeader: InternetMessageFormatHeader,
        body: String,
        attachments: [EmailAttachment],
        inlineAttachments: [EmailAttachment],
        isHtml: Bool,
        encryptionStatus: EncryptionStatus,
        replyMessageId: String? = nil,
        forwardMessageId: String? = nil
    ) throws -> Data {
        let from = [EmailAddressAndName(address: emailMessageHeader.from.address, displayName: emailMessageHeader.from.displayName)]
        let to = emailMessageHeader.to.map { EmailAddressAndName(address: $0.address, displayName: $0.displayName) }
        let cc = emailMessageHeader.cc.map { EmailAddressAndName(address: $0.address, displayName: $0.displayName) }
        let bcc = emailMessageHeader.bcc.map { EmailAddressAndName(address: $0.address, displayName: $0.displayName) }
        var rfc822DataProperties = EmailMessageDetails(
            from: from,
            to: to,
            cc: cc,
            bcc: bcc,
            subject: emailMessageHeader.subject,
            body: body,
            attachments: attachments,
            inlineAttachments: inlineAttachments,
            isHtml: isHtml,
            encryptionStatus: encryptionStatus
        )
        if let forwardMessageId = forwardMessageId {
            rfc822DataProperties.forwardMessageId = forwardMessageId
        }
        if let replyMessageId = replyMessageId {
            rfc822DataProperties.replyMessageId = replyMessageId
        }
        return try rfc822MessageDataProcessor.encodeToInternetMessageData(message: rfc822DataProperties)
    }
}
