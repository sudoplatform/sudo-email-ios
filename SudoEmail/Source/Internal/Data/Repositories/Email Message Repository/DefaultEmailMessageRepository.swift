//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SudoApiClient
import SudoLogging
import SudoUser

/** Content encoding values for email message data. */
let CRYPTO_CONTENT_ENCODING: String = "sudoplatform-crypto"
let BINARY_DATA_CONTENT_ENCODING: String = "sudoplatform-binary-data"
let COMPRESSION_CONTENT_ENCODING: String = "sudoplatform-compression"

/// Data implementation of the core `EmailMessageRepository`.
///
/// Allows access and manipulation of email service via AppSync GraphQL and AWSS3.
class DefaultEmailMessageRepository: EmailMessageRepository {

    // MARK: - Supplementary

    enum Defaults {
        /// The name of the metadata field for S3 object crypto key id
        static let keyIdMetadataName = "key-id"

        /// The name of the metadata field for S3 object crypto algorithm
        static let algorithmMetadataName = "algorithm"
    }

    // MARK: - Properties

    private let sendContentType = "binary/octet-stream"

    private let draftContentType = "application/octet-stream"

    /// Api client for peforming operations against the email service.
    let sudoApiClient: SudoApiClient

    /// Identifier of the bucket used for permanent storage of email messages.
    let emailBucket: String

    /// Identifier of the transient bucket.
    let transientBucket: String

    /// String of region.
    let region: String

    /// User client used to access the identity id.
    let userClient: SudoUserClient

    /// Used to log diagnostic and error information.
    let logger: SudoLogging.Logger

    /// Utility class to unseal email messages.
    let unsealer: EmailMessageUnsealerService

    /// Cryptographic key worker for this device
    let deviceKeyWorker: DeviceKeyWorker

    /// S3 client for uploading email messages to the user's S3 transient bucket.
    let s3Worker: AWSS3Worker

    /// Email Crypto Service used to send email messages with E2E encryption.
    let emailCryptoService: EmailCryptoService

