//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SudoLogging

class DeleteDraftEmailMessagesUseCase {

    // MARK: - Properties

    let emailMessageRepository: EmailMessageRepository
    let emailAccountRepository: EmailAccountRepository
    let logger: Logger

    // MARK: - Lifecycle

    init(
        emailMessageRepository: EmailMessageRepository,
        emailAccountRepository: EmailAccountRepository
    ) {
        self.emailMessageRepository = emailMessageRepository
        self.emailAccountRepository = emailAccountRepository
        self.logger = .emailSDKLogger
    }

    // MARK: - Methods

    func execute(withInput input: DeleteDraftEmailMessagesInput) async throws -> BatchOperationResult<String> {
        guard (try await emailAccountRepository.fetchWithEmailAddressId(input.emailAddressId)) != nil else {
            throw SudoEmailError.addressNotFound
        }
        if input.ids.isEmpty {
            return BatchOperationResult<String>.success
        }

        if input.ids.count > deleteDraftsRequestLimit {
            throw SudoEmailError.limitExceeded
        }

        var deleteFailures: [String] = []
        var deleteSuccesses: [String] = []
        let emailAddressId = input.emailAddressId
        for id in input.ids {
            do {
                let deletedDraft = try await emailMessageRepository.deleteDraft(id: id, emailAddressId: emailAddressId)
                deleteSuccesses.append(deletedDraft)
            } catch {
                logger.error("Failed to delete draft \(id) with \(error)")
                deleteFailures.append(id)
            }
        }
        if deleteSuccesses.count == input.ids.count {
            return BatchOperationResult<String>.success
        }
        if deleteFailures.count == input.ids.count {
            return BatchOperationResult<String>.failure
        }
        let deletePartial = BatchOperationResult<String>.BatchOperationPartialResult(
            successItems: deleteSuccesses,
            failureItems: deleteFailures
        )
        return BatchOperationResult<String>.partial(deletePartial)
    }
}
