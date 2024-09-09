//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core use case representation of an operation to get configured domains.
///
/// Gets the configured domains locally from the device.
class GetConfiguredDomainsUseCase {

    // MARK: - Properties

    /// Domain repository to access the email domains from the service.
    let domainRepository: DomainRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `GetConfiguredDomainsUseCase`.
    init(domainRepository: DomainRepository) {
        self.domainRepository = domainRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Returns: A list of the configured domains from the cache of the device.
    func execute() async throws -> [DomainEntity] {
        return try await domainRepository.getConfiguredDomains()
    }
}
