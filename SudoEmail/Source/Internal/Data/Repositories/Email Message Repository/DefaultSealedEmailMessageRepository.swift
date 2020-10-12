//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSAppSync
import AWSS3
import SudoLogging
import SudoOperations
import SudoUser

/// Data implementation of the core `SealedEmailMessageRepository`.
///
/// Allows access and manipulation of email service via AppSync GraphQL and AWSS3.
class DefaultSealedEmailMessageRepository: SealedEmailMessageRepository, Resetable {

    // MARK: - Properties

    /// App sync client for peforming operations against the email service.
    let appSyncClient: AWSAppSyncClient

    /// Identifier of the identity bucket.
    let identityBucket: String

    /// Identifier of the transient bucket.
    let transientBucket: String

    /// String of region.
    let region: String

    /// User client used to access the identity id.
    let userClient: SudoUserClient

    /// Used to log diagnostic and error information.
    let logger: Logger

    /// Operation queue for enqueueing asynchronous tasks.
    var queue = PlatformOperationQueue()

    /// Utility factory class to generate mutation and query operations.
    var operationFactory: OperationFactory = OperationFactory()

    /// Utility class to unseal email messages.
    var unsealer: EmailMessageUnsealerService

    /// Utility class to manage subscriptions.
    let subscriptionManager: SubscriptionManager

