//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core use case representation of an operation to fetch email alias domains.
///
/// Fetches the email alias domains from the email service remotely.
class FetchEmailAliasDomainsUseCase {

    // MARK: - Properties

    /// Domain repository to access the email alias domains from the service.
    let domainRepository: DomainRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `FetchEmailAliasDomainsUseCase`.
    init(domainRepository: DomainRepository) {
        self.domainRepository = domainRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Returns: A list of the email alias domains from the email service.
    func execute() async throws -> [DomainEntity] {
        return try await domainRepository.fetchEmailAliasDomains()
    }
}
