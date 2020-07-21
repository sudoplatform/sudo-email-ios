//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a domain repository used in business logic. Used to access supported domains.
protocol DomainRepository: class {

    /// Get the supported domains. Gets the domains locally from the cache of the device.
    /// - Parameter completion: Returns an array of the supported domains, or failure on error.
    func getSupportedDomains(completion: @escaping ClientCompletion<[DomainEntity]>)

    /// Get the supported domains. Fetches the domains remotely from the email service.
    /// - Parameter completion: Returns an array of the supported domains, or failure on error.
    func fetchSupportedDomains(completion: @escaping ClientCompletion<[DomainEntity]>)

}
