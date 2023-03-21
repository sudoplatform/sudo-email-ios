//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSAppSync
import AWSS3
import SudoApiClient
import SudoLogging
import SudoUser

/// Metadata associated with draft email messages stored in S3
struct DraftEmailMessageEncryptionMetadata: Equatable {
    /// encryption algorithm
    public var algorithm: String

    /// symmetric key id
    public var keyId: String
}

/// Data implementation of the core `EmailMessageRepository`.
///
/// Allows access and manipulation of email service via AppSync GraphQL and AWSS3.
class DefaultEmailMessageRepository: EmailMessageRepository, Resetable {

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

    /// App sync client for peforming operations against the email service.
    let appSyncClient: SudoApiClient

    /// Identifier of the bucket used for permanent storage of email messages.
    let emailBucket: String

    /// Identifier of the transient bucket.
    let transientBucket: String

    /// String of region.
    let region: String

    /// User client used to access the identity id.
    let userClient: SudoUserClient

    /// Used to log diagnostic and error information.
    let logger: Logger

    /// Utility class to unseal email messages.
    var unsealer: EmailMessageUnsealerService

    /// Cryptographic key worker for this device
    var deviceKeyWorker: DeviceKeyWorker

    /// Utility class to manage subscriptions.
    let subscriptionManager: SubscriptionManager

