//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of an operation to enable an email alias.
///
/// Enables a previously disabled email alias, permitting it to forward emails again.
class EnableEmailAliasUseCase {

    // MARK: - Properties

    /// Email alias repository to access the email alias from the service.
    let emailAliasRepository: EmailAliasRepository

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `EnableEmailAliasUseCase`.
    init(emailAliasRepository: EmailAliasRepository, logger: Logger) {
        self.emailAliasRepository = emailAliasRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - emailAliasId: The unique identifier of email alias to enable.
    /// - Returns: The enabled email alias entity.
    func execute(emailAliasId: String) async throws -> EmailAliasEntity {
        logger.info("Enabling email alias with ID: \(emailAliasId)")
        return try await emailAliasRepository.enableEmailAlias(emailAliasId: emailAliasId)
    }
}