    /// S3 transfer utility for uploading email messages to the user's S3 transient bucket.
    var s3TransferUtility: S3TransferUtility? {
        return try? AWSS3TransferUtility.generateWithUserClient(userClient)
    }

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultEmailMessageRepository`.
    init(
        unsealer: EmailMessageUnsealerService,
        subscriptionManager: SubscriptionManager = DefaultSubscriptionManager(),
        appSyncClient: AWSAppSyncClient,
        identityBucket: String,
        transientBucket: String,
        region: String,
        userClient: SudoUserClient,
        logger: Logger = .emailSDKLogger
    ) {
        self.unsealer = unsealer
        self.subscriptionManager = subscriptionManager
        self.appSyncClient = appSyncClient
        self.identityBucket = identityBucket
        self.transientBucket = transientBucket
        self.region = region
        self.userClient = userClient
        self.logger = logger
    }

    func reset() {
        queue.cancelAllOperations()
        subscriptionManager.removeAllSubscriptions()
    }

    // MARK: - SealedEmailMessageRepository

    func sendEmailMessage(withRFC822Data data: Data, emailAccountId: String, completion: @escaping ClientCompletion<String>) {
        guard let key = generateS3Key() else {
            completion(.failure(SudoEmailError.notSignedIn))
            return
        }
        // Generate Operations.
        guard let s3TransferUtility = s3TransferUtility else {
            completion(.failure(SudoEmailError.internalError("Error while instantiating S3 Transfer Utility")))
            return
        }
        let s3UploadOperation = S3UploadOperation(data: data, key: key, bucket: transientBucket, region: region, s3TransferUtility: s3TransferUtility)
        let sendEmailMessageOperation = SendEmailMessageOperation(
            emailAccountId: emailAccountId,
            appSyncClient: appSyncClient,
            operationFactory: operationFactory,
            logger: logger
        )
        // Add Dependencies.
        sendEmailMessageOperation.addDependency(s3UploadOperation)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned sendEmailMessageOperation] _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = sendEmailMessageOperation.resultObject else {
                return
            }
            completion(.success(result))
        })
        sendEmailMessageOperation.addObserver(completionObserver)
        queue.addOperations([s3UploadOperation, sendEmailMessageOperation], waitUntilFinished: false)
    }

    func deleteEmailMessage(withId id: String, completion: @escaping ClientCompletion<String>) {
        let input = DeleteEmailMessageInput(messageId: id)
        let mutation = DeleteEmailMessageMutation(input: input)
        let operation = operationFactory.generateMutationOperation(mutation: mutation, appSyncClient: appSyncClient, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation] _, errors in
            if let error = errors.first {
                completion(.failure(error))
            }
            guard let result = operation.result else {
                return
            }
            completion(.success(result.deleteEmailMessage))
        })
        operation.addObserver(completionObserver)
        queue.addOperation(operation)
    }

    func getEmailMessageById(_ id: String, keyId: String, completion: @escaping ClientCompletion<SealedEmailMessageEntity?>) {
        let operation = constructGetEmailMessageQueryOperationWithId(
            id,
            keyId: keyId,
            cachePolicy: .cacheOnly,
            completion: completion
        )
        queue.addOperation(operation)
    }

    func fetchEmailMessageById(_ id: String, keyId: String, completion: @escaping ClientCompletion<SealedEmailMessageEntity?>) {
        let operation = constructGetEmailMessageQueryOperationWithId(
            id,
            keyId: keyId,
            cachePolicy: .remoteOnly,
            completion: completion
        )
        queue.addOperation(operation)
    }

    func getListEmailMessagesBySudoId(
        _ sudoId: String?,
        emailAddressId: String?,
        filter: EmailMessageFilterEntity?,
        limit: Int?,
        nextToken: String?,
        completion: @escaping ClientCompletion<ListOutputEntity<SealedEmailMessageEntity>>
    ) {
        let operation = constructListEmailMessageQueryOperationWithSudoId(
            sudoId,
            emailAddressId: emailAddressId,
            filter: filter,
            limit: limit,
            nextToken: nextToken,
            cachePolicy: .cacheOnly,
            completion: completion
        )
        queue.addOperation(operation)
    }

    func fetchListEmailMessagesBySudoId(
        _ sudoId: String?,
        emailAddressId: String?,
        filter: EmailMessageFilterEntity?,
        limit: Int?,
        nextToken: String?,
        completion: @escaping ClientCompletion<ListOutputEntity<SealedEmailMessageEntity>>
    ) {
        let operation = constructListEmailMessageQueryOperationWithSudoId(
            sudoId,
            emailAddressId: emailAddressId,
            filter: filter,
            limit: limit,
            nextToken: nextToken,
            cachePolicy: .remoteOnly,
            completion: completion
        )
        queue.addOperation(operation)
    }

    func fetchEmailMessageRFC822DataWithId(_ id: String, completion: @escaping ClientCompletion<Data>) {
        guard let s3Key = getS3KeyForId(id) else {
            completion(.failure(SudoEmailError.notSignedIn))
            return
        }
        guard let s3TransferUtility = s3TransferUtility else {
            completion(.failure(SudoEmailError.internalError("Error while instantiating S3 Transfer Utility")))
            return
        }
        s3TransferUtility.downloadData(fromBucket: identityBucket, key: s3Key, expression: nil) { _, _, data, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(SudoEmailError.noEmailMessageRFC822Available))
                return
            }
            completion(.success(data))
        }
    }

    func subscribeToEmailMessageCreated(
        withDirection direction: DirectionEntity? = nil,
        resultHandler: @escaping ClientCompletion<SealedEmailMessageEntity>
    ) throws -> SubscriptionToken {
        let subscriptionId = UUID().uuidString
        let userId = try getUserId()
        let subscriptionStatusChangeHandler = constructStatusChangeHandlerWithSubscriptionId(subscriptionId, resultHandler: resultHandler)
        if let direction = direction {
            let directionTransformer = EmailMessageDirectionGQLTransformer()
            let graphQLDirection = directionTransformer.transform(direction)
            let graphQLSubscription = OnEmailMessageCreatedWithDirectionSubscription(userId: userId, direction: graphQLDirection)
            let subscriptionResultHandler = constructSubscriptionResultHandler(
                type: OnEmailMessageCreatedWithDirectionSubscription.self,
                transform: { graphQL in
                    guard let message = graphQL.onEmailMessageCreated else {
                        return nil
                    }
                    let transformer = SealedEmailMessageEntityTransformer()
                    return try transformer.transform(message)
                },
                resultHandler: resultHandler
            )
            return try subscribeWithId(
                subscriptionId,
                subscription: graphQLSubscription,
                statusChangeHandler: subscriptionStatusChangeHandler,
                resultHandler: subscriptionResultHandler
            )
        } else {
            let graphQLSubscription = OnEmailMessageCreatedSubscription(userId: userId)
            let subscriptionResultHandler = constructSubscriptionResultHandler(
                type: OnEmailMessageCreatedSubscription.self,
                transform: { graphQL -> SealedEmailMessageEntity? in
                    guard let message = graphQL.onEmailMessageCreated else {
                        return nil
                    }
                    let transformer = SealedEmailMessageEntityTransformer()
                    return try transformer.transform(message)
                },
                resultHandler: resultHandler
            )
            return try subscribeWithId(
                subscriptionId,
                subscription: graphQLSubscription,
                statusChangeHandler: subscriptionStatusChangeHandler,
                resultHandler: subscriptionResultHandler
            )
        }
    }

    func subscribeToEmailMessageDeleted(resultHandler: @escaping ClientCompletion<SealedEmailMessageEntity>) throws -> SubscriptionToken {
        let subscriptionId = UUID().uuidString
        let userId = try getUserId()
        let graphQLSubscription = OnEmailMessageDeletedSubscription(userId: userId)
        let subscriptionStatusChangeHandler = constructStatusChangeHandlerWithSubscriptionId(subscriptionId, resultHandler: resultHandler)
        let subscriptionResultHandler = constructSubscriptionResultHandler(
            type: OnEmailMessageDeletedSubscription.self,
            transform: { graphQL in
                guard let message = graphQL.onEmailMessageDeleted else {
                    return nil
                }
                let transformer = SealedEmailMessageEntityTransformer()
                return try transformer.transform(message)
            },
            resultHandler: resultHandler
        )
        return try subscribeWithId(
            subscriptionId,
            subscription: graphQLSubscription,
            statusChangeHandler: subscriptionStatusChangeHandler,
            resultHandler: subscriptionResultHandler
        )
    }

    // MARK: - Helpers: Constructors - Queries

    /// Construct a `GetEmailMessageQuery` operation to perform the work to access an email message.
    /// - Parameters:
    ///   - filter: Filter rules to be applied to the list.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    ///   - cachePolicy: Cache policy to access the data with.
    ///   - completion: Returns a list of results with a next token is there if more results to fetch, or error on failure.
    /// - Returns: Constructed operation.
    func constructGetEmailMessageQueryOperationWithId(
        _ id: String,
        keyId: String,
        cachePolicy: CachePolicy,
        completion: @escaping ClientCompletion<SealedEmailMessageEntity?>
    ) -> PlatformQueryOperation<GetEmailMessageQuery> {
        let sealedId = "\(id)-\(keyId)"
        let query = GetEmailMessageQuery(id: sealedId)
        let operation = operationFactory.generateQueryOperation(query: query, appSyncClient: appSyncClient, cachePolicy: cachePolicy, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation, weak self] _, errors in
            guard let weakSelf = self else { return }
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = operation.result?.getEmailMessage else {
                completion(.success(nil))
                return
            }
            do {
                let transformer = SealedEmailMessageEntityTransformer()
                let sealedEmailMessageEntity = try transformer.transform(result)
                completion(.success(sealedEmailMessageEntity))
            } catch {
                weakSelf.logger.error(error.localizedDescription)
                completion(.failure(error))
            }
        })
        operation.addObserver(completionObserver)
        return operation
    }

    /// Construct a `ListEmailMessagesQuery` operation to perform the work to access a list of email messages.
    /// - Parameters:
    ///   - id: Identifier of the email message to query.
    ///   - keyId: Key identifier of the email message to query.
    ///   - cachePolicy: Cache policy to access the data with.
    ///   - completion: Returns the found email message, `nil` if it could not be found, or error on failure.
    /// - Returns: Constructed operation.
    func constructListEmailMessageQueryOperationWithSudoId(
        _ sudoId: String?,
        emailAddressId: String?,
        filter: EmailMessageFilterEntity?,
        limit: Int?,
        nextToken: String?,
        cachePolicy: CachePolicy,
        completion: @escaping ClientCompletion<ListOutputEntity<SealedEmailMessageEntity>>
    ) -> PlatformQueryOperation<ListEmailMessagesQuery> {
        var inputFilter: EmailMessageFilterInput?
        if let filter = filter {
            let transformer = EmailMessageFilterInputGQLTransformer()
            inputFilter = transformer.transform(filter)
        }
        let input = ListEmailMessagesInput(
            sudoId: sudoId,
            emailAddressId: emailAddressId,
            filter: inputFilter,
            limit: limit,
            nextToken: nextToken
        )
        let query = ListEmailMessagesQuery(input: input)
        let operation = operationFactory.generateQueryOperation(query: query, appSyncClient: appSyncClient, cachePolicy: cachePolicy, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [weak self] _, errors in
            guard let weakSelf = self else { return }
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let data = operation.result else {
                completion(.success(ListOutputEntity(items: [], nextToken: nil)))
                return
            }
            let result = weakSelf.handleListEmailMessageQueryData(data)
            completion(result)
        })
        operation.addObserver(completionObserver)
        return operation
    }

    /// Handle the data from `ListEmailMessagesQuery`.
    func handleListEmailMessageQueryData(_ data: ListEmailMessagesQuery.Data) -> Swift.Result<ListOutputEntity<SealedEmailMessageEntity>, Error> {
        let graphQL = data.listEmailMessages
        let emailMessageEntities: [SealedEmailMessageEntity]
        do {
            let transformer = SealedEmailMessageEntityTransformer()
            emailMessageEntities = try graphQL.items.map(transformer.transform(_:))
        } catch {
            logger.error(error.localizedDescription)
            return .failure(error)
        }
        let nextToken = data.listEmailMessages.nextToken
        let output = ListOutputEntity(items: emailMessageEntities, nextToken: nextToken)
        return .success(output)
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

    func subscribeWithId<S: GraphQLSubscription>(
        _ subscriptionId: String,
        subscription: S,
        statusChangeHandler: @escaping SubscriptionStatusChangeHandler,
        resultHandler: @escaping SubscriptionResultHandler<S>
    ) throws -> SubscriptionToken {
        let subscriptionId = UUID().uuidString
        do {
            let optionalCancellable = try appSyncClient.subscribe(
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
    func generateS3Key() -> String? {
        let generatedId = UUID().uuidString
        return getS3KeyForId(generatedId)
    }

    /// Get the key to access items in the email S3 bucket.
    /// - Returns: S3 key identifier if the user is signed in, otherwise `nil`.
    func getS3KeyForId(_ id: String) -> String? {
        guard let identityId = userClient.getIdentityId() else {
            return nil
        }
        return "\(identityId)/email/\(id)"
    }

}
