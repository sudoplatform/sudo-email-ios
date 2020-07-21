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

    func execute(withEmailAddress emailAddress: EmailAddressEntity, completion: @escaping ClientCompletion<EmailAccountEntity?>) {
        emailAccountRepository.getWithEmailAddress(emailAddress, completion: completion)
    }
}
