//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of a operation to update email account metadata.
///
class UpdateEmailAccountMetadataUseCase {

    // MARK: - Properties: Repositories

    /// Email account repository to create the email account.
    let emailAccountRepository: EmailAccountRepository

    // MARK: - Properties

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of the `UpdateEmailAccountMetadataUseCase` use case.
    init(
        emailAccountRepository: EmailAccountRepository,
        logger: Logger = .emailSDKLogger
    ) {
        self.emailAccountRepository = emailAccountRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - emailAccountId: Identifier of the Email account to update.
    ///   - values: The new values for email account metadata.
    /// - Returns: The identifier of the email account that was updated.
    func execute(emailAccountId: String, values: UpdateEmailAddressMetadataValues) async throws -> String {
        let updatedEmailAccountId = try await emailAccountRepository.updateMetadata(
            id: emailAccountId,
            values: values
        )
        return updatedEmailAccountId
    }
}
