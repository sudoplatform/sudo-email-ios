//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core use case representation of an operation to list email domains
class ListEmailDomainsUseCase {

    // MARK: - Properties

    /// Domain repository to access the email  domains from the service.
    let domainRepository: DomainRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `ListEmailDomainsUseCase`
    init(
        domainRepository: DomainRepository
    ) {
        self.domainRepository = domainRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Returns: List of `EmailDomainEntity` objects.
    func execute() async throws -> [EmailDomainEntity] {
        return try await domainRepository.listEmailDomains()
    }
}
