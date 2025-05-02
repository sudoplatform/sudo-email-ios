//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoApiClient
import SudoLogging

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

    func fetchSupportedDomains() async throws -> [DomainEntity] {
        let query = GraphQL.GetEmailDomainsQuery()
        let result = try await fetch(query)
        let transformer = DomainEntityTransformer()
        return result.getEmailDomains.domains.map(transformer.transform(_:))
    }

    func fetchConfiguredDomains() async throws -> [DomainEntity] {
        let query = GraphQL.GetConfiguredEmailDomainsQuery()
        let result = try await fetch(query)
        let transformer = DomainEntityTransformer()
        return result.getConfiguredEmailDomains.domains.map(transformer.transform(_:))
    }
}
