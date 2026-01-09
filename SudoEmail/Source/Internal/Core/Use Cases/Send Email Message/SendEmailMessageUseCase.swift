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

        let domains = try await emailDomainRepository.fetchConfiguredDomains()

        let allRecipients = (emailMessageHeader.to + emailMessageHeader.cc + emailMessageHeader.bcc).map { it in it.address.lowercased() }

        let allRecipientsInternal = !allRecipients.isEmpty && allRecipients.allSatisfy { recipient in
            domains.contains { domain in
                recipient.contains(domain.name)
            }
        }

        if allRecipientsInternal {
            // Lookup public key information for each internal recipient and sender
            var recipientsAndSender = allRecipients
            recipientsAndSender.append(emailMessageHeader.from.address)
            let emailAddressesPublicInfo = try await emailMessageUtil.retrieveAndVerifyPublicInfo(addresses: recipientsAndSender)

            if allRecipients.count > config.encryptedEmailMessageRecipientsLimit {
                throw SudoEmailError.limitExceeded("Cannot send encrypted message to more than \(config.encryptedEmailMessageRecipientsLimit) recipients")
            }
            // Process encrypted email message
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
            return try await emailMessageRepository.sendEmailMessage(
                withRFC822Data: rfc822Data,
                emailAccountId: senderEmailAddressId
            )
        }
    }
}
