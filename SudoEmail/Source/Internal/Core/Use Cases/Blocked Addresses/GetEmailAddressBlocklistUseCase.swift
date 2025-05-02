//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging
import SudoUser

/// Core use case representation of the operation to get an email address blocklist
class GetEmailAddressBlocklistUseCase {

    // MARK: - Properties

    /// Domain repository to access blocked addresses
    let blockedAddressRepository: BlockedAddressRepository

    /// Sudo User Client to look up user info
    let userClient: SudoUserClient

    let log: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `GetEmailAddressBlocklistUseCase`
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

    /// Execute the use case
    func execute() async throws -> [UnsealedBlockedAddress] {
        log.debug("execute")
        let owner = try await userClient.getSubject()

        if owner == nil {
            log.error("User not logged in")
            throw SudoEmailError.notSignedIn
        }

        return try await blockedAddressRepository.getEmailAddressBlocklist(owner: owner!)
    }
}
