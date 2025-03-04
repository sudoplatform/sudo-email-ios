//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

class UpdateDraftEmailMessageUseCase {

    // MARK: - Properties

    let emailMessageRepository: EmailMessageRepository
    let emailAccountRepository: EmailAccountRepository

    // MARK: - Lifecycle

    init(
        emailMessageRepository: EmailMessageRepository,
        emailAccountRepository: EmailAccountRepository
    ) {
        self.emailMessageRepository = emailMessageRepository
        self.emailAccountRepository = emailAccountRepository
    }

    // MARK: - Methods

    func execute(
        withInput input: UpdateDraftEmailMessageInput
    ) async throws -> DraftEmailMessageMetadata {
        guard try (
            await emailAccountRepository.fetchWithEmailAddressId(input.senderEmailAddressId)
        ) != nil else {
            throw SudoEmailError.addressNotFound
        }
        if try !(await emailMessageRepository.draftExists(
            id: input.id,
            emailAddressId: input.senderEmailAddressId
        )) {
            throw SudoEmailError.emailMessageNotFound
        }
        let metadata = try await emailMessageRepository.saveDraft(
            rfc822Data: input.rfc822Data,
            senderEmailAddressId: input.senderEmailAddressId,
            id: input.id
        )
        return DraftEmailMessageMetadata(
            id: metadata.id,
            emailAddressId: metadata.emailAddressId,
            updatedAt: metadata.updatedAt
        )
    }
}
