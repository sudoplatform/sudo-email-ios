//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core use case representation of a operation to fetch supported domains.
///
/// Fetches the domains from the email service remotely.
class FetchSupportedDomainsUseCase {

    // MARK: - Properties

    /// Domain repository to access the supported domains.
    let domainRepository: DomainRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `FetchSupportedDomainsUseCase`.
    init(domainRepository: DomainRepository) {
        self.domainRepository = domainRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Returns: A list of the supported domains from the email service.
    func execute() async throws -> [DomainEntity] {
        return try await domainRepository.fetchSupportedDomains()
    }

}
