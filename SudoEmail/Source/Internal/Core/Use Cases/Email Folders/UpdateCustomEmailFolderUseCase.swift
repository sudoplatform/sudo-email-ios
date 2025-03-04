//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representing an operation to update a custom email folder

class UpdateCustomEmailFolderUseCase {

    // MARK: - Properties

    /// Email folder repository to update the custom folder
    let emailFolderRepository: EmailFolderRepository

    /// Logs diagnostic and error information
    let logger: Logger

    /// Initialize an instance of the `UpdateCustomEmailFolderUseCase`
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
    ///     - emailFolderId: The id of the custom email folder to update
    ///     - emailAddressId: The id of the email address associate with the folder
    ///     - values: The new values for the custom email folder
    /// - Returns: The update folder
    func execute(withInput input: UpdateCustomEmailFolderInput) async throws -> EmailFolderEntity {
        let emailFolder = try await emailFolderRepository.updateCustomEmailFolder(
            withInput: UpdateCustomEmailFolderInput(
                emailFolderId: input.emailFolderId,
                emailAddressId: input.emailAddressId,
                values: input.values
            )
        )
        return emailFolder
    }
}
