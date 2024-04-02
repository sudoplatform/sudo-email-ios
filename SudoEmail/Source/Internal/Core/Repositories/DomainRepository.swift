//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a domain repository used in business logic. Used to access supported domains.
protocol DomainRepository: AnyObject {

    /// Get the supported domains. Gets the domains locally from the cache of the device.
    /// - Parameter completion: Returns an array of the supported domains, or failure on error.
    func getSupportedDomains() async throws -> [DomainEntity]

    /// Get the supported domains. Fetches the domains remotely from the email service.
    /// - Parameter completion: Returns an array of the supported domains, or failure on error.
    func fetchSupportedDomains() async throws -> [DomainEntity]

}
