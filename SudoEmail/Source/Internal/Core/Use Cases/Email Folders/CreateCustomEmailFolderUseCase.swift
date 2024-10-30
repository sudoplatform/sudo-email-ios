//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of an operation to create a custom email folder
class CreateCustomEmailFolderUseCase {
    
    // MARK: - Properties
    
    /// Email account repository to ensure ownership of the email address
    let emailAccountRepository: EmailAccountRepository
    
    /// Email folder repository to create the custom folder
    let emailFolderRepository: EmailFolderRepository
    
    /// Logs diagnostic and error information
    let logger: Logger
    
    /// Initialize an instance of the `CreateCustomEmailFolderUseCase`
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
    ///   - emailAddressId: The email address id associated with the custom email folder
    ///   - customFolderName: The name of the custom folder
    /// - Returns: A newly created EmailFolder
    func execute(withInput input: CreateCustomEmailFolderInput) async throws -> EmailFolderEntity {
        guard (try await self.emailAccountRepository.fetchWithEmailAddressId(input.emailAddressId)) != nil else {
            throw SudoEmailError.addressNotFound
        }
        let emailFolder = try await self.emailFolderRepository.createCustomEmailFolder(
            withInput: CreateCustomEmailFolderInput(
                emailAddressId: input.emailAddressId,
                customFolderName: input.customFolderName
            )
        )
        return emailFolder
    }
}
