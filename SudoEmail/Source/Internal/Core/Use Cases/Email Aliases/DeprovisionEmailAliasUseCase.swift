//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of an operation to deprovision an email alias.
///
/// Deprovisions an existing email alias with the specified id.
class DeprovisionEmailAliasUseCase {

    // MARK: - Properties

    /// Email alias repository to access the email alias from the service.
    let emailAliasRepository: EmailAliasRepository

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DeprovisionEmailAliasUseCase`.
    init(emailAliasRepository: EmailAliasRepository, logger: Logger) {
        self.emailAliasRepository = emailAliasRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - emailAliasId: The unique identifier of email alias to deprovision.
    /// - Returns: The deprovisioned email alias entity.
    func execute(emailAliasId: String) async throws -> EmailAliasEntity {
        logger.info("Deprovisioning email alias with ID: \(emailAliasId)")
        return try await emailAliasRepository.deprovisionEmailAlias(emailAliasId: emailAliasId)
    }
}
