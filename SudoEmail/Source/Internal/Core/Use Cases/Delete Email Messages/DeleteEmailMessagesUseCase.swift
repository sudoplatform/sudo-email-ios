//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
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
    /// - Returns: The status of the delete operation:
    ///       - success: All email messages deleted successfully.
    ///       - partial: Only some of the email messages deleted successfully. Includes a list of the
    ///               identifiers of the email messages that failed and succeeded to update.
    ///       - failed: All email messages failed to delete.
    func execute(withIds ids: [String]) async throws -> BatchOperationResult<String> {
        if ids.isEmpty {
            throw SudoEmailError.invalidArgument("Attempt to delete empty list of email messages")
        }
        let failureIds = try await emailMessageRepository.deleteEmailMessages(withIds: ids)
        if failureIds.isEmpty {
            return BatchOperationResult<String>.success
        } else if failureIds.count == ids.count {
            return BatchOperationResult<String>.failure
        } else {
            let successIds = ids.filter { !failureIds.contains($0) }
            return BatchOperationResult<String>.partial(BatchOperationResult<String>.BatchOperationPartialResult(
                successItems: successIds,
                failureItems: failureIds
            ))
        }
    }
}
