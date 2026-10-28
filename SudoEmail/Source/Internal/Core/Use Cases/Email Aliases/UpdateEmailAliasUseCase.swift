//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of an operation to update an email alias.
///
/// Updates or clears the metadata and/or expiration date of an email alias.
class UpdateEmailAliasUseCase {

    // MARK: - Properties

    /// Email alias repository to access the email alias from the service.
    let emailAliasRepository: EmailAliasRepository

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `UpdateEmailAliasUseCase`.
    init(emailAliasRepository: EmailAliasRepository, logger: Logger) {
        self.emailAliasRepository = emailAliasRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - emailAliasId: The unique identifier of email alias to update.
    ///   - metadata: Optional name/value pair metadata to associate with the email alias. Provide empty map to clear.
    ///   - expiresAt: Optional expiration date for the email alias. Provide date of 0 to clear existing expiration.
    ///   - realAddress: Optional real email address for the email alias. Only valid for external aliases in a pending state.
    /// - Returns: The updated email alias entity.
    func execute(emailAliasId: String, metadata: [String: String]?, expiresAt: Date?, realAddress: String?) async throws -> EmailAliasEntity {
        logger.info("Updating email alias with ID: \(emailAliasId)")
        return try await emailAliasRepository.updateEmailAlias(
            emailAliasId: emailAliasId,
            metadata: metadata,
            expiresAt: expiresAt,
            realAddress: realAddress
        )
    }
}
