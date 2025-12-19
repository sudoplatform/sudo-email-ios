//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

class EmailMessageUtil {

    // MARK: - Properties

    let emailAccountRepository: EmailAccountRepository?
    let emailDomainRepository: DomainRepository?
    let emailCryptoService: EmailCryptoService
    let rfc822MessageDataProcessor: Rfc822MessageDataProcessor
    let logger: Logger

    // MARK: - Lifecycle

    init(
        emailAccountRepository: EmailAccountRepository?,
        emailDomainRepository: DomainRepository?,
        emailCryptoService: EmailCryptoService,
        rfc822MessageDataProcessor: Rfc822MessageDataProcessor,
        logger: Logger
    ) {
        self.emailAccountRepository = emailAccountRepository
        self.emailDomainRepository = emailDomainRepository
        self.emailCryptoService = emailCryptoService
        self.rfc822MessageDataProcessor = rfc822MessageDataProcessor
        self.logger = logger
    }

    // MARK: - Public Methods

    func processMessageForUpload(
        data: Data,
        config: EmailConfigurationDataEntity
    ) async throws -> Data {
        if emailAccountRepository == nil {
            throw SudoEmailError.internalError("No emailAccountRepository provided")
        }
        if emailDomainRepository == nil {
            throw SudoEmailError.internalError("No emailDomainRepository provided")
        }
        var rfc822Data = data

        guard let internetMessageData = String(data: rfc822Data, encoding: .utf8) else {
            throw SudoEmailError.decodingError
        }
        let parsedDraft = try rfc822MessageDataProcessor.decodeInternetMessageData(input: internetMessageData)
        try verifyAttachmentValidity(
            prohibitedExtensions: config.prohibitedFileExtensions,
            attachments: parsedDraft.attachments ?? [],
            inlineAttachments: parsedDraft.inlineAttachments ?? []
        )

        let domains = try await emailDomainRepository!.fetchConfiguredDomains()

        let allRecipients = ((parsedDraft.to ?? []) + (parsedDraft.cc ?? []) + (parsedDraft.bcc ?? [])).map { it in it.address }

        let allRecipientsInternal = !allRecipients.isEmpty && allRecipients.allSatisfy { recipient in
            domains.contains { domain in
                recipient.contains(domain.name)
            }
        }

        if allRecipientsInternal {
            // Lookup public key information for each internal recipient and sender
            var recipientsAndSender = allRecipients
            recipientsAndSender.append(parsedDraft.from[0].address)
            let emailAddressesPublicInfo = try await retrieveAndVerifyPublicInfo(addresses: recipientsAndSender)

            if allRecipients.count > config.encryptedEmailMessageRecipientsLimit {
                throw SudoEmailError.limitExceeded("Cannot send encrypted message to more than \(config.encryptedEmailMessageRecipientsLimit) recipients")
            }
            // Process encrypted email message
            let emailMessageHeader = InternetMessageFormatHeader(
                from: parsedDraft.from[0],
                to: parsedDraft.to ?? [],
                cc: parsedDraft.cc ?? [],
                bcc: parsedDraft.bcc ?? [],
                replyTo: parsedDraft.replyTo ?? [],
                subject: parsedDraft.subject ?? ""
            )
            rfc822Data = try await processAndBuildEmailMessage(
                emailMessageHeader: emailMessageHeader,
                body: parsedDraft.body ?? "",
                attachments: parsedDraft.attachments ?? [],
                inlineAttachments: parsedDraft.inlineAttachments ?? [],
                encryptionStatus: EncryptionStatus.ENCRYPTED,
                emailAddressesPublicInfo: emailAddressesPublicInfo,
                replyMessageId: parsedDraft.replyMessageId,
                forwardMessageId: parsedDraft.forwardMessageId,
                emailMessageMaxOutboundMessageSize: config.emailMessageMaxOutboundMessageSize
            )
        }
        return rfc822Data
    }

    func decryptInNetworkMessage(
        parsedMessage: EmailMessageDetails
    ) throws -> EmailMessageDetails {
        var keyAttachments: Set<EmailAttachment> = []
        var bodyAttachment: EmailAttachment?

        parsedMessage.attachments?.forEach { attachment in
            let contentId = attachment.contentId ?? ""
            let isKeyExchangeType = contentId.contains(SecureEmailAttachmentType.KEY_EXCHANGE.contentId()) ||
                contentId.contains(SecureEmailAttachmentType.LEGACY_KEY_EXCHANGE_CONTENT_ID)
            if isKeyExchangeType {
                keyAttachments.insert(attachment)
            } else {
                let isBodyType = contentId.contains(SecureEmailAttachmentType.BODY.contentId()) ||
                    contentId.contains(SecureEmailAttachmentType.LEGACY_BODY_CONTENT_ID)
                if isBodyType {
                    bodyAttachment = attachment
                }
            }
        }

        if keyAttachments.isEmpty {
            throw SudoEmailError.keyAttachmentsNotFound
        }
        guard let bodyAttachment = bodyAttachment else {
            throw SudoEmailError.bodyAttachmentNotFound
        }

        let securePackage = SecurePackageEntity(keyAttachments: keyAttachments, bodyAttachment: bodyAttachment)
        let unencryptedMessageData = try emailCryptoService.decrypt(securePackage: securePackage)
        guard let unencryptedMessageStr = String(data: unencryptedMessageData, encoding: .utf8) else {
            throw SudoEmailError.decodingError
        }
        return try rfc822MessageDataProcessor.decodeInternetMessageData(input: unencryptedMessageStr)
    }

    func verifyAttachmentValidity(
        prohibitedExtensions: [String],
        attachments: [EmailAttachment],
        inlineAttachments: [EmailAttachment]
    ) throws {
        let attachmentExtensions = (attachments + inlineAttachments)
            .compactMap(\.filename)
            .map { URL(fileURLWithPath: $0).pathExtension }
            .map { ".\($0.lowercased())" }

        guard Set(attachmentExtensions).isDisjoint(with: prohibitedExtensions) else {
            throw SudoEmailError.invalidEmailContents
        }
    }

    func retrieveAndVerifyPublicInfo(addresses: [String]) async throws -> [EmailAddressPublicInfoEntity] {
        if emailAccountRepository == nil {
            throw SudoEmailError.internalError("No emailAccountRepository provided")
        }
        let emailAddressesPublicInfo = try await emailAccountRepository!.lookupPublicInfo(emailAddresses: addresses)

        // Check whether internal recipient addresses and associated public keys exist in the platform
        let isInNetworkAddresses = addresses.allSatisfy { recipient in
            emailAddressesPublicInfo.contains { info in
                info.emailAddress == recipient
            }
        }
        if !isInNetworkAddresses {
            throw SudoEmailError.inNetworkAddressNotFound("At least one email address does not exist in network")
        }
        return emailAddressesPublicInfo
    }

    func processAndBuildEmailMessage(
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
            let keys = emailAddressesPublicInfo.map {
                KeyEntity(
                    type: .publicKey(format: $0.publicKeyDetails.keyFormat),
                    keyId: $0.keyId,
                    keyData: Data($0.publicKeyDetails.publicKey.utf8)
                )
            }
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

    // MARK: - Private Methods

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
