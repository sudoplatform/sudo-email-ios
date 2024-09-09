//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoApiClient
import SudoLogging

/// Queue to handle the result events from AWS.
private let dispatchQueue = DispatchQueue(label: "com.sudoplatform.query-result-handler-queue")

/// Data implementation of the core `DomainRepository`.
///
/// Allows access of data from the email service and device cache, via AppSync GraphQL.
class DefaultDomainRepsitory: DomainRepository {

    // MARK: - Properties

    /// App sync client for peforming operations against the email service.
    var appSyncClient: SudoApiClient

    /// Used to log diagnostic and error information.
    var logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultEmailAccountRepository`.
    init(appSyncClient: SudoApiClient, logger: Logger = .emailSDKLogger) {
        self.appSyncClient = appSyncClient
        self.logger = logger
    }

    // MARK: - DomainRepository

    func getSupportedDomains() async throws -> [DomainEntity] {
        return try await performGetSupportedEmailDomainsQuery(cachePolicy: CachePolicy.cacheOnly)
    }

    func fetchSupportedDomains() async throws -> [DomainEntity] {
        return try await performGetSupportedEmailDomainsQuery(cachePolicy: CachePolicy.remoteOnly)
    }
    
    func getConfiguredDomains() async throws -> [DomainEntity] {
        return try await performGetConfiguredEmailDomainsQuery(cachePolicy: CachePolicy.cacheOnly)
    }

    func fetchConfiguredDomains() async throws -> [DomainEntity] {
        return try await performGetConfiguredEmailDomainsQuery(cachePolicy: CachePolicy.remoteOnly)
    }

    // MARK: - Helpers

    /// Perform a `GetEmailDomainsQuery` with specified cache policy
    /// - Parameters:
    ///   - cachePolicy specifies whether to use local cache or get results from the server
    /// - Returns: A list of supported email domains
    private func performGetSupportedEmailDomainsQuery(cachePolicy: CachePolicy) async throws -> [DomainEntity] {
        let query = GraphQL.GetEmailDomainsQuery()
        let cachePolicyTransformer = CachePolicyAPITransformer()
        let queryCachePolicy = cachePolicyTransformer.transform(cachePolicy)
        let (fetchResult, fetchError) = try await self.appSyncClient.fetch(
            query: query,
            cachePolicy: queryCachePolicy,
            queue: dispatchQueue
        )
        guard let result = fetchResult?.data else {
            guard let error = fetchError else {
                return []
            }
            throw SudoEmailError.internalError("\(error)")
        }
        let transformer = DomainEntityTransformer()
        return result.getEmailDomains.domains.map(transformer.transform(_:))
    }
    
    /// Perform a `GetConfiguredEmailDomainsQuery` with specified cache policy
    /// - Parameters:
    ///   - cachePolicy specifies whether to use local cache or get results from the server
    /// - Returns: A list of configured email domains
    private func performGetConfiguredEmailDomainsQuery(cachePolicy: CachePolicy) async throws -> [DomainEntity] {
        let query = GraphQL.GetConfiguredEmailDomainsQuery()
        let cachePolicyTransformer = CachePolicyAPITransformer()
        let queryCachePolicy = cachePolicyTransformer.transform(cachePolicy)
        let (fetchResult, fetchError) = try await self.appSyncClient.fetch(
            query: query,
            cachePolicy: queryCachePolicy,
            queue: dispatchQueue
        )
        guard let result = fetchResult?.data else {
            guard let error = fetchError else {
                return []
            }
            throw SudoEmailError.internalError("\(error)")
        }
        let transformer = DomainEntityTransformer()
        return result.getConfiguredEmailDomains.domains.map(transformer.transform(_:))
    }

}
