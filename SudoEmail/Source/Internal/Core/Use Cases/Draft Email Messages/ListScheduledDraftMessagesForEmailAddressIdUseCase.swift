//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

class ListScheduledDraftMessagesForEmailAddressIdUseCase {

    // MARK: - Properties

    let emailMessageRepository: EmailMessageRepository

    // MARK: - Lifecycle

    init(emailMessageRepository: EmailMessageRepository) {
        self.emailMessageRepository = emailMessageRepository
    }

    // MARK: - Methods

    func execute(withInput input: ListScheduledDraftMessagesForEmailAddressIdInput) async throws -> ListOutputEntity<ScheduledDraftMessageEntity> {
        return try await emailMessageRepository.listScheduledDraftMessagesForEmailAddressId(withInput: input)
    }
}
