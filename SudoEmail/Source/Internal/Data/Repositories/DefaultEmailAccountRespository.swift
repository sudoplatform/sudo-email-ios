//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync
import SudoLogging
import SudoOperations

/// Data implementation of the core `EmailAccountRepository`.
///
/// Allows manipulation of data on the email service, via AppSync GraphQL.
class DefaultEmailAccountRepository: EmailAccountRepository, Resetable {

    // MARK: - Properties

    /// App sync client for peforming operations against the email service.
    var appSyncClient: AWSAppSyncClient

    /// Used to log diagnostic and error information.
    var logger: Logger

    /// Utility factory class to generate mutation and query operations.
    var operationFactory = OperationFactory()

    /// Operation queue for enqueuing asynchronous tasks.
    var queue = PlatformOperationQueue()

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultEmailAccountRepository`.
    init(appSyncClient: AWSAppSyncClient, logger: Logger = .emailSDKLogger) {
        self.appSyncClient = appSyncClient
        self.logger = logger
    }

    func reset() {
        queue.cancelAllOperations()
    }

    // MARK: - EmailAccountRepository

    func createWithEmailAddress(
        _ emailAddress: EmailAddressEntity,
        publicKey: KeyEntity,
        ownershipProof: String,
        completion: @escaping ClientCompletion<EmailAccountEntity>
    ) {
        let input = ProvisionEmailAddressInput(address: emailAddress.address, keyRingId: publicKey.keyRingId, ownerProofs: [ownershipProof])
        let mutation = ProvisionEmailAddressMutation(input: input)
        let operation = operationFactory.generateMutationOperation(mutation: mutation, appSyncClient: appSyncClient, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation] _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = operation.result else {
                return
            }
            do {
                let transformer = EmailAccountEntityTransformer()
                let entity = try transformer.transform(result)
                completion(.success(entity))
            } catch {
                completion(.failure(error))
            }
        })
        operation.addObserver(completionObserver)
        queue.addOperation(operation)
    }

    func deleteWithEmailAddress(_ emailAddress: EmailAddressEntity, completion: @escaping ClientCompletion<EmailAccountEntity>) {
        let input = DeprovisionEmailAddressInput(address: emailAddress.address)
        let mutation = DeprovisionEmailAddressMutation(input: input)
        let operation = operationFactory.generateMutationOperation(mutation: mutation, appSyncClient: appSyncClient, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation] _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = operation.result else {
                return
            }
            do {
                let transformer = EmailAccountEntityTransformer()
                let entity = try transformer.transform(result)
                completion(.success(entity))
            } catch {
                completion(.failure(error))
            }
        })
        operation.addObserver(completionObserver)
        queue.addOperation(operation)
    }

    func getWithEmailAddress(_ emailAddress: EmailAddressEntity, completion: @escaping ClientCompletion<EmailAccountEntity?>) {
        let operation = constructGetEmailAddressQueryOperationWithEmailAddress(emailAddress, cachePolicy: .useCache, completion: completion)
        queue.addOperation(operation)
    }

    func fetchWithEmailAddress(_ emailAddress: EmailAddressEntity, completion: @escaping ClientCompletion<EmailAccountEntity?>) {
        let operation = constructGetEmailAddressQueryOperationWithEmailAddress(emailAddress, cachePolicy: .useOnline, completion: completion)
        queue.addOperation(operation)
    }

    func fetchListWithFilter(
        _ filter: EmailAccountFilterEntity?,
        limit: Int?,
        nextToken: String?,
        completion: @escaping ClientCompletion<ListOutputEntity<EmailAccountEntity>>
    ) {
        let operation = constructListEmailAddressQueryOperationWithFilter(
            filter,
            limit: limit,
            nextToken: nextToken,
            cachePolicy: .useOnline,
            completion: completion
        )
        queue.addOperation(operation)
    }

    func listWithFilter(
        _ filter: EmailAccountFilterEntity?,
        limit: Int?,
        nextToken: String?,
        completion: @escaping ClientCompletion<ListOutputEntity<EmailAccountEntity>>
    ) {
        let operation = constructListEmailAddressQueryOperationWithFilter(
            filter,
            limit: limit,
            nextToken: nextToken,
            cachePolicy: .useCache,
            completion: completion
        )
        queue.addOperation(operation)
    }

    // MARK: - Helpers

    func constructGetEmailAddressQueryOperationWithEmailAddress(
        _ emailAddress: EmailAddressEntity,
        cachePolicy: CachePolicy,
        completion: @escaping ClientCompletion<EmailAccountEntity?>
    ) -> PlatformQueryOperation<GetEmailAddressQuery> {
        let query = GetEmailAddressQuery(address: emailAddress.address)
        let operation = operationFactory.generateQueryOperation(query: query, appSyncClient: appSyncClient, cachePolicy: cachePolicy, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation] _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let graphQLResult = operation.result?.getEmailAddress else {
                return completion(.success(nil))
            }
            do {
                let transformer = EmailAccountEntityTransformer()
                let result = try transformer.transform(graphQLResult)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        })
        operation.addObserver(completionObserver)
        return operation
    }

    /// Constructs a `ListEmailAddressesQuery` operation to perform the work to access the email accounts.
    /// - Parameters:
    ///   - filter: Filter rules to be applied to the list.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    ///   - cachePolicy: Policy to be used to detemine whether to access from the service or the cache.
    ///   - completion: Returns a list of results with a next token is there if more results to fetch, or error on failure.
    /// - Returns: Constructed operation.
    func constructListEmailAddressQueryOperationWithFilter(
        _ filter: EmailAccountFilterEntity?,
        limit: Int?,
        nextToken: String?,
        cachePolicy: CachePolicy,
        completion: @escaping ClientCompletion<ListOutputEntity<EmailAccountEntity>>
    ) -> PlatformQueryOperation<ListEmailAddressesQuery> {
        var inputFilter: EmailAddressFilterInput?
        if let filter = filter {
            let transformer = EmailAddressFilterInputGQLTransformer()
            inputFilter = transformer.transform(filter)
        }
        let query = ListEmailAddressesQuery(filter: inputFilter, limit: limit, nextToken: nextToken)
        let operation = operationFactory.generateQueryOperation(query: query, appSyncClient: appSyncClient, cachePolicy: cachePolicy, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            var emailAccountEntities: [EmailAccountEntity] = []
            if let emailAddresses = operation.result?.listEmailAddresses.items {
                let transformer = EmailAccountEntityTransformer()
                do {
                    emailAccountEntities = try emailAddresses.map(transformer.transform(_:))
                } catch {
                    completion(.failure(error))
                    return
                }
            }
            let nextToken = operation.result?.listEmailAddresses.nextToken
            let output = ListOutputEntity(items: emailAccountEntities, nextToken: nextToken)
            completion(.success(output))
        })
        operation.addObserver(completionObserver)
        return operation
    }
}
