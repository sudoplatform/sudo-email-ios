//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging
import SudoUser

/// Core use case representation of the operation to unblock email addresses for a user
class UnblockEmailAddressesUseCase {

    // MARK: - Properties

    /// Domain repository to access blocked addresses
    let blockedAddressRepository: BlockedAddressRepository

    /// Sudo User Client to look up user info
    let userClient: SudoUserClient

    let log: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `UnblockEmailAddressesUseCase`
    init(
        blockedAddressRepository: BlockedAddressRepository,
        userClient: SudoUserClient,
        log: Logger
    ) {
        self.blockedAddressRepository = blockedAddressRepository
        self.log = log
        self.userClient = userClient
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - addresses: A list of addresses to block in format `local-part@domain`.
    func execute(addresses: [String]) async throws -> BatchOperationResult<String, String> {
        log.debug("execute: \(addresses)")
        let owner = try userClient.getSubject()

        if owner == nil {
            log.error("User not logged in")
            throw SudoEmailError.notSignedIn
        }

        if addresses.isEmpty {
            log.error("At least one email address must be passed")
            throw SudoEmailError.invalidArgument("At least one email address must be passed")
        }

        return try await blockedAddressRepository.unblockCleartextAddresses(cleartextAddresses: addresses, owner: owner!)
    }
}
