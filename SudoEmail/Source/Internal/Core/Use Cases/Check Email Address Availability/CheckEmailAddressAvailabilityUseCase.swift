//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

class CheckEmailAddressAvailabilityUseCase {

    // MARK: - Properties

    let emailAccountRepository: EmailAccountRepository

    // MARK: - Lifecycle

    init(emailAccountRepository: EmailAccountRepository) {
        self.emailAccountRepository = emailAccountRepository
    }

    // MARK: - Methods

    func execute(withLocalParts localParts: [String], domains: [DomainEntity]?) async throws -> [EmailAddressEntity] {
        return try await emailAccountRepository.checkEmailAddressAvailabilityWithLocalParts(localParts, domains: domains)
    }
}
