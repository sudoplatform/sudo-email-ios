//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of an operation to update an email mask.
///
/// Updates or clears the metadata and/or expiration date of an email mask.
class UpdateEmailMaskUseCase {

    // MARK: - Properties

    /// Email mask repository to access the email mask from the service.
    let emailMaskRepository: EmailMaskRepository

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `UpdateEmailMaskUseCase`.
    init(emailMaskRepository: EmailMaskRepository, logger: Logger) {
        self.emailMaskRepository = emailMaskRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - emailMaskId: The unique identifier of email mask to update.
    ///   - metadata: Optional name/value pair metadata to associate with the email mask. Provide empty map to clear.
    ///   - expiresAt: Optional expiration date for the email mask. Provide date of 0 to clear existing expiration.
    /// - Returns: The updated email mask entity.
    func execute(emailMaskId: String, metadata: [String: String]?, expiresAt: Date?) async throws -> EmailMaskEntity {
        logger.info("Updating email mask with ID: \(emailMaskId)")
        return try await emailMaskRepository.updateEmailMask(
            emailMaskId: emailMaskId,
            metadata: metadata,
            expiresAt: expiresAt
        )
    }
}
