//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a blocked address repository used in business logic. Used to perform CRUD operations for blocked addresses.
protocol BlockedAddressRepository: AnyObject {
    
    /// Block the addresses for the given user
    /// - Parameters:
    ///  - addresses: A list of addresses to block in the format `local-part@domain`
    ///  - owner: The user blocking the addresses
    /// - Returns: BatchOperationResult with the results of the update
    func blockAddresses(addresses: [String], owner: String) async throws -> BatchOperationResult<String>
    
    /// Unblock the addresses for the given user
    /// - Parameters:
    ///   - addresses: A list of addresses to unblock in the format `local-part@domain`
    ///   - owner: The user unblocking the addresses
    /// - Returns: BatchOperationResult with the results of the update
    func unblockAddresses(addresses: [String], owner: String) async throws -> BatchOperationResult<String>
    
    /// Retrieve the email address blocklist for the given user
    ///
    /// - Parameters:
    ///  - owner: The user who owns the blocklist
    /// - Returns: List of blocked email addresses
    func getEmailAddressBlocklist(owner: String) async throws -> [String]
}
