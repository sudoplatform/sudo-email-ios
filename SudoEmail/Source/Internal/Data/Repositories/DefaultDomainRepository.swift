//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync
import SudoOperations
import SudoLogging

/// Data implementation of the core `DomainRepository`.
///
/// Allows access of data from the email service and device cache, via AppSync GraphQL.
class DefaultDomainRepsitory: DomainRepository, Resetable {

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

    // MARK: - DomainRepository

    func getSupportedDomains(completion: @escaping ClientCompletion<[DomainEntity]>) {
        let operation = constructQueryOperationWithCachePolicy(.cacheOnly, completion: completion)
        queue.addOperation(operation)
    }

    func fetchSupportedDomains(completion: @escaping ClientCompletion<[DomainEntity]>) {
        let operation = constructQueryOperationWithCachePolicy(.remoteOnly, completion: completion)
        queue.addOperation(operation)
    }

    // MARK: - Helpers

    /// Construct a `GetEmailDomainsQuery` operation to perform the work to access the supported domains.
    /// - Parameters:
    ///   - cachePolicy: Cache policy to use for data access.
    ///   - completion: Completion from the repository call.
    /// - Returns: Constructed operation.
    func constructQueryOperationWithCachePolicy(
        _ cachePolicy: CachePolicy,
        completion: @escaping ClientCompletion<[DomainEntity]>
    ) -> PlatformQueryOperation<GetEmailDomainsQuery> {
        let query = GetEmailDomainsQuery()
        let operation = operationFactory.generateQueryOperation(query: query, appSyncClient: appSyncClient, cachePolicy: cachePolicy, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            var domainEntities: [DomainEntity] = []
            if let domains = operation.result?.getEmailDomains.domains {
                domainEntities = domains.map(DomainEntity.init(name:))
            }
            completion(.success(domainEntities))
        })
        operation.addObserver(completionObserver)
        return operation
    }

}
