//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of an operation to disable an email mask.
///
/// Disables an active email mask, preventing it from forwarding any emails.
class DisableEmailMaskUseCase {

    // MARK: - Properties

    /// Email mask repository to access the email mask from the service.
    let emailMaskRepository: EmailMaskRepository

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DisableEmailMaskUseCase`.
    init(emailMaskRepository: EmailMaskRepository, logger: Logger) {
        self.emailMaskRepository = emailMaskRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - emailMaskId: The unique identifier of email mask to disable.
    /// - Returns: The disabled email mask entity.
    func execute(emailMaskId: String) async throws -> EmailMaskEntity {
        logger.info("Disabling email mask with ID: \(emailMaskId)")
        return try await emailMaskRepository.disableEmailMask(emailMaskId: emailMaskId)
    }
}
