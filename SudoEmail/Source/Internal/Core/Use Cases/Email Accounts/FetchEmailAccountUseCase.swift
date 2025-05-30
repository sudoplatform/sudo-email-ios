//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

class FetchEmailAccountUseCase {

    // MARK: - Properties

    let emailAccountRepository: EmailAccountRepository

    // MARK: - Lifecycle

    init(emailAccountRepository: EmailAccountRepository) {
        self.emailAccountRepository = emailAccountRepository
    }

    // MARK: - Methods

    func execute(withEmailAddressId id: String) async throws -> EmailAccountEntity? {
        return try await emailAccountRepository.fetchWithEmailAddressId(id)
    }
}
