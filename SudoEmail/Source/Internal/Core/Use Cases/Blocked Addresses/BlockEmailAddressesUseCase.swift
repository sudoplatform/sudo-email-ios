//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoUser
import SudoLogging

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
    func execute(addresses: [String]) async throws -> BatchOperationResult<String, String> {
        self.log.debug("execute: \(addresses)")
        let owner = try self.userClient.getSubject()
        
        if (owner == nil) {
            self.log.error("User not logged in")
            throw SudoEmailError.notSignedIn
        }
        
        return try await self.blockedAddressRepository.blockAddresses(addresses: addresses, owner: owner!)
    }
}
