//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of an operation to enable an email mask.
///
/// Enables a previously disabled email mask, permitting it to forward emails again.
class EnableEmailMaskUseCase {

    // MARK: - Properties

    /// Email mask repository to access the email mask from the service.
    let emailMaskRepository: EmailMaskRepository

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `EnableEmailMaskUseCase`.
    init(emailMaskRepository: EmailMaskRepository, logger: Logger) {
        self.emailMaskRepository = emailMaskRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - emailMaskId: The unique identifier of email mask to enable.
    /// - Returns: The enabled email mask entity.
    func execute(emailMaskId: String) async throws -> EmailMaskEntity {
        logger.info("Enabling email mask with ID: \(emailMaskId)")
        return try await emailMaskRepository.enableEmailMask(emailMaskId: emailMaskId)
    }
}
