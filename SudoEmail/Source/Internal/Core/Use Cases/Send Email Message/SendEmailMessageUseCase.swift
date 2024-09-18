//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
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

    /// Utility class used to format messages for replying/forwarding.
    let messageFormatter: MessageFormatter

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
        messageFormatter: MessageFormatter,
        logger: Logger = .emailSDKLogger
    ) {
        self.emailAccountRepository = emailAccountRepository
        self.emailMessageRepository = emailMessageRepository
        self.emailDomainRepository = emailDomainRepository
        self.emailConfigDataRepository = emailConfigDataRepository
        self.emailCryptoService = emailCryptoService
        self.emailMessageUnsealerService = emailMessageUnsealerService
        self.rfc822MessageDataProcessor = rfc822MessageDataProcessor
        self.messageFormatter = messageFormatter
        self.logger = logger
    }

    // MARK: - Methods

    /// Executes the use case.
    /// - Parameters:
    ///   - input: Input parameters used to send email message.
    /// - Returns: SendEmailMessageResult
    func execute(withInput input: SendEmailMessageInput) async throws -> SendEmailMessageResult {
        let (senderEmailAddressId, emailMessageHeader, body, attachments, inlineAttachments, replyingMessageId, forwardingMessageId) = (input.senderEmailAddressId, input.emailMessageHeader, input.body, input.attachments, input.inlineAttachments, input.replyingMessageId, input.forwardingMessageId)

        if replyingMessageId != nil && forwardingMessageId != nil {
            throw SudoEmailError.invalidArgument(
                "Unable to send - received values for both `replyingMessageId` and `forwardingMessageId`"
            )
        }

        // Get message details associated with provided reply or forward id
        var replyMessageDetails: EncodableMessageDetails?
        var forwardMessageDetails: EncodableMessageDetails?
        func retrieveMessageDetails(messageId: String) async throws -> EncodableMessageDetails? {
            var messageDetails: EncodableMessageDetails?
            do {
                async let messageTask = emailMessageRepository.fetchEmailMessageById(messageId)
                async let messageWithBodyTask = emailMessageRepository.getEmailMessageWithBody(messageId: messageId, emailAddressId: senderEmailAddressId)
                if let sealedMessage = try? await messageTask,
                   let messageWithBody = try? await messageWithBodyTask,
                   let unsealedMessage = try? emailMessageUnsealerService.unsealEmailMessage(sealedMessage) {
                    let messageEntity = EmailMessageAPITransformer().transform(unsealedMessage)
                    messageDetails = EncodableMessageDetails(
                        from: messageEntity.from,
                        to: messageEntity.to,
                        cc: messageEntity.cc,
                        date: messageEntity.date,
                        subject: messageEntity.subject,
                        body: messageWithBody.body,
                        id: messageEntity.id
                    )
                } else {
                    logger.debug("Message/message contents not found with id \(messageId)")
                }
            } catch {
                logger.error("Failed to retrieve reply message contents with id \(messageId): \(error.localizedDescription)")
            }
            return messageDetails
        }
        if let replyingMessageId = replyingMessageId {
            replyMessageDetails = try await retrieveMessageDetails(messageId: replyingMessageId)
        } else if let forwardingMessageId = forwardingMessageId {
            forwardMessageDetails = try await retrieveMessageDetails(messageId: forwardingMessageId)
        }

        let domains = try await emailDomainRepository.fetchConfiguredDomains()
        
        let allRecipients = emailMessageHeader.to + emailMessageHeader.cc + emailMessageHeader.bcc
        
        // Identify whether recipients are internal and external based on their domains
        var internalRecipients: [String] = []
        var externalRecipients: [String] = []
        allRecipients.forEach { address in
            if domains.contains(where: { domain in address.address.contains(domain.name) }) {
                internalRecipients.append(address.address)
            } else {
                externalRecipients.append(address.address)
            }
        }
        
        if (!internalRecipients.isEmpty) {
            // Lookup public key information for each internal recipient and sender
            var recipientsAndSender = internalRecipients
            recipientsAndSender.append(emailMessageHeader.from.address)
            let emailAddressesPublicInfo = try await emailAccountRepository.lookupPublicInfo(
                emailAddresses: recipientsAndSender,
                cachePolicy: .remoteOnly
            )

            // Check whether internal recipient addresses and associated public keys exist in the platform
            let isInNetworkAddresses = internalRecipients.allSatisfy { recipient in
                emailAddressesPublicInfo.contains { info in
                    info.emailAddress == recipient
                }
            }
            if (!isInNetworkAddresses) {
                throw SudoEmailError.inNetworkAddressNotFound("At least one email address does not exist in network")
            }
            if (externalRecipients.isEmpty) {
                // Process encrypted email message
                let encryptedRfc822Data = try await processAndBuildEmailMessage(
                    emailMessageHeader: emailMessageHeader,
                    body: body,
                    attachments: attachments,
                    inlineAttachments: inlineAttachments,
                    encryptionStatus: EncryptionStatus.ENCRYPTED,
                    emailAddressesPublicInfo: emailAddressesPublicInfo
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
            }
        }
        // Process non-encrypted email message
        let rfc822Data = try await processAndBuildEmailMessage(
            emailMessageHeader: emailMessageHeader,
            body: body,
            attachments: attachments,
            inlineAttachments: inlineAttachments,
            encryptionStatus: EncryptionStatus.UNENCRYPTED,
            replyMessageDetails: replyMessageDetails,
            forwardMessageDetails: forwardMessageDetails
        )
        return try await emailMessageRepository.sendEmailMessage(
            withRFC822Data: rfc822Data,
            emailAccountId: senderEmailAddressId
        )
    }

    private func processAndBuildEmailMessage(
        emailMessageHeader: InternetMessageFormatHeader,
        body: String,
        attachments: [EmailAttachment],
        inlineAttachments: [EmailAttachment],
        encryptionStatus: EncryptionStatus,
        emailAddressesPublicInfo: [EmailAddressPublicInfoEntity] = [],
        replyMessageDetails: EncodableMessageDetails? = nil,
        forwardMessageDetails: EncodableMessageDetails? = nil
    ) async throws -> Data {
        let config = try await emailConfigDataRepository.getConfigurationData()

        // Generate unencrypted RFC822 email data
        var rfc822Data = try buildMessageData(
            emailMessageHeader: emailMessageHeader,
            body: body,
            attachments: attachments,
            inlineAttachments: inlineAttachments,
            isHtml: true,
            encryptionStatus: EncryptionStatus.UNENCRYPTED,
            replyMessageDetails: replyMessageDetails,
            forwardMessageDetails: forwardMessageDetails
        )
        
        if (encryptionStatus == EncryptionStatus.ENCRYPTED) {
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
                replyMessageDetails: replyMessageDetails,
                forwardMessageDetails: forwardMessageDetails
            )
        }
        
        if (rfc822Data.count > config.emailMessageMaxOutboundMessageSize) {
            logger.error("Email message size exceeded. Limit: \(config.emailMessageMaxOutboundMessageSize) bytes. Message size: \(rfc822Data.count)")
            throw SudoEmailError.messageSizeLimitExceeded("Email message size exceeded. Limit: \(config.emailMessageMaxOutboundMessageSize) bytes")
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
        replyMessageDetails: EncodableMessageDetails? = nil,
        forwardMessageDetails: EncodableMessageDetails? = nil
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
        // Format the email message body and/or subject if reply or forward message details are provided
        if let replyMessageDetails = replyMessageDetails,
           let formattedRfc822DataProperties = messageFormatter.formatAsReplyingMessage(
            messageDetails: rfc822DataProperties,
            replyMessage: replyMessageDetails
           ) ?? nil {
            rfc822DataProperties = formattedRfc822DataProperties
            rfc822DataProperties.replyMessageId = replyMessageDetails.id
        } else if let forwardMessageDetails = forwardMessageDetails,
                  let formattedRfc822DataProperties = (messageFormatter.formatAsForwardingMessage(messageDetails: rfc822DataProperties, forwardMessage: forwardMessageDetails) ?? nil) {
            rfc822DataProperties = formattedRfc822DataProperties
            rfc822DataProperties.forwardMessageId = forwardMessageDetails.id
        }
        return try rfc822MessageDataProcessor.encodeToInternetMessageData(message: rfc822DataProperties)
    }
}
