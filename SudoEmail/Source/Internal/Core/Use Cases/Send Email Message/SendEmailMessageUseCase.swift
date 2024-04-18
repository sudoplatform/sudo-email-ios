//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SudoLogging

/// Core use case representation of a operation to send an email message via a user's account.
class SendEmailMessageUseCase {

    // MARK: - Properties

    /// Email message repository used to send the email message.
    let emailMessageRepository: EmailMessageRepository

    /// Email account repository used to look up the encryption status of other email addresses.
    let emailAccountRepository: EmailAccountRepository

    /// Email Crypto Service used to send email messages with E2E encryption.
    let emailCryptoService: EmailCryptoService
    
    /// Email Configuration Data Repository used to get runtime configurations.
    let emailConfigDataRepository: EmailConfigurationDataRepository
    
    let rfc822MessageDataProcessor: Rfc822MessageDataProcessor

    /// Logs diagnostic and error information.
    var logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `SendEmailMessageUseCase`.
    init(
        emailMessageRepository: EmailMessageRepository,
        emailAccountRepository: EmailAccountRepository,
        emailCryptoService: EmailCryptoService,
        emailConfigDataRepository: EmailConfigurationDataRepository,
        rfc822MessageDataProcessor: Rfc822MessageDataProcessor,
        logger: Logger = .emailSDKLogger
    ) {
        self.emailMessageRepository = emailMessageRepository
        self.emailAccountRepository = emailAccountRepository
        self.emailCryptoService = emailCryptoService
        self.emailConfigDataRepository = emailConfigDataRepository
        self.rfc822MessageDataProcessor = rfc822MessageDataProcessor
        self.logger = logger
    }

    // MARK: - Methods

    /// Executes the use case.
    /// - Parameters:
    ///   - input: Input parameters used to send email message.
    /// - Returns: The identifier of the email message on success.
    func execute(withInput input: SendEmailMessageInput) async throws -> String {
        let (senderEmailAddressId, emailMessageHeader, body, attachments, inlineAttachments) =
            (input.senderEmailAddressId, input.emailMessageHeader, input.body, input.attachments, input.inlineAttachments)

        // Check whether recipient addresses and associated public keys exist in the platform
        let allRecipients = emailMessageHeader.to + emailMessageHeader.cc + emailMessageHeader.bcc
        let emailAddressesPublicInfo = try await emailAccountRepository.lookupPublicInfo(emailAddresses: allRecipients, cachePolicy: .remoteOnly)

        let from = [EmailAddressDetail(emailAddress: emailMessageHeader.from)]
        let to = emailMessageHeader.to.map { EmailAddressDetail(emailAddress: $0) }
        let cc = emailMessageHeader.to.map { EmailAddressDetail(emailAddress: $0) }
        let bcc = emailMessageHeader.to.map { EmailAddressDetail(emailAddress: $0) }

        func buildMessageData(attachments: [EmailAttachment], encryptionStatus: EncryptionStatus) throws -> Data {
            let rfc822DataProperties = Rfc822MessageDataProcessor.EmailMessageDetails(
                from: from,
                to: to,
                cc: cc,
                bcc: bcc,
                subject: emailMessageHeader.subject,
                body: body,
                attachments: attachments,
                inlineAttachments: inlineAttachments,
                encryptionStatus: encryptionStatus
            )
            return try rfc822MessageDataProcessor.encodeToInternetMessageData(message: rfc822DataProperties)
        }

        let isInNetworkAddresses = allRecipients.allSatisfy { recipient in
            emailAddressesPublicInfo.contains { info in
                info.emailAddress == recipient
            }
        }
        
        let config = try await emailConfigDataRepository.getConfigurationData()

        if isInNetworkAddresses {
            // Process encrypted email message
            let encryptionStatus = EncryptionStatus.ENCRYPTED
            let rfc822Data = try buildMessageData(attachments: attachments, encryptionStatus: encryptionStatus)
            let keyIds = Set(emailAddressesPublicInfo.map { $0.keyId })
            let encryptedEmailMessage = try emailCryptoService.encrypt(data: rfc822Data, keyIds: keyIds)
            let secureAttachments = encryptedEmailMessage.toList()
            let hasAttachments = !attachments.isEmpty || !inlineAttachments.isEmpty

            // Encode the RFC 822 data with the secureAttachments
            let encryptedRfc822Data = try buildMessageData(attachments: secureAttachments, encryptionStatus: encryptionStatus)

            if (encryptedRfc822Data.count > config.emailMessageMaxOutboundMessageSize) {
                logger.error("Email message size exceeded. Limit: \(config.emailMessageMaxOutboundMessageSize) bytes. Message size: \(encryptedRfc822Data.count)")
                throw SudoEmailError.messageSizeLimitExceeded("Email message size exceeded. Limit: \(config.emailMessageMaxOutboundMessageSize) bytes")
            }

            return try await emailMessageRepository.sendEmailMessage(
                withRFC822Data: encryptedRfc822Data,
                emailAccountId: senderEmailAddressId,
                emailMessageHeader: emailMessageHeader,
                hasAttachments: hasAttachments
            )
        } else {
            // Process non-encrypted email message
            let encryptionStatus = EncryptionStatus.UNENCRYPTED
            let rfc822Data = try buildMessageData(attachments: attachments, encryptionStatus: encryptionStatus)
            
            if (rfc822Data.count > config.emailMessageMaxOutboundMessageSize) {
                logger.error("Email message size exceeded. Limit: \(config.emailMessageMaxOutboundMessageSize) bytes. Message size: \(rfc822Data.count)")
                throw SudoEmailError.messageSizeLimitExceeded("Email message size exceeded. Limit: \(config.emailMessageMaxOutboundMessageSize) bytes")
            }

            return try await emailMessageRepository.sendEmailMessage(
                withRFC822Data: rfc822Data,
                emailAccountId: senderEmailAddressId
            )
        }
    }
}