    /// RFC 822 Message Processor used to handle the encoding and parsing of the email message content.
    let rfc822MessageDataProcessor: Rfc822MessageDataProcessor

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultEmailMessageRepository`.
    init(
        unsealer: EmailMessageUnsealerService,
        sudoApiClient: SudoApiClient,
        emailBucket: String,
        transientBucket: String,
        region: String,
        userClient: SudoUserClient,
        s3Worker: AWSS3Worker,
        emailCryptoService: EmailCryptoService,
        rfc822MessageDataProcessor: Rfc822MessageDataProcessor,
        deviceKeyWorker: DeviceKeyWorker,
        logger: SudoLogging.Logger = .emailSDKLogger
    ) {
        self.unsealer = unsealer
        self.sudoApiClient = sudoApiClient
        self.emailBucket = emailBucket
        self.transientBucket = transientBucket
        self.region = region
        self.userClient = userClient
        self.s3Worker = s3Worker
        self.emailCryptoService = emailCryptoService
        self.rfc822MessageDataProcessor = rfc822MessageDataProcessor
        self.deviceKeyWorker = deviceKeyWorker
        self.logger = logger
    }

    // MARK: - SealedEmailMessageRepository

    // Sends an out-of-network email message.
    func sendEmailMessage(withRFC822Data data: Data, emailAccountId: String) async throws -> SendEmailMessageResult {
        // Confirm user is signed in
        guard let keyPrefix = await getS3KeyForEmailAddressId(emailAddressId: emailAccountId) else {
            throw SudoEmailError.notSignedIn
        }

        // Upload message data
        let id = UUID().uuidString
        let key = "\(keyPrefix)/\(id)"
        try await s3Worker.upload(
            data: data,
            contentType: sendContentType,
            bucket: transientBucket,
            key: key,
            metadata: nil
        )
        let s3EmailObjectInput = GraphQL.S3EmailObjectInput(
            bucket: transientBucket,
            key: key,
            region: region
        )

        // Perform `SendEmailMessage` mutation (out-of-network)
        let input = GraphQL.SendEmailMessageInput(
            emailAddressId: emailAccountId,
            message: s3EmailObjectInput
        )
        let mutation = GraphQL.SendEmailMessageMutation(input: input)
        let result = try await perform(mutation)
        return SendEmailMessageResult(id: result.sendEmailMessageV2.id, createdAt: Date(millisecondsSince1970: result.sendEmailMessageV2.createdAtEpochMs))
    }

    // Sends an in-network email message with E2E encryption.
    // For replying/forwarding messages, `replyingMessageId` and/or `forwardingMessageId` must be provided as an argument
    // as i
    func sendEmailMessage(
        withRFC822Data data: Data,
        emailAccountId: String,
        emailMessageHeader: InternetMessageFormatHeader,
        hasAttachments: Bool,
        replyingMessageId: String? = nil,
        forwardingMessageId: String? = nil
    ) async throws -> SendEmailMessageResult {
        // Confirm user is signed in
        guard let keyPrefix = await getS3KeyForEmailAddressId(emailAddressId: emailAccountId) else {
            throw SudoEmailError.notSignedIn
        }

        // Upload message data
        let id = UUID().uuidString
        let key = "\(keyPrefix)/\(id)"
        try await s3Worker.upload(
            data: data,
            contentType: sendContentType,
            bucket: transientBucket,
            key: key,
            metadata: nil
        )
        let s3EmailObjectInput = GraphQL.S3EmailObjectInput(
            bucket: transientBucket,
            key: key,
            region: region
        )

        var rfc822HeaderInput = GraphQL.Rfc822HeaderInput(
            bcc: emailMessageHeader.bcc.map(\.description),
            cc: emailMessageHeader.cc.map(\.description),
            from: emailMessageHeader.from.description,
            hasAttachments: hasAttachments,
            replyTo: emailMessageHeader.replyTo.map(\.description),
            subject: emailMessageHeader.subject,
            to: emailMessageHeader.to.map(\.description)
        )
        // Reply/forward message ids needs to be explicitly added to the RFC822 header for E2E sending
        if let replyingMessageId = replyingMessageId {
            rfc822HeaderInput.inReplyTo = replyingMessageId
        }
        if let forwardingMessageId = forwardingMessageId {
            rfc822HeaderInput.references = [forwardingMessageId]
        }

        // Perform `SendEncryptedEmailMessage` mutation (in-network)
        let input = GraphQL.SendEncryptedEmailMessageInput(
            emailAddressId: emailAccountId,
            message: s3EmailObjectInput,
            rfc822Header: rfc822HeaderInput
        )
        let mutation = GraphQL.SendEncryptedEmailMessageMutation(input: input)
        let result = try await perform(mutation)

        return SendEmailMessageResult(
            id: result.sendEncryptedEmailMessage.id,
            createdAt: Date(millisecondsSince1970: result.sendEncryptedEmailMessage.createdAtEpochMs)
        )
    }

    func deleteEmailMessages(withIds ids: [String]) async throws -> [String] {
        let input = GraphQL.DeleteEmailMessagesInput(messageIds: ids)
        let mutation = GraphQL.DeleteEmailMessagesMutation(input: input)
        let result = try await perform(mutation)
        return result.deleteEmailMessages
    }

    func updateEmailMessages(
        withInput input: UpdateEmailMessagesInput
    ) async throws -> BatchOperationResult<UpdatedEmailMessageSuccess, EmailMessageOperationFailureResult> {
        let transformer = UpdateEmailMessagesValuesGQLTransformer()
        let input = GraphQL.UpdateEmailMessagesInput(
            messageIds: input.ids,
            values: transformer.transform(input.values)
        )
        let mutation = GraphQL.UpdateEmailMessagesMutation(input: input)
        let result = try await perform(mutation)
        return try BatchOperationResult<UpdatedEmailMessageSuccess, EmailMessageOperationFailureResult>(
            status: UpdateEmailMessagesStatusApiTransformer().transform(result.updateEmailMessagesV2.getUpdateEmailMessagesStatus()),
            successItems: result.updateEmailMessagesV2.successMessages?.map {
                UpdatedEmailMessageSuccess(
                    id: $0.id,
                    createdAt: Date(millisecondsSince1970: $0.createdAtEpochMs),
                    updatedAt: Date(millisecondsSince1970: $0.updatedAtEpochMs)
                )
            },
            failureItems: result.updateEmailMessagesV2.failedMessages?.map {
                EmailMessageOperationFailureResult(id: $0.id, errorType: $0.errorType)
            }
        )
    }

    func saveDraft(
        rfc822Data: Data,
        senderEmailAddressId: String,
        id: String?
    ) async throws -> DraftEmailMessageMetadataEntity {
        guard let symmetricKeyId = try deviceKeyWorker.getCurrentSymmetricKeyId() else {
            throw SudoEmailError.keyNotFound
        }
        guard let s3KeyPrefix = await getS3KeyForEmailAddressId(emailAddressId: senderEmailAddressId) else {
            throw SudoEmailError.internalError("Unable to find identity id")
        }
        let draftId = id ?? UUID().uuidString
        let s3Key = "\(s3KeyPrefix)/draft/\(draftId)"
        let sealedRfc822String = try deviceKeyWorker.sealString(
            rfc822Data,
            withKeyId: symmetricKeyId
        )
        guard let sealedRfc822Data = sealedRfc822String.data(using: .utf8) else {
            throw SudoEmailError.decodingError
        }
        let encryptionMetadata: [String: String] = [
            Defaults.keyIdMetadataName: symmetricKeyId,
            Defaults.algorithmMetadataName: DefaultDeviceKeyWorker.Defaults.symmetricAlgorithm
        ]
        try await s3Worker.upload(
            data: sealedRfc822Data,
            contentType: draftContentType,
            bucket: emailBucket,
            key: s3Key,
            metadata: encryptionMetadata
        )
        let draftMetadata = try await s3Worker.list(bucket: emailBucket, key: s3Key)

        guard let updatedAt = draftMetadata.first?.lastModified else {
            throw SudoEmailError.internalError("updatedAt not set for draft.")
        }

        return DraftEmailMessageMetadataEntity(id: draftId, emailAddressId: senderEmailAddressId, updatedAt: updatedAt)
    }

    func deleteDraft(
        id: String,
        emailAddressId: String
    ) async throws -> String {
        guard let s3KeyPrefix = await getS3KeyForEmailAddressId(emailAddressId: emailAddressId) else {
            throw SudoEmailError.internalError("Unable to find identity id")
        }
        let s3Key = "\(s3KeyPrefix)/draft/\(id)"
        return try await s3Worker.deleteObject(bucket: emailBucket, key: s3Key)
    }

    func scheduleSendDraftMessage(
        withInput input: ScheduleSendDraftMessageInput
    ) async throws -> ScheduledDraftMessageEntity {
        guard let s3KeyPrefix = await getS3KeyForEmailAddressId(emailAddressId: input.emailAddressId) else {
            throw SudoEmailError.internalError("Unable to find identity id")
        }
        let s3Key = "\(s3KeyPrefix)/draft/\(input.id)"
        var downloaded: S3ObjectEntity
        do {
            downloaded = try await s3Worker.getObject(bucket: emailBucket, key: s3Key)
        } catch {
            switch error {
            case AWSS3WorkerError.noSuchKey:
                logger.error("Could not draft message")
                throw SudoEmailError.emailMessageNotFound
            default:
                throw error
            }
        }
        guard let keyId = downloaded.metadata?[Defaults.keyIdMetadataName] else {
            throw SudoEmailError.decodingError
        }
        guard (downloaded.metadata?[Defaults.algorithmMetadataName]) != nil else {
            throw SudoEmailError.decodingError
        }

        guard let symmetricKey = try deviceKeyWorker.getSymmetricKey(keyId: keyId) else {
            logger.error("Could not find symmetric key \(keyId)")
            throw SudoEmailError.keyNotFound
        }

        let scheduleSendDraftMessageInput = GraphQL.ScheduleSendDraftMessageInput(
            draftMessageKey: s3Key,
            emailAddressId: input.emailAddressId,
            sendAtEpochMs: input.sendAt.millisecondsSince1970,
            symmetricKey: symmetricKey
        )
        let mutation = GraphQL.ScheduleSendDraftMessageMutation(input: scheduleSendDraftMessageInput)
        let result = try await perform(mutation)
        return try ScheduledDraftMessageEntityTransformer().transform(result.scheduleSendDraftMessage)
    }

    func cancelScheduledDraftMessage(
        withInput input: CancelScheduledDraftMessageInput
    ) async throws -> String {
        guard let s3KeyPrefix = await getS3KeyForEmailAddressId(emailAddressId: input.emailAddressId) else {
            throw SudoEmailError.internalError("Unable to find identity id")
        }
        let s3Key = "\(s3KeyPrefix)/draft/\(input.id)"

        let cancelScheduledDraftMessageInput = GraphQL.CancelScheduledDraftMessageInput(
            draftMessageKey: s3Key,
            emailAddressId: input.emailAddressId
        )

        let mutation = GraphQL.CancelScheduledDraftMessageMutation(input: cancelScheduledDraftMessageInput)
        let result = try await perform(mutation)
        guard let id = result.cancelScheduledDraftMessage.suffixAfter(separator: "/") else {
            throw SudoEmailError.internalError("Unable to parse draft message id")
        }
        return id
    }

    func listScheduledDraftMessagesForEmailAddressId(
        withInput input: ListScheduledDraftMessagesForEmailAddressIdInput
    ) async throws -> ListOutputEntity<ScheduledDraftMessageEntity> {
        let listInput = try GraphQL.ListScheduledDraftMessagesForEmailAddressIdInput(
            emailAddressId: input.emailAddressId,
            filter:
            ScheduledDraftMessageFilterGraphQLTransformer().transform(input.filter),
            limit: input.limit,
            nextToken: input.nextToken
        )

        let query = GraphQL.ListScheduledDraftMessagesForEmailAddressIdQuery(
            input: listInput
        )
        let result = try await fetch(query)
        let transformer = ScheduledDraftMessageEntityTransformer()
        let transformedResults = try result.listScheduledDraftMessagesForEmailAddressId.items.map(transformer.transform(_:))
        return ListOutputEntity(
            items: transformedResults,
            nextToken: result.listScheduledDraftMessagesForEmailAddressId.nextToken
        )
    }

    func fetchEmailMessageById(_ id: String) async throws -> SealedEmailMessageEntity? {
        return try await getEmailMessageQuery(id: id)
    }

    func listEmailMessages(
        withInput input: ListEmailMessagesInput
    ) async throws -> ListOutputEntity<SealedEmailMessageEntity> {
        let graphQLInput = GraphQL.ListEmailMessagesInput(
            includeDeletedMessages: input.includeDeletedMessages,
            limit: input.limit,
            nextToken: input.nextToken,
            sortOrder: input.sortOrder?.toGraphQL(),
            specifiedDateRange: input.dateRange?.toGraphQL()
        )
        let query = GraphQL.ListEmailMessagesQuery(input: graphQLInput)
        let result = try await fetch(query)
        let sealedEmailMessages = result.listEmailMessages.items
        let transformer = SealedEmailMessageEntityTransformer()
        let sealedEmailMessageEntities = try sealedEmailMessages.map(transformer.transform(_:))
        return ListOutputEntity(
            items: sealedEmailMessageEntities,
            nextToken: result.listEmailMessages.nextToken
        )
    }

    func listEmailMessagesForEmailAddressId(
        withInput input: ListEmailMessagesForEmailAddressInput
    ) async throws -> ListOutputEntity<SealedEmailMessageEntity> {
        let graphQLInput = GraphQL.ListEmailMessagesForEmailAddressIdInput(
            emailAddressId: input.emailAddressId,
            includeDeletedMessages: input.includeDeletedMessages,
            limit: input.limit,
            nextToken: input.nextToken,
            sortOrder: input.sortOrder?.toGraphQL(),
            specifiedDateRange: input.dateRange?.toGraphQL()
        )
        let query = GraphQL.ListEmailMessagesForEmailAddressIdQuery(input: graphQLInput)
        let result = try await fetch(query)
        let sealedEmailMessages = result.listEmailMessagesForEmailAddressId.items
        let transformer = SealedEmailMessageEntityTransformer()
        let sealedEmailMessageEntities = try sealedEmailMessages.map(transformer.transform(_:))
        return ListOutputEntity(
            items: sealedEmailMessageEntities,
            nextToken: result.listEmailMessagesForEmailAddressId.nextToken
        )
    }

    func listEmailMessagesForEmailFolderId(
        withInput input: ListEmailMessagesForEmailFolderIdInput
    ) async throws -> ListOutputEntity<SealedEmailMessageEntity> {
        let graphQLInput = GraphQL.ListEmailMessagesForEmailFolderIdInput(
            folderId: input.emailFolderId,
            includeDeletedMessages: input.includeDeletedMessages,
            limit: input.limit,
            nextToken: input.nextToken,
            sortOrder: input.sortOrder?.toGraphQL(),
            specifiedDateRange: input.dateRange?.toGraphQL()
        )
        let query = GraphQL.ListEmailMessagesForEmailFolderIdQuery(input: graphQLInput)
        let result = try await fetch(query)
        let sealedEmailMessages = result.listEmailMessagesForEmailFolderId.items
        let transformer = SealedEmailMessageEntityTransformer()
        let sealedEmailMessageEntities = try sealedEmailMessages.map(transformer.transform(_:))
        return ListOutputEntity(
            items: sealedEmailMessageEntities,
            nextToken: result.listEmailMessagesForEmailFolderId.nextToken
        )
    }

    func fetchEmailMessageRFC822Data(_ id: String, emailAddressId: String) async throws -> S3ObjectEntity? {
        guard let sealedEmailMessage = try await getEmailMessageQuery(id: id) else {
            return nil
        }
        guard let s3Key = await getS3KeyForEmailMessageId(id, emailAddressId: emailAddressId, publicKeyId: sealedEmailMessage.keyId) else {
            throw SudoEmailError.notSignedIn
        }
        do {
            let rfc822Object = try await s3Worker.getObject(bucket: emailBucket, key: s3Key)
            return rfc822Object
        } catch {
            logger.error("Failed to fetch email message RFC822 data: \(error.localizedDescription)")
            throw error
        }
    }

    func getEmailMessageWithBody(messageId: String, emailAddressId: String) async throws -> EmailMessageWithBody? {
        // Start tasks concurrently
        async let emailMessageTask = fetchEmailMessageById(messageId)
        async let rfc822ObjectTask = fetchEmailMessageRFC822Data(messageId, emailAddressId: emailAddressId)

        guard let emailMessage = try await emailMessageTask else {
            return nil
        }
        guard let rfc822Object = try await rfc822ObjectTask else {
            throw SudoEmailError.noEmailMessageRFC822Available
        }

        do {
            let contentEncodingValues = (rfc822Object.contentEncoding?
                .split(separator: ",") ?? ["\(CRYPTO_CONTENT_ENCODING)", "\(BINARY_DATA_CONTENT_ENCODING)"])
                .reversed()
            var decodedData = rfc822Object.body
            do {
                for encodingValue in contentEncodingValues {
                    switch encodingValue.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
                    case COMPRESSION_CONTENT_ENCODING:
                        let base64Decoded = Data(base64Encoded: decodedData)
                        decodedData = try (base64Decoded?.gunzipped())!
                    case CRYPTO_CONTENT_ENCODING:
                        decodedData = try unsealer.unsealEmailMessageRFC822Data(
                            rfc822Object.body,
                            withKeyId: emailMessage.keyId,
                            algorithm: emailMessage.algorithm
                        )
                    case BINARY_DATA_CONTENT_ENCODING:
                        break
                    default:
                        throw SudoEmailError.decodingError
                    }
                }
            }

            guard let internetMessageData = String(data: decodedData, encoding: .utf8) else {
                throw SudoEmailError.decodingError
            }
            var parsedMessage = try rfc822MessageDataProcessor.decodeInternetMessageData(input: internetMessageData)

            if emailMessage.encryptionStatus == EncryptionStatus.ENCRYPTED {
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
                parsedMessage = try rfc822MessageDataProcessor.decodeInternetMessageData(input: unencryptedMessageStr)
            }

            return EmailMessageWithBody(
                id: messageId,
                body: parsedMessage.body ?? "",
                isHtml: true,
                attachments: parsedMessage.attachments ?? [],
                inlineAttachments: parsedMessage.inlineAttachments ?? []
            )
        } catch {
            throw SudoEmailError.internalError("Failed to retrieve message with body: \(error.localizedDescription)")
        }
    }

    func getDraft(withInput input: GetDraftEmailMessageInput) async throws -> DraftEmailMessage? {
        guard let s3KeyPrefix = await getS3KeyForEmailAddressId(emailAddressId: input.emailAddressId) else {
            throw SudoEmailError.internalError("Unable to find identity id")
        }
        let s3Key = "\(s3KeyPrefix)/draft/\(input.id)"

        var downloaded: S3ObjectEntity
        do {
            downloaded = try await s3Worker.getObject(bucket: emailBucket, key: s3Key)
        } catch {
            switch error {
            case AWSS3WorkerError.noSuchKey:
                logger.debug("Could not find S3 key")
                return nil
            default:
                throw error
            }
        }

        let updatedAt = downloaded.lastModified
        let sealedData = downloaded.body
        guard let keyId = downloaded.metadata?[Defaults.keyIdMetadataName] else {
            throw SudoEmailError.decodingError
        }
        guard let algorithm = downloaded.metadata?[Defaults.algorithmMetadataName] else {
            throw SudoEmailError.decodingError
        }
        guard let sealedString = String(data: sealedData, encoding: .utf8) else {
            throw SudoEmailError.decodingError
        }
        let unsealedString = try deviceKeyWorker.unsealString(
            sealedString,
            withKeyId: keyId,
            algorithm: algorithm
        )
        return DraftEmailMessage(
            id: input.id,
            emailAddressId: input.emailAddressId,
            updatedAt: updatedAt,
            rfc822Data: Data(unsealedString.utf8)
        )
    }

    func draftExists(id: String, emailAddressId: String) async throws -> Bool {
        guard let s3KeyPrefix = await getS3KeyForEmailAddressId(emailAddressId: emailAddressId) else {
            throw SudoEmailError.internalError("Unable to find identity id")
        }
        let s3Key = "\(s3KeyPrefix)/draft/\(id)"
        do {
            return try await s3Worker.objectExists(bucket: emailBucket, key: s3Key)
        } catch {
            throw SudoEmailError.internalError(error.localizedDescription)
        }
    }

    func listDraftsMetadataForEmailAddressId(emailAddressId: String) async throws -> [DraftEmailMessageMetadataEntity] {
        guard let s3KeyPrefix = await getS3KeyForEmailAddressId(emailAddressId: emailAddressId) else {
            throw SudoEmailError.internalError("Unable to find identity id")
        }
        let s3Key = "\(s3KeyPrefix)/draft/"
        do {
            let result = try await s3Worker.list(bucket: emailBucket, key: s3Key)
            let transformer = DraftEmailMetadataEntityTransformer()
            return try result.map { r in
                return try transformer.transform(awsS3Object: r, s3KeyPrefix: s3Key, emailAddressId: emailAddressId)
            }
        } catch {
            throw SudoEmailError.internalError(error.localizedDescription)
        }
    }

    // MARK: - Helpers

    func getEmailMessageQuery(id: String) async throws -> SealedEmailMessageEntity? {
        let query = GraphQL.GetEmailMessageQuery(id: id)
        let result = try await fetch(query)
        do {
            let transformer = SealedEmailMessageEntityTransformer()
            guard let emailMessage = result.getEmailMessage else {
                return nil
            }
            let entity = try transformer.transform(emailMessage)
            return entity
        } catch {
            logger.error("GetEmailAddressQuery result transformation failed with \(error)")
            throw error
        }
    }

    /// Generate an S3 key to use when sending an email message to the transient bucket.
    func getS3KeyForEmailAddressId(emailAddressId: String) async -> String? {
        guard let identityId = try? await userClient.getIdentityId(), !identityId.isEmpty else {
            logger.warning("Failed to get identity id")
            return nil
        }
        return "\(identityId)/email/\(emailAddressId)"
    }

    /// Get the key to access items in the email S3 bucket.
    /// - Returns: S3 key identifier if the user is signed in, otherwise `nil`.
    func getS3KeyForEmailMessageId(_ id: String, emailAddressId: String, publicKeyId: String) async -> String? {
        guard let keyPrefix = await getS3KeyForEmailAddressId(emailAddressId: emailAddressId) else {
            return nil
        }
        return "\(keyPrefix)/\(id)-\(publicKeyId)"
    }
}
