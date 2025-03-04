//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
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
        logger = .emailSDKLogger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - withInput: Input containing `ids` list and `emailAddressId` of the draft email messages to be deleted.
    /// - Returns: The results of the delete operation:
    ///     - status:
    ///         - Success - All email messages succeeded to delete.
    ///         - Partial - Only a partial amount of draft messages succeeded to delete. Result includes two lists;
    ///           one containing success results and the other containing failure results.
    ///         - Failure - All email messages failed to delete. Result contains a list of identifiers of email messages
    ///           that failed to delete.
    ///     - successItems - A list of the identifiers of the email messages that were successfully deleted.
    ///     - failureItems - A list of the id and errorType of each email message that failed to be deleted.
    func execute(
        withInput input: DeleteDraftEmailMessagesInput
    ) async throws -> BatchOperationResult<String, EmailMessageOperationFailureResult> {
        guard try (await emailAccountRepository.fetchWithEmailAddressId(input.emailAddressId)) != nil else {
            throw SudoEmailError.addressNotFound
        }
        if input.ids.isEmpty {
            return BatchOperationResult<String, EmailMessageOperationFailureResult>(
                status: BatchOperationResultStatus.success
            )
        }

        var deleteFailures: [EmailMessageOperationFailureResult] = []
        var deleteSuccesses: [String] = []
        let emailAddressId = input.emailAddressId
        for id in input.ids {
            do {
                let deletedDraft = try await emailMessageRepository.deleteDraft(id: id, emailAddressId: emailAddressId)
                deleteSuccesses.append(deletedDraft)
            } catch {
                logger.error("Failed to delete draft \(id) with \(error)")
                deleteFailures.append(EmailMessageOperationFailureResult(id: id, errorType: error.localizedDescription))
            }
        }

        let status: BatchOperationResultStatus
        if deleteSuccesses.count == input.ids.count {
            status = BatchOperationResultStatus.success
        } else if deleteFailures.count == input.ids.count {
            status = BatchOperationResultStatus.failure
        } else {
            status = BatchOperationResultStatus.partial
        }
        return BatchOperationResult(status: status, successItems: deleteSuccesses, failureItems: deleteFailures)
    }
}
