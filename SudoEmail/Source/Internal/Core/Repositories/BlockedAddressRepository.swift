//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a blocked address repository used in business logic. Used to perform CRUD operations for blocked addresses.
protocol BlockedAddressRepository: AnyObject {

    /// Block the addresses for the given user
    /// - Parameters:
    ///  - addresses: A list of addresses to block in the format `local-part@domain`
    ///  - action: The action to take on incoming messages from the blocked address(es).
    ///  - owner: The user blocking the addresses
    ///  - emailAddressId: The id of the email address for which the blocked address is blocked. If not present, blocked address cannot send to any of owner's
    /// addresses.
    /// - Returns: BatchOperationResult with the results of the update
    func blockAddresses(
        addresses: [String],
        action: UnsealedBlockedAddress.BlockedAddressAction,
        owner: String,
        emailAddressId: String?
    ) async throws -> BatchOperationResult<String, String>

    /// Unblock the addresses for the given user
    /// - Parameters:
    ///   - hashedAddresses: A list of hashed addresses to unblock
    ///   - owner: The user unblocking the addresses
    /// - Returns: BatchOperationResult with the results of the update
    func unblockAddresses(hashedAddresses: [String], owner: String) async throws -> BatchOperationResult<String, String>
    /// Unblock the addresses for the given user
    /// - Parameters:
    ///   - cleartextAddresses: A list of addresses to unblock.
    ///   - owner: The user unblocking the addresses
    /// - Returns: BatchOperationResult with the results of the update
    func unblockCleartextAddresses(cleartextAddresses: [String], owner: String) async throws -> BatchOperationResult<String, String>
    /// Retrieve the email address blocklist for the given user
    ///
    /// - Parameters:
    ///  - owner: The user who owns the blocklist
    /// - Returns: List of blocked email addresses
    func getEmailAddressBlocklist(owner: String) async throws -> [UnsealedBlockedAddress]
}
