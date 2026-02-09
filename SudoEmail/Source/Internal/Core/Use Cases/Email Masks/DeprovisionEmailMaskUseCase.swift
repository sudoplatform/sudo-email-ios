//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of an operation to deprovision an email mask.
///
/// Deprovisions an existing email mask with the specified id.
class DeprovisionEmailMaskUseCase {

    // MARK: - Properties

    /// Email mask repository to access the email mask from the service.
    let emailMaskRepository: EmailMaskRepository

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DeprovisionEmailMaskUseCase`.
    init(emailMaskRepository: EmailMaskRepository, logger: Logger) {
        self.emailMaskRepository = emailMaskRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - emailMaskId: The unique identifier of email mask to deprovision.
    /// - Returns: The deprovisioned email mask entity.
    func execute(emailMaskId: String) async throws -> EmailMaskEntity {
        logger.info("Deprovisioning email mask with ID: \(emailMaskId)")
        return try await emailMaskRepository.deprovisionEmailMask(emailMaskId: emailMaskId)
    }
}
