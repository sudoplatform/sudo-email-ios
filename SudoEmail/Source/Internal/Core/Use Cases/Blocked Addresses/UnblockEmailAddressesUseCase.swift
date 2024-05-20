//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoUser
import SudoLogging

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
        self.log.debug("execute: \(addresses)")
        let owner = try self.userClient.getSubject()
        
        if (owner == nil) {
            self.log.error("User not logged in")
            throw SudoEmailError.notSignedIn
        }
        
        if (addresses.isEmpty) {
            self.log.error("At least one email address must be passed")
            throw SudoEmailError.invalidArgument("At least one email address must be passed")
        }
        
        var normalizedAddresses: [String] = []
        var hashedAddresses: [String] = []
        
        try addresses.forEach { address in
            let normalizedAddress = try EmailAddressParser.normalize(address: address)
            if(normalizedAddresses.contains(normalizedAddress)) {
                self.log.error("Duplicate email address found")
                throw SudoEmailError.invalidArgument("Duplicate email address found. Please include each address only once")
            }
            normalizedAddresses.append(normalizedAddress)
            try hashedAddresses.append(EmailAddressBlocklistUtil.generateAddressHash(plaintextAddress: normalizedAddress, ownerId: owner!))
        }
        
        return try await self.blockedAddressRepository.unblockAddresses(hashedAddresses: hashedAddresses, owner: owner!)
    }
}
