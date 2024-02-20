//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoUser
import SudoLogging

/// Core use case representation of the operation to unblock email addresses for a user
class UnblockEmailAddressesByHashedValueUseCase {
    
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
    ///   - hashedValues: A list of hashed addresses to unblock
    func execute(hashedValues: [String]) async throws -> BatchOperationResult<String> {
        self.log.debug("execute: \(hashedValues)")
        let owner = try self.userClient.getSubject()
        
        if (owner == nil) {
            self.log.error("User not logged in")
            throw SudoEmailError.notSignedIn
        }
        
        if (hashedValues.isEmpty) {
            self.log.error("At least one email address must be passed")
            throw SudoEmailError.invalidArgument("At least one email address must be passed")
        }
        
        return try await self.blockedAddressRepository.unblockAddresses(hashedAddresses: hashedValues, owner: owner!)
    }
}
