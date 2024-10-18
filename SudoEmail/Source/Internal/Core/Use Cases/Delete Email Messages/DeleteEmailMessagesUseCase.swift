//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of an operation to delete an email message associated with an id.
class DeleteEmailMessagesUseCase {

    // MARK: - Properties

    /// Email message repository to delete the record of the email message.
    let emailMessageRepository: EmailMessageRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `DeleteEmailMessagesUseCase`.
    init (emailMessageRepository: EmailMessageRepository) {
        self.emailMessageRepository = emailMessageRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - ids: List of unique Identifiers of the email messages to be deleted.
    /// - Returns: The results of the delete operation:
    ///     - status:
    ///         - Success - All draft email messages succeeded to delete.
    ///         - Partial - Only a partial amount of draft messages succeeded to delete. Result includes two lists;
    ///           one containing success results and the other containing failure results.
    ///         - Failure - All draft email messages failed to delete. Result contains a list of identifiers of draft email
    ///           messages that failed to delete.
    ///     - successItems - A list of the identifiers of the draft email messages that were successfully deleted.
    ///     - failureItems - A list of the id and errorType of each draft email message that failed to be deleted.
    func execute(withIds ids: [String]) async throws -> BatchOperationResult<String, EmailMessageOperationFailureResult> {
        if ids.isEmpty {
            throw SudoEmailError.invalidArgument("Attempt to delete empty list of email messages")
        }

        let failureIds = try await emailMessageRepository.deleteEmailMessages(withIds: ids)
        let failureItems = failureIds.map {
            EmailMessageOperationFailureResult(id: $0, errorType: "Failed to delete email message")
        }
        let successIds = ids.filter { !failureIds.contains($0) }

        let status: BatchOperationResultStatus
        if (successIds.count == ids.count) {
            status = BatchOperationResultStatus.success
        } else if failureIds.count == ids.count {
            status = BatchOperationResultStatus.failure
        } else {
            status = BatchOperationResultStatus.partial
        }

        return BatchOperationResult(
            status: status,
            successItems: successIds,
            failureItems: failureItems
        )
    }
}
