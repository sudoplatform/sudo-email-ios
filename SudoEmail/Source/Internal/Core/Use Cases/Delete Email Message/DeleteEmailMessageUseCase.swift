//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of an operation to delete an email message associated with an id.
class DeleteEmailMessageUseCase {

    // MARK: - Properties

    /// Email message repository to delete the record of the email message.
    let sealedEmailMessageRepository: SealedEmailMessageRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `DeleteEmailMessageUseCase`.
    init (sealedEmailMessageRepository: SealedEmailMessageRepository) {
        self.sealedEmailMessageRepository = sealedEmailMessageRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - id: Unique Identifier of the email message to be deleted.
    ///   - completion: Returns on success, the ID of the deleted email message, or error on failure.
    func execute(withId id: String, completion: @escaping ClientCompletion<String>) {
        sealedEmailMessageRepository.deleteEmailMessage(withId: id, completion: completion)
    }
}
