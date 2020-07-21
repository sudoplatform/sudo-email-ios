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

    func execute(withEmailAddress emailAddress: EmailAddressEntity, completion: @escaping ClientCompletion<EmailAccountEntity?>) {
        emailAccountRepository.fetchWithEmailAddress(emailAddress, completion: completion)
    }
}
