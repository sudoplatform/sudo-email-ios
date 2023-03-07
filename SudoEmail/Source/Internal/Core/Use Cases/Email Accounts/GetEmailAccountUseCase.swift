//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

class GetEmailAccountUseCase {

    // MARK: - Properties

    let emailAccountRepository: EmailAccountRepository

    // MARK: - Lifecycle

    init(emailAccountRepository: EmailAccountRepository) {
        self.emailAccountRepository = emailAccountRepository
    }

    // MARK: - Methods

    func execute(withEmailAddressId id: String) async throws -> EmailAccountEntity? {
        return try await emailAccountRepository.getWithEmailAddressId(id)
    }
}
