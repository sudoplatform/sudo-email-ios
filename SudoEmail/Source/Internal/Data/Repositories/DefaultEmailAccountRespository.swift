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

    func checkEmailAddressAvailabilityWithLocalParts(
        _ localParts: [String],
        domains: [DomainEntity]?,
        completion: @escaping ClientCompletion<[EmailAddressEntity]>
    ) {
        // Code is generated as a double nil so this mitigates problems with that.
        var convertedDomains: [String]?? = Optional(nil)
        if let domains = domains {
            convertedDomains = domains.map { $0.name }
        }
        let input = CheckEmailAddressAvailabilityInput(localParts: localParts, domains: convertedDomains)
        let query = CheckEmailAddressAvailabilityQuery(input: input)
        let operation = operationFactory.generateQueryOperation(query: query, appSyncClient: appSyncClient, cachePolicy: .remoteOnly, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation] _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = operation.result else {
                return
            }
            do {
                let transformer = EmailAddressEntityTransformer()
                let entities = try result.checkEmailAddressAvailability.addresses.map(transformer.transform(_:))
                completion(.success(entities))
            } catch {
                completion(.failure(error))
            }
        })
        operation.addObserver(completionObserver)
        queue.addOperation(operation)
    }

    func createWithEmailAddress(
        _ emailAddress: EmailAddressEntity,
        publicKey: KeyEntity,
        // TODO: RENAME all occurrences of `ownershipProof` to `ownershipProofToken`.
        ownershipProof: String,
        completion: @escaping ClientCompletion<EmailAccountEntity>
    ) {
        let input = ProvisionEmailAddressInput(emailAddress: emailAddress.address, keyRingId: publicKey.keyRingId, ownershipProofTokens: [ownershipProof])
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

    func deleteWithId(_ id: String, completion: @escaping ClientCompletion<EmailAccountEntity>) {
        let input = DeprovisionEmailAddressInput(emailAddressId: id)
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

    func getWithEmailAddressId(_ id: String, completion: @escaping ClientCompletion<EmailAccountEntity?>) {
        let operation = constructGetEmailAddressQueryOperationWithEmailAddressId(id, cachePolicy: .cacheOnly, completion: completion)
        queue.addOperation(operation)
    }

    func fetchWithEmailAddressId(_ id: String, completion: @escaping ClientCompletion<EmailAccountEntity?>) {
        let operation = constructGetEmailAddressQueryOperationWithEmailAddressId(id, cachePolicy: .remoteOnly, completion: completion)
        queue.addOperation(operation)
    }

    func fetchListWithSudoId(
        _ sudoId: String?,
        filter: EmailAccountFilterEntity?,
        limit: Int?,
        nextToken: String?,
        completion: @escaping ClientCompletion<ListOutputEntity<EmailAccountEntity>>
    ) {
        let operation = constructListEmailAddressQueryOperationWithSudoId(
            sudoId,
            filter: filter,
            limit: limit,
            nextToken: nextToken,
            cachePolicy: .remoteOnly,
            completion: completion
        )
        queue.addOperation(operation)
    }

    func listWithSudoId(
        _ sudoId: String?,
        filter: EmailAccountFilterEntity?,
        limit: Int?,
        nextToken: String?,
        completion: @escaping ClientCompletion<ListOutputEntity<EmailAccountEntity>>
    ) {
        let operation = constructListEmailAddressQueryOperationWithSudoId(
            sudoId,
            filter: filter,
            limit: limit,
            nextToken: nextToken,
            cachePolicy: .cacheOnly,
            completion: completion
        )
        queue.addOperation(operation)
    }

    // MARK: - Helpers

    func constructGetEmailAddressQueryOperationWithEmailAddressId(
        _ emailAddressId: String,
        cachePolicy: CachePolicy,
        completion: @escaping ClientCompletion<EmailAccountEntity?>
    ) -> PlatformQueryOperation<GetEmailAddressQuery> {
        let query = GetEmailAddressQuery(id: emailAddressId)
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
    func constructListEmailAddressQueryOperationWithSudoId(
        _ sudoId: String?,
        filter: EmailAccountFilterEntity?,
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
        let input = ListEmailAddressesInput(
            sudoId: sudoId,
            filter: inputFilter,
            limit: limit,
            nextToken: nextToken
        )
        let query = ListEmailAddressesQuery(input: input)
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
