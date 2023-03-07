//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

class GetDraftEmailMessageUseCase {

    // MARK: - Properties

    let emailMessageRepository: EmailMessageRepository

    // MARK: - Lifecycle

    init(
        emailMessageRepository: EmailMessageRepository
    ) {
        self.emailMessageRepository = emailMessageRepository
    }

    // MARK: - Methods

    func execute(withInput input: GetDraftEmailMessageInput) async throws -> DraftEmailMessage? {
        let draftEmailMessage = try await emailMessageRepository.getDraft(withInput: input)
        return draftEmailMessage
    }
}
