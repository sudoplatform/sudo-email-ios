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

    /// Email Crypto Service used to send email messages with E2E encryption.
    let emailCryptoService: EmailCryptoService
    
    /// Email Configuration Data Repository used to get runtime configurations.
    let emailConfigDataRepository: EmailConfigurationDataRepository
    
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
        emailCryptoService: EmailCryptoService,
        emailConfigDataRepository: EmailConfigurationDataRepository,
        rfc822MessageDataProcessor: Rfc822MessageDataProcessor,
        logger: Logger = .emailSDKLogger
    ) {
        self.emailAccountRepository = emailAccountRepository
        self.emailMessageRepository = emailMessageRepository
        self.emailDomainRepository = emailDomainRepository
        self.emailCryptoService = emailCryptoService
        self.emailConfigDataRepository = emailConfigDataRepository
        self.rfc822MessageDataProcessor = rfc822MessageDataProcessor
        self.logger = logger
    }

    // MARK: - Methods

    /// Executes the use case.
    /// - Parameters:
    ///   - input: Input parameters used to send email message.
    /// - Returns: SendEmailMessageResult
    func execute(withInput input: SendEmailMessageInput) async throws -> SendEmailMessageResult {
        let (senderEmailAddressId, emailMessageHeader, body, attachments, inlineAttachments) =
            (input.senderEmailAddressId, input.emailMessageHeader, input.body, input.attachments, input.inlineAttachments)
        
        let domains = try await emailDomainRepository.fetchSupportedDomains()
        
        let allRecipients = emailMessageHeader.to + emailMessageHeader.cc + emailMessageHeader.bcc
        
        // Identify whether recipients are internal and external based on their domains
        var internalRecipients: [String] = []
        var externalRecipients: [String] = []
        allRecipients.forEach { address in
            if domains.contains(where: { domain in address.contains(domain.name) }) {
                internalRecipients.append(address)
            } else {
                externalRecipients.append(address)
            }
        }
        
        if (!internalRecipients.isEmpty) {
            // Lookup public key information for each internal recipient
            let emailAddressesPublicInfo = try await emailAccountRepository.lookupPublicInfo(emailAddresses: internalRecipients, cachePolicy: .remoteOnly)
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
                    hasAttachments: hasAttachments
                )
            } else {
                // Process non-encrypted email message
                let rfc822Data = try await processAndBuildEmailMessage(
                    emailMessageHeader: emailMessageHeader,
                    body: body,
                    attachments: attachments,
                    inlineAttachments: inlineAttachments,
                    encryptionStatus: EncryptionStatus.UNENCRYPTED
                )
                return try await emailMessageRepository.sendEmailMessage(
                    withRFC822Data: rfc822Data,
                    emailAccountId: senderEmailAddressId
                )
            }
        }
        // Process non-encrypted email message
        let rfc822Data = try await processAndBuildEmailMessage(
            emailMessageHeader: emailMessageHeader,
            body: body,
            attachments: attachments,
            inlineAttachments: inlineAttachments,
            encryptionStatus: EncryptionStatus.UNENCRYPTED
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
        emailAddressesPublicInfo: [EmailAddressPublicInfoEntity] = []
    ) async throws -> Data {
        let config = try await emailConfigDataRepository.getConfigurationData()
        let emailMessageMaxOutboundMessageSize = config.emailMessageMaxOutboundMessageSize
        
        // Generate unencrypted RFC822 email data
        var rfc822Data = try buildMessageData(
            emailMessageHeader: emailMessageHeader,
            body: body,
            attachments: attachments,
            inlineAttachments: inlineAttachments,
            encryptionStatus: EncryptionStatus.UNENCRYPTED
        )
        
        if (encryptionStatus == EncryptionStatus.ENCRYPTED) {
            // For each recipient, encrypt the rfc822 with the recipient's key id
            // and store the encrypted payload as an attachment
            let keyIds = Set(emailAddressesPublicInfo.map { $0.keyId })
            let encryptedEmailMessage = try emailCryptoService.encrypt(data: rfc822Data, keyIds: keyIds)
            let secureAttachments = encryptedEmailMessage.toList()

            // Encode the RFC 822 data with the secureAttachments
            rfc822Data = try buildMessageData(
                emailMessageHeader: emailMessageHeader,
                body: body,
                attachments: secureAttachments,
                inlineAttachments: inlineAttachments,
                encryptionStatus: EncryptionStatus.ENCRYPTED
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
        encryptionStatus: EncryptionStatus
    ) throws -> Data {
        let from = [EmailAddressDetail(emailAddress: emailMessageHeader.from)]
        let to = emailMessageHeader.to.map { EmailAddressDetail(emailAddress: $0) }
        let cc = emailMessageHeader.to.map { EmailAddressDetail(emailAddress: $0) }
        let bcc = emailMessageHeader.to.map { EmailAddressDetail(emailAddress: $0) }
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
}
