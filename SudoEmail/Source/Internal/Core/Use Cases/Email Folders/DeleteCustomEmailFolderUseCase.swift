//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representing an operation to delete a custom email folder

class DeleteCustomEmailFolderUseCase {
    
    // MARK: - Properties
    
    /// Email account repository to ensure ownership of the email address
    let emailAccountRepository: EmailAccountRepository
    
    /// Email folder repository to delete the custom folder
    let emailFolderRepository: EmailFolderRepository
    
    /// Logs diagnostic and error information
    let logger: Logger
    
    /// Initialize an instance of the `DeleteCustomEmailFolderUseCase`
    init(
        emailAccountRepository: EmailAccountRepository,
        emailFolderRepository: EmailFolderRepository,
        logger: Logger = .emailSDKLogger
    ) {
        self.emailAccountRepository = emailAccountRepository
        self.emailFolderRepository = emailFolderRepository
        self.logger = logger
    }
    
    // MARK: - Methods
    
    /// Execute the use case.
    /// - Parameters:
    ///     - emailFolderId: The id of the custom email folder to delete
    ///     - emailAddressId: The id of the email address associate with the folder
    /// - Returns: The deleted folder, or nil if it was not found
    func execute(withInput input: DeleteCustomEmailFolderInput) async throws -> EmailFolderEntity? {
        let emailFolder = try await self.emailFolderRepository.deleteCustomEmailFolder(
            withInput: DeleteCustomEmailFolderInput(
                emailFolderId: input.emailFolderId,
                emailAddressId: input.emailAddressId
            )
        )
        return emailFolder
    }
}
