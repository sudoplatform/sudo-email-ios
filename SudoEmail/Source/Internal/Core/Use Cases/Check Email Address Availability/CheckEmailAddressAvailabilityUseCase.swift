//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
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

    func execute(withLocalParts localParts: [String], domains: [DomainEntity]?, completion: @escaping ClientCompletion<[EmailAddressEntity]>) {
        emailAccountRepository.checkEmailAddressAvailabilityWithLocalParts(localParts, domains: domains, completion: completion)
    }
}
