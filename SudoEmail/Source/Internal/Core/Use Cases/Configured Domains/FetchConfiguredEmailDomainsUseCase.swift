//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core use case representation of an operation to fetch configured domains.
///
/// Fetches the configured domains from the email service remotely.
class FetchConfiguredDomainsUseCase {

    // MARK: - Properties

    /// Domain repository to access the email domains from the service.
    let domainRepository: DomainRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `FetchConfiguredDomainsUseCase`.
    init(domainRepository: DomainRepository) {
        self.domainRepository = domainRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Returns: A list of the configured domains from the email service.
    func execute() async throws -> [DomainEntity] {
        return try await domainRepository.fetchConfiguredDomains()
    }
}
