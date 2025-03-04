//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of the operation to get a list of public information objects for email addresses.
class LookupEmailAddressesPublicInfoUseCase {

    // MARK: - Properties

    /// Domain repository to access the email accounts.
    let emailAccountRepository: EmailAccountRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `LookupEmailAddressesPublicInfoUseCase`.
    init(emailAccountRepository: EmailAccountRepository) {
        self.emailAccountRepository = emailAccountRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - emailAddresses: A list of email address strings in format 'local-part@domain'.
    func execute(emailAddresses: [String], cachePolicy: CachePolicy) async throws -> [EmailAddressPublicInfoEntity] {
        return try await emailAccountRepository.lookupPublicInfo(emailAddresses: emailAddresses, cachePolicy: cachePolicy)
    }
}
