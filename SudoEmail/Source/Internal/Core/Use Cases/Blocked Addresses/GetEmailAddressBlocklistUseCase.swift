//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoUser
import SudoLogging

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
        self.log.debug("execute")
        let owner = try self.userClient.getSubject()
        
        if (owner == nil) {
            self.log.error("User not logged in")
            throw SudoEmailError.notSignedIn
        }
        
        return try await self.blockedAddressRepository.getEmailAddressBlocklist(owner: owner!)
    }
}