    /// S3 client for uploading email messages to the user's S3 transient bucket.
    let s3Worker: AWSS3Worker

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultEmailMessageRepository`.
    init(
        unsealer: EmailMessageUnsealerService,
        subscriptionManager: SubscriptionManager = DefaultSubscriptionManager(),
        appSyncClient: SudoApiClient,
        emailBucket: String,
        transientBucket: String,
        region: String,
        userClient: SudoUserClient,
        s3Worker: AWSS3Worker,
        deviceKeyWorker: DeviceKeyWorker,
        logger: Logger = .emailSDKLogger
    ) {
        self.unsealer = unsealer
        self.subscriptionManager = subscriptionManager
        self.appSyncClient = appSyncClient
        self.emailBucket = emailBucket
        self.transientBucket = transientBucket
        self.region = region
        self.userClient = userClient
        self.s3Worker = s3Worker
        self.deviceKeyWorker = deviceKeyWorker
        self.logger = logger
    }

    func reset() {
        subscriptionManager.removeAllSubscriptions()
    }

    // MARK: - SealedEmailMessageRepository

    func sendEmailMessage(withRFC822Data data: Data, emailAccountId: String) async throws -> String {
        guard let keyPrefix = await getS3KeyForEmailAddressId(emailAddressId: emailAccountId) else {
            throw SudoEmailError.notSignedIn
        }
        let id = UUID().uuidString
        let key = "\(keyPrefix)/\(id)"
        try await self.s3Worker.upload(
            data: data,
            contentType: sendContentType,
            bucket: self.transientBucket,
            key: key,
            metadata: nil
        )

        let s3Input = GraphQL.S3EmailObjectInput(bucket: self.transientBucket, key: key, region: self.region)
        let input = GraphQL.SendEmailMessageInput(emailAddressId: emailAccountId, message: s3Input)
        let mutation = GraphQL.SendEmailMessageMutation(input: input)
        if Task.isCancelled { return "cancelled" }
        let (performResult, performError) = try await self.appSyncClient.perform(mutation: mutation)
        guard let result = performResult?.data else {
            if let error = performError {
                switch error {
                case ApiOperationError.graphQLError(let cause):
                    guard let sudoEmailError = SudoEmailError(graphQLError: cause) else {
                        throw SudoEmailError.internalError("Unexpected error: \(error)")
                    }
                    throw sudoEmailError
                case ApiOperationError.notSignedIn:
                    throw SudoEmailError.notSignedIn
                default:
                    throw SudoEmailError.internalError("Unexpected error: \(error)")
                }
            }
            throw SudoEmailError.internalError("Unexpected error")
        }
        return result.sendEmailMessage
    }

    func deleteEmailMessages(withIds ids: [String]) async throws -> [String] {
        if ids.count > deleteRequestLimit {
            throw SudoEmailError.limitExceeded
        }
        let input = GraphQL.DeleteEmailMessagesInput(messageIds: ids)
        let mutation = GraphQL.DeleteEmailMessagesMutation(input: input)
        do {
            let (performResult, performError) = try await self.appSyncClient.perform(mutation: mutation)
            if let error = performError {
                switch error {
                case ApiOperationError.graphQLError(let cause):
                    guard let sudoEmailError = SudoEmailError(graphQLError: cause) else {
                        throw SudoEmailError.internalError("Unexpected error: \(error)")
                    }
                    throw sudoEmailError
                default:
                    throw SudoEmailError.fromApiOperationError(error: error)
                }
            }

            guard let result = performResult?.data else {
                throw SudoEmailError.internalError("Missing data from API call")
            }
            return result.deleteEmailMessages
        } catch let error as ApiOperationError {
            throw SudoEmailError.fromApiOperationError(error: error)
        }
    }

    func updateEmailMessages(withInput input: UpdateEmailMessagesInput) async throws -> BatchOperationResult<String> {
        let transformer = UpdateEmailMessagesValuesGQLTransformer()
        let input = GraphQL.UpdateEmailMessagesInput(
            messageIds: input.ids,
            values: transformer.transform(input.values)
        )
        let mutation = GraphQL.UpdateEmailMessagesMutation(input: input)
        do {
            let (performResult, performError) = try await self.appSyncClient.perform(mutation: mutation)
            if let error = performError {
                switch error {
                case ApiOperationError.graphQLError(let cause):
                    guard let sudoEmailError = SudoEmailError(graphQLError: cause) else {
                        throw SudoEmailError.internalError("Unexpected error: \(error)")
                    }
                    throw sudoEmailError
                default:
                    throw SudoEmailError.fromApiOperationError(error: error)
                }
            }
            guard let result = performResult?.data else {
                throw SudoEmailError.internalError("Missing data from API call")
            }
            switch result.updateEmailMessages.status {
            case .success:
                return BatchOperationResult<String>.success
            case .failed:
                return BatchOperationResult<String>.failure
            case .partial:
                let partialResult = BatchOperationResult.BatchOperationPartialResult(
                    successItems: result.updateEmailMessages.successMessageIds ?? [],
                    failureItems: result.updateEmailMessages.failedMessageIds
                    ?? [])
                return BatchOperationResult<String>.partial(partialResult)
            case .unknown:
                throw SudoEmailError.internalError("Unknown status returned by UpdateEmailMessages mutation")
            }
        } catch let error as ApiOperationError {
            throw SudoEmailError.fromApiOperationError(error: error)
        }
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
        let encryptionMetadata = DraftEmailMessageEncryptionMetadata(
            algorithm: DefaultEmailAccountRepository.Defaults.symmetricAlgorithm,
            keyId: symmetricKeyId
        )

        try await s3Worker.upload(
            data: sealedRfc822Data,
            contentType: draftContentType,
            bucket: emailBucket,
            key: s3Key,
            metadata: encryptionMetadata
        )
        let draftMetadata = try await s3Worker.list(bucket: emailBucket, key: s3Key)

        guard let updatedAt = draftMetadata.first?.lastModified   else {
            throw SudoEmailError.internalError("updatedAt not set for draft.")
        }

        return DraftEmailMessageMetadataEntity(id: draftId, updatedAt: updatedAt)
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

    func getEmailMessageById(_ id: String) async throws -> SealedEmailMessageEntity? {
        return try await getEmailMessageQuery(id: id, cachePolicy: .returnCacheDataDontFetch)
    }

    func fetchEmailMessageById(_ id: String) async throws -> SealedEmailMessageEntity? {
        return try await getEmailMessageQuery(id: id, cachePolicy: .fetchIgnoringCacheData)
    }

    func listEmailMessagesForEmailAddressId(
        withInput input: ListEmailMessagesForEmailAddressInput
    ) async throws -> ListOutputEntity<SealedEmailMessageEntity> {
        let graphQLInput = GraphQL.ListEmailMessagesForEmailAddressIdInput(
            dateRange: input.dateRange?.toGraphQL(),
            emailAddressId: input.emailAddressId,
            limit: input.limit,
            nextToken: input.nextToken,
            sortOrder: input.sortOrder?.toGraphQL()
        )
        let query = GraphQL.ListEmailMessagesForEmailAddressIdQuery(input: graphQLInput)
        let cachePolicy = input.cachePolicy ?? .remoteOnly
        let cachePolicyTransformer = CachePolicyAPITransformer()
        let queryCachePolicy = cachePolicyTransformer.transform(cachePolicy)
        let (fetchResult, fetchError) = try await self.appSyncClient.fetch(
            query: query,
            cachePolicy: queryCachePolicy
        )
        if let error = fetchError {
            switch error {
            case ApiOperationError.graphQLError(let cause):
                guard let sudoEmailError = SudoEmailError(graphQLError: cause) else {
                    throw SudoEmailError.internalError("Unexpected error: \(error)")
                }
                throw sudoEmailError
            default:
                throw SudoEmailError.fromApiOperationError(error: error)
            }
        }
        let sealedEmailMessages = fetchResult?.data?.listEmailMessagesForEmailAddressId.items ?? []
        let transformer = SealedEmailMessageEntityTransformer()
        let sealedEmailMessageEntities = try sealedEmailMessages.map(transformer.transform(_:))
        return ListOutputEntity(
            items: sealedEmailMessageEntities,
            nextToken: fetchResult?.data?.listEmailMessagesForEmailAddressId.nextToken
        )
    }

    func listEmailMessagesForEmailFolderId(
        withInput input: ListEmailMessagesForEmailFolderIdInput
    ) async throws -> ListOutputEntity<SealedEmailMessageEntity> {
        let graphQLInput = GraphQL.ListEmailMessagesForEmailFolderIdInput(
            dateRange: input.dateRange?.toGraphQL(),
            folderId: input.emailFolderId,
            limit: input.limit,
            nextToken: input.nextToken,
            sortOrder: input.sortOrder?.toGraphQL()
        )
        let query = GraphQL.ListEmailMessagesForEmailFolderIdQuery(input: graphQLInput)
        let cachePolicy = input.cachePolicy ?? .remoteOnly
        let cachePolicyTransformer = CachePolicyAPITransformer()
        let queryCachePolicy = cachePolicyTransformer.transform(cachePolicy)
        let (fetchResult, fetchError) = try await self.appSyncClient.fetch(
            query: query,
            cachePolicy: queryCachePolicy
        )
        if let error = fetchError {
            switch error {
            case ApiOperationError.graphQLError(let cause):
                guard let sudoEmailError = SudoEmailError(graphQLError: cause) else {
                    throw SudoEmailError.internalError("Unexpected error: \(error)")
                }
                throw sudoEmailError
            default:
                throw SudoEmailError.fromApiOperationError(error: error)
            }
        }
        let sealedEmailMessages = fetchResult?.data?.listEmailMessagesForEmailFolderId.items ?? []
        let transformer = SealedEmailMessageEntityTransformer()
        let sealedEmailMessageEntities = try sealedEmailMessages.map(transformer.transform(_:))
        return ListOutputEntity(
            items: sealedEmailMessageEntities,
            nextToken: fetchResult?.data?.listEmailMessagesForEmailFolderId.nextToken
        )
    }

    func fetchEmailMessageRFC822Data(_ id: String, emailAddressId: String) async throws -> Data? {
        guard let sealedEmailMessage = try await self.getEmailMessageQuery(id: id, cachePolicy: .fetchIgnoringCacheData) else {
            return nil
        }
        guard let s3Key = await getS3KeyForEmailMessageId(id, emailAddressId: emailAddressId, publicKeyId: sealedEmailMessage.keyId) else {
            throw SudoEmailError.notSignedIn
        }
        let rfc822Data = try await self.s3Worker.download(bucket: emailBucket, key: s3Key)
        return rfc822Data
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
        let sealedData =  downloaded.body
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

    func listDraftsMetadata(emailAddressId: String) async throws -> [DraftEmailMessageMetadataEntity] {
        guard let s3KeyPrefix = await getS3KeyForEmailAddressId(emailAddressId: emailAddressId) else {
            throw SudoEmailError.internalError("Unable to find identity id")
        }
        let s3Key = "\(s3KeyPrefix)/draft/"
        do {
            let result = try await s3Worker.list(bucket: emailBucket, key: s3Key)
            let transformer = DraftEmailMetadataEntityTransformer()
            return try result.map { r in
                return try transformer.transform(awsS3Object: r, s3KeyPrefix: s3Key)
            }
        } catch {
            throw SudoEmailError.internalError(error.localizedDescription)
        }
    }

    func subscribeToEmailMessageCreated(
        withDirection direction: DirectionEntity? = nil,
        resultHandler: @escaping ClientCompletion<SealedEmailMessageEntity>
    ) async throws -> SubscriptionToken {
        let subscriptionId = UUID().uuidString
        let userId = try getUserId()
        let subscriptionStatusChangeHandler = constructStatusChangeHandlerWithSubscriptionId(subscriptionId, resultHandler: resultHandler)
        if let direction = direction {
            let directionTransformer = EmailMessageDirectionGQLTransformer()
            let graphQLDirection = directionTransformer.transform(direction)
            let graphQLSubscription = GraphQL.OnEmailMessageCreatedWithDirectionSubscription(owner: userId, direction: graphQLDirection)
            let subscriptionResultHandler = constructSubscriptionResultHandler(
                type: GraphQL.OnEmailMessageCreatedWithDirectionSubscription.self,
                transform: { graphQL in
                    guard let message = graphQL.onEmailMessageCreated else {
                        return nil
                    }
                    let transformer = SealedEmailMessageEntityTransformer()
                    return try transformer.transform(message)
                },
                resultHandler: resultHandler
            )
            return try await subscribeWithId(
                subscriptionId,
                subscription: graphQLSubscription,
                statusChangeHandler: subscriptionStatusChangeHandler,
                resultHandler: subscriptionResultHandler
            )
        } else {
            let graphQLSubscription = GraphQL.OnEmailMessageCreatedSubscription(owner: userId)
            let subscriptionResultHandler = constructSubscriptionResultHandler(
                type: GraphQL.OnEmailMessageCreatedSubscription.self,
                transform: { graphQL -> SealedEmailMessageEntity? in
                    guard let message = graphQL.onEmailMessageCreated else {
                        return nil
                    }
                    let transformer = SealedEmailMessageEntityTransformer()
                    return try transformer.transform(message)
                },
                resultHandler: resultHandler
            )
            return try await subscribeWithId(
                subscriptionId,
                subscription: graphQLSubscription,
                statusChangeHandler: subscriptionStatusChangeHandler,
                resultHandler: subscriptionResultHandler
            )
        }
    }

    func subscribeToEmailMessageDeleted(
        withId id: String?,
        resultHandler: @escaping ClientCompletion<SealedEmailMessageEntity>
    ) async throws -> SubscriptionToken {
        let subscriptionId = UUID().uuidString
        let userId = try getUserId()
        let subscriptionStatusChangeHandler = constructStatusChangeHandlerWithSubscriptionId(subscriptionId, resultHandler: resultHandler)
        if let id = id {
            let graphQLSubscription = GraphQL.OnEmailMessageDeletedWithIdSubscription(owner: userId, id: id)
            let subscriptionResultHandler = constructSubscriptionResultHandler(
                type: GraphQL.OnEmailMessageDeletedWithIdSubscription.self,
                transform: { graphQL in
                    guard let message = graphQL.onEmailMessageDeleted else {
                        return nil
                    }
                    let transformer = SealedEmailMessageEntityTransformer()
                    return try transformer.transform(message)
                },
                resultHandler: resultHandler
            )
            return try await subscribeWithId(
                subscriptionId,
                subscription: graphQLSubscription,
                statusChangeHandler: subscriptionStatusChangeHandler,
                resultHandler: subscriptionResultHandler
            )
        } else {
            let graphQLSubscription = GraphQL.OnEmailMessageDeletedSubscription(owner: userId)
            let subscriptionResultHandler = constructSubscriptionResultHandler(
                type: GraphQL.OnEmailMessageDeletedSubscription.self,
                transform: { graphQL in
                    guard let message = graphQL.onEmailMessageDeleted else {
                        return nil
                    }
                    let transformer = SealedEmailMessageEntityTransformer()
                    return try transformer.transform(message)
                },
                resultHandler: resultHandler
            )
            return try await subscribeWithId(
                subscriptionId,
                subscription: graphQLSubscription,
                statusChangeHandler: subscriptionStatusChangeHandler,
                resultHandler: subscriptionResultHandler
            )
        }
    }

    func unsubscribeAll() {
        subscriptionManager.removeAllSubscriptions()
    }

    // MARK: - Helpers: Constructors - Subscriptions

    /// Construct the result handler for a subscription that returns an email message object that can be transformed to `SealedEmailMessage`.
    ///
    /// Transforms the graphQL data to a `SealedEmailMessage` via the input `transform` function. If the result of `transform` is `nil`, then a log will be
    /// warned, but nothing else will happen. If the `transform` function throws an error, the resultant error will be returned via the `resultHandler`.
    /// - Parameters:
    ///   - type: Type of the subscription that the result handler is being constructed for.
    ///   - transform: Transformation function to transform the result data of the
    ///   - resultHandler: Result handler from the called method, inverted from the API layer via the core layer.
    /// - Returns: Subscription result handler to call the graphql appsync subscription with.
    func constructSubscriptionResultHandler<S: GraphQLSubscription>(
        type: S.Type,
        transform: @escaping (S.Data) throws -> SealedEmailMessageEntity?,
        resultHandler: @escaping ClientCompletion<SealedEmailMessageEntity>
    ) -> SubscriptionResultHandler<S> {
        return { [weak self] result, _, error in
            guard let weakSelf = self else { return }
            let graphQLResultWorker = GraphQLResultWorker()
            let result = graphQLResultWorker.convertToResult(result, error: error)
            switch result {
            case let .success(data):
                do {
                    guard let entity = try transform(data) else {
                        weakSelf.logger.warning("Email message subscription received with no data")
                        return
                    }
                    resultHandler(.success(entity))
                } catch {
                    weakSelf.logger.error(error.localizedDescription)
                    resultHandler(.failure(error))
                }
            case let .failure(error):
                weakSelf.logger.error(error.localizedDescription)
                resultHandler(.failure(error))
            }
        }
    }

    /// Construct the status change handler for a subscription.
    /// - Parameters:
    ///   - subscriptionId: Identifier of the subscription.
    ///   - resultHandler: Result handler of the
    /// - Returns: Result handler from the called method, inverted from the API layer via the core layer.
    func constructStatusChangeHandlerWithSubscriptionId(
        _ subscriptionId: String,
        resultHandler: @escaping ClientCompletion<SealedEmailMessageEntity>
    ) -> SubscriptionStatusChangeHandler {
        return { [weak self] status in
            switch status {
            case let .error(cause):
                let error = SudoEmailError.internalError(cause.errorDescription)
                resultHandler(.failure(error))
            case .disconnected:
                self?.subscriptionManager.removeSubscription(withId: subscriptionId)
            default:
                break
            }
        }
    }

    // MARK: - Helpers

    func getEmailMessageQuery(id: String, cachePolicy: AWSAppSync.CachePolicy) async throws -> SealedEmailMessageEntity? {
        let query = GraphQL.GetEmailMessageQuery(id: id)
        let (fetchResult, fetchError) = try await self.appSyncClient.fetch(query: query, cachePolicy: cachePolicy)
        guard let result = fetchResult?.data else {
            guard let error = fetchError else {
                return nil
            }
            throw SudoEmailError.internalError("\(error)")
        }
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

    func subscribeWithId<S: GraphQLSubscription>(
        _ subscriptionId: String,
        subscription: S,
        statusChangeHandler: @escaping SubscriptionStatusChangeHandler,
        resultHandler: @escaping SubscriptionResultHandler<S>
    ) async throws -> SubscriptionToken {
        do {
            let optionalCancellable = try await appSyncClient.subscribe(
                subscription: subscription,
                statusChangeHandler: statusChangeHandler,
                resultHandler: resultHandler
            )
            guard let cancellable = optionalCancellable else {
                throw SudoEmailError.internalError("No Cancellable object returned from subscription for OnEmailMessageSubscription")
            }
            return EmailSubscriptionToken(id: subscriptionId, cancellable: cancellable, manager: subscriptionManager)
        } catch {
            throw SudoEmailError.internalError(error.localizedDescription)
        }
    }

    /// Get the userId property from `SudoUserClient.`
    /// - Throws: `SudoEmailError.notSignedIn` if cannot retrieve the subject.
    /// - Returns: Owner property.
    func getUserId() throws -> String {
        let userId: String
        do {
            guard let uid = try userClient.getSubject() else {
                throw SudoEmailError.internalError("user subject is nil")
            }
            userId = uid
        } catch {
            logger.error("Failed to get user subject: \(error.localizedDescription)")
            throw SudoEmailError.notSignedIn
        }
        return userId
    }

    /// Generate an S3 key to use when sending an email message to the transient bucket.
    func getS3KeyForEmailAddressId(emailAddressId: String) async -> String? {
        guard let identityId = await self.userClient.getIdentityId() else {
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
