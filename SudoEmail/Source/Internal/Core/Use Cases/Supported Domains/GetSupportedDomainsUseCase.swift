//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core use case representation of a operation to get supported domains.
///
/// Gets the supported domains locally from the device.
class GetSupportedDomainsUseCase {

    // MARK: - Properties

    /// Domain repository to access the supported domains.
    let domainRepository: DomainRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `GetSupportedDomainsUseCase`.
    init(domainRepository: DomainRepository) {
        self.domainRepository = domainRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameter completion: Returns a list of the supported domains from the cache of the device.
    func execute(completion: @escaping ClientCompletion<[DomainEntity]>) {
        domainRepository.getSupportedDomains(completion: completion)
    }

}
