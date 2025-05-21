//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

class ScheduleSendDraftMessageUseCase {

    // MARK: - Properties

    let emailMessageRepository: EmailMessageRepository
    let emailAccountRepository: EmailAccountRepository

    // MARK: - Lifecycle

    init(emailMessageRepository: EmailMessageRepository, emailAccountRepository: EmailAccountRepository) {
        self.emailMessageRepository = emailMessageRepository
        self.emailAccountRepository = emailAccountRepository
    }

    // MARK: - Methods

    func execute(withInput input: ScheduleSendDraftMessageInput) async throws -> ScheduledDraftMessageEntity {
        guard try (await emailAccountRepository.fetchWithEmailAddressId(input.emailAddressId)) != nil else {
            throw SudoEmailError.addressNotFound
        }
        if input.sendAt.millisecondsSince1970 <= Date().millisecondsSince1970 {
            throw SudoEmailError.invalidArgument("sendAt must be in the future")
        }
        let result = try await emailMessageRepository.scheduleSendDraftMessage(withInput: input)
        return result
    }
}
