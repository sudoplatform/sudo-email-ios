//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
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
        let (senderIdentification, emailMessageHeader, body, attachments, inlineAttachments, replyingMessageId, forwardingMessageId) = (
            input.senderIdentification,
            input.emailMessageHeader,
            input.body,
            input.attachments,
            input.inlineAttachments,
            input.replyingMessageId,
            input.forwardingMessageId
        )

        let config = try await emailConfigDataRepository.getConfigurationData()
        let emailMessageUtil = EmailMessageUtil(
            emailAccountRepository: emailAccountRepository,
            emailDomainRepository: emailDomainRepository,
            emailCryptoService: emailCryptoService,
            rfc822MessageDataProcessor: rfc822MessageDataProcessor,
            logger: logger
        )

        try emailMessageUtil.verifyAttachmentValidity(
            prohibitedExtensions: config.prohibitedFileExtensions,
            attachments: attachments,
            inlineAttachments: inlineAttachments
        )

        let allRecipients = (emailMessageHeader.to + emailMessageHeader.cc + emailMessageHeader.bcc).map { it in it.address.lowercased() }

        let allRecipientsInternal = try await areAllRecipientsInternal(config: config, recipients: allRecipients)

        var canSendEncrypted = false
        var emailAddressesPublicInfo: [EmailAddressPublicInfoEntity] = []

        if allRecipientsInternal {
            // Lookup public key information for all internal recipients and sender
            // and verify that they support encryption
            var recipientsAndSender = allRecipients
            recipientsAndSender.append(emailMessageHeader.from.address)
            emailAddressesPublicInfo = try await emailMessageUtil.retrieveAndVerifyPublicInfo(addresses: recipientsAndSender)

            canSendEncrypted = emailAddressesPublicInfo.allSatisfy(\.enableEncryption)
        }

        // Process encrypted email message
        if canSendEncrypted {
            if allRecipients.count > config.encryptedEmailMessageRecipientsLimit {
                throw SudoEmailError.limitExceeded("Cannot send encrypted message to more than \(config.encryptedEmailMessageRecipientsLimit) recipients")
            }

            let encryptedRfc822Data = try await emailMessageUtil.processAndBuildEmailMessage(
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

            switch senderIdentification {
            case .maskId(let maskId):
                return try await emailMessageRepository.sendEmailMessageFromMask(
                    withRFC822Data: encryptedRfc822Data,
                    emailMaskId: maskId,
                    emailMessageHeader: emailMessageHeader,
                    hasAttachments: hasAttachments,
                    encryptionStatus: EncryptionStatus.ENCRYPTED,
                    replyingMessageId: replyingMessageId,
                    forwardingMessageId: forwardingMessageId
                )
            case .emailAddressId(let emailAddressId):
                return try await emailMessageRepository.sendEmailMessage(
                    withRFC822Data: encryptedRfc822Data,
                    emailAccountId: emailAddressId,
                    emailMessageHeader: emailMessageHeader,
                    hasAttachments: hasAttachments,
                    replyingMessageId: replyingMessageId,
                    forwardingMessageId: forwardingMessageId
                )
            }
        }

        // Not all recipients are internal, or at least one doesn't support encryption,
        // so the email message will be sent unencrypted.
        // Verify that the number of recipients does not exceed the unencrypted recipient limit.
        if allRecipients.count > config.emailMessageRecipientsLimit {
            throw SudoEmailError.limitExceeded("Cannot send message to more than \(config.emailMessageRecipientsLimit) recipients")
        }
        let rfc822Data = try await emailMessageUtil.processAndBuildEmailMessage(
            emailMessageHeader: emailMessageHeader,
            body: body,
            attachments: attachments,
            inlineAttachments: inlineAttachments,
            encryptionStatus: EncryptionStatus.UNENCRYPTED,
            replyMessageId: replyingMessageId,
            forwardMessageId: forwardingMessageId,
            emailMessageMaxOutboundMessageSize: config.emailMessageMaxOutboundMessageSize
        )

        switch senderIdentification {
        case .maskId(let maskId):
            let hasAttachments = !attachments.isEmpty || !inlineAttachments.isEmpty
            return try await emailMessageRepository.sendEmailMessageFromMask(
                withRFC822Data: rfc822Data,
                emailMaskId: maskId,
                emailMessageHeader: emailMessageHeader,
                hasAttachments: hasAttachments,
                encryptionStatus: EncryptionStatus.UNENCRYPTED,
                replyingMessageId: replyingMessageId,
                forwardingMessageId: forwardingMessageId
            )
        case .emailAddressId(let emailAddressId):
            return try await emailMessageRepository.sendEmailMessage(
                withRFC822Data: rfc822Data,
                emailAccountId: emailAddressId
            )
        }
    }

    /// Returns the set of internal domains, including configured domains and email mask domains if enabled.
    /// - Parameter config: The email configuration data
    /// - Returns: Array of domain entities representing all valid domains
    private func getInternalDomains(config: EmailConfigurationDataEntity) async throws -> [DomainEntity] {
        var domains = try await emailDomainRepository.fetchConfiguredDomains()

        if config.emailMasksEnabled {
            let maskDomains = try await emailDomainRepository.fetchEmailMaskDomains()
            domains.append(contentsOf: maskDomains)
        }

        return domains
    }

    /// Checks whether all recipients are internal (belong to internal domains).
    /// Note that if the list of recipients is empty, this function returns false,
    /// as there are no recipients to be considered internal.
    ///
    /// - Parameters:
    ///   - config: The email configuration data
    ///   - recipients: Array of recipient email addresses
    /// - Returns: True if all recipients are internal, false otherwise
    private func areAllRecipientsInternal(config: EmailConfigurationDataEntity, recipients: [String]) async throws -> Bool {
        guard !recipients.isEmpty else {
            return false
        }

        let internalDomains = try await getInternalDomains(config: config)

        return recipients.allSatisfy { recipient in
            internalDomains.contains { domain in
                recipient.contains(domain.name)
            }
        }
    }
}
