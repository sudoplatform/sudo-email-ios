//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representing an operation to delete all messages from a folder
class DeleteMessagesForFolderIdUseCase {

    // MARK: - Properties

    /// Email folder repository to delete messages from a folder
    let emailFolderRepository: EmailFolderRepository

    /// Logs diagnostic and error information
    let logger: Logger

    /// Initialize an instance of the `DeleteMessagesForFolderIdUseCase`
    init(
        emailFolderRepository: EmailFolderRepository,
        logger: Logger = .emailSDKLogger
    ) {
        self.emailFolderRepository = emailFolderRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - input: Input parameters needed to delete messages from a folder
    /// - Returns: The id of the folder
    func execute(withInput input: DeleteMessagesForFolderIdInput) async throws -> String {
        return try await emailFolderRepository.deleteMessagesForFolderId(
            withInput: input
        )
    }
}
