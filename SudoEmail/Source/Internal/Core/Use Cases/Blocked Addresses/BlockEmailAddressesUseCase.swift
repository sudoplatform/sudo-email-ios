//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging
import SudoUser

/// Core use case representation of the operation to block email addresses for a user
class BlockEmailAddressesUseCase {

    // MARK: - Properties

    /// Domain repository to access blocked addresses
    let blockedAddressRepository: BlockedAddressRepository

    /// Sudo User Client to look up user info
    let userClient: SudoUserClient

    let log: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `BlockEmailAddressesUseCase`
    init(
        blockedAddressRepository: BlockedAddressRepository,
        userClient: SudoUserClient,
        log: Logger
    ) {
        self.blockedAddressRepository = blockedAddressRepository
        self.userClient = userClient
        self.log = log
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - addresses: A list of addresses to block in format `local-part@domain`.
    ///   - action: The action to take on incoming messages from the blocked address(es).
    ///   - emailAddressId: The id of the email address for which the blocked address is blocked. If not present, blocked address cannot send to any of owner's email addresses
    ///   - blockLevel: The level at which to block the address(es).
    /// addresses.
    func execute(
        addresses: [String],
        action: UnsealedBlockedAddress.BlockedAddressAction,
        emailAddressId: String?,
        blockLevel: BlockedEmailAddressLevel,
    ) async throws -> BatchOperationResult<String, String> {
        log.debug("execute: \(addresses) \(action) \(emailAddressId ?? "")")
        let owner = try await userClient.getSubject()

        if owner == nil {
            log.error("User not logged in")
            throw SudoEmailError.notSignedIn
        }

        return try await blockedAddressRepository.blockAddresses(
            addresses: addresses,
            action: action,
            owner: owner!,
            emailAddressId: emailAddressId,
            blockLevel: blockLevel
        )
    }
}
