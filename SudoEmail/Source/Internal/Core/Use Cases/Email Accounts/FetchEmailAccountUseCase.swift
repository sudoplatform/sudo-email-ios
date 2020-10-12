//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
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

    func execute(withEmailAddressId id: String, completion: @escaping ClientCompletion<EmailAccountEntity?>) {
        emailAccountRepository.fetchWithEmailAddressId(id, completion: completion)
    }
}
