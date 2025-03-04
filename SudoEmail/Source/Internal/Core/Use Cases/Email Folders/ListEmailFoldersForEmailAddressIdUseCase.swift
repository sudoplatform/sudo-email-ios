//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of an operation to get a list of email folders associated with an email address.
///
class ListEmailFoldersForEmailAddressIdUseCase {

    // MARK: - Properties

    /// Domain repository to access the email accounts.
    let emailFolderRepository: EmailFolderRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `ListEmailFoldersForEmailAddressIdUseCase`.
    init(emailFolderRepository: EmailFolderRepository) {
        self.emailFolderRepository = emailFolderRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - input: Parameters used to retrieve a list of email folders.
    func execute(
        withInput input: ListEmailFoldersForEmailAddressIdInput
    ) async throws -> ListOutputEntity<EmailFolderEntity> {
        return try await emailFolderRepository.listEmailFoldersForEmailAddressId(withInput: input)
    }
}
