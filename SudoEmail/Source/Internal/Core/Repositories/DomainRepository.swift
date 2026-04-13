//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a domain repository used in business logic. Used to access supported domains.
protocol DomainRepository: Repository {

    /// Get the supported domains. Fetches the domains remotely from the email service.
    /// - Parameter completion: Returns an array of the supported domains, or failure on error.
    func fetchSupportedDomains() async throws -> [DomainEntity]

    /// Get the configured domains. Fetches the domains remotely from the email service.
    /// - Parameter completion: Returns an array of the configured domains, or failure on error.
    func fetchConfiguredDomains() async throws -> [DomainEntity]

    /// Get the set of domains configured for mask creation. Fetches the domains remotely from the email service.
    /// - Parameter completion: Returns an array of the mask domains, or failure on error.
    func fetchEmailMaskDomains() async throws -> [DomainEntity]

    /// List all email domains for the email service. Fetches the domains remotely from the email service.
    /// - Parameter completion: Returns an array of the email domains, or failure on error.
    func listEmailDomains() async throws -> [EmailDomainEntity]
}
