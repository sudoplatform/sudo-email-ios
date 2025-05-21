//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

class CancelScheduledDraftMessageUseCase {

    // MARK: - Properties

    let emailMessageRepository: EmailMessageRepository
    let emailAccountRepository: EmailAccountRepository

    // MARK: - Lifecycle

    init(emailMessageRepository: EmailMessageRepository, emailAccountRepository: EmailAccountRepository) {
        self.emailMessageRepository = emailMessageRepository
        self.emailAccountRepository = emailAccountRepository
    }

    // MARK: - Methods

    func execute(withInput input: CancelScheduledDraftMessageInput) async throws -> String {
        guard try (await emailAccountRepository.fetchWithEmailAddressId(input.emailAddressId)) != nil else {
            throw SudoEmailError.addressNotFound
        }
        return try await emailMessageRepository.cancelScheduledDraftMessage(withInput: input)
    }
}
