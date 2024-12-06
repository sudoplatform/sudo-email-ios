//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of an operation to update email messages specified by ids.
class UpdateEmailMessagesUseCase {

    // MARK: - Properties

    /// Email message repository to update the record of the email message.
    let emailMessageRepository: EmailMessageRepository
    
    /// Email configuration repository.
    let emailConfigRepository: EmailConfigurationDataRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `UpdateEmailMessagesUseCase`.
    init (emailMessageRepository: EmailMessageRepository, emailConfigRepository: EmailConfigurationDataRepository) {
        self.emailMessageRepository = emailMessageRepository
        self.emailConfigRepository = emailConfigRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - input: List of unique Identifiers of the email messages to be updated and the values to update.
    /// - Returns: Result of the update, either success, failed, or partial.
    func execute(
        withInput input: UpdateEmailMessagesInput
    ) async throws -> BatchOperationResult<UpdatedEmailMessageSuccess, EmailMessageOperationFailureResult> {
        let config = try await emailConfigRepository.getConfigurationData()
        if (input.ids.count > config.updateEmailMessagesLimit) {
            throw SudoEmailError.limitExceeded("Cannot update more than \(config.updateEmailMessagesLimit) messages.")
        }
        return try await emailMessageRepository.updateEmailMessages(withInput: input)
    }
}
