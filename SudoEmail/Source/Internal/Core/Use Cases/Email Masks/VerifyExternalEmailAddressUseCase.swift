//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of an operation to verify an external email address.
///
/// Verifies an external email address for use with email masking.
class VerifyExternalEmailAddressUseCase {

    // MARK: - Properties

    /// Email mask repository to access the email mask service.
    let emailMaskRepository: EmailMaskRepository

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `VerifyExternalEmailAddressUseCase`.
    init(emailMaskRepository: EmailMaskRepository, logger: Logger) {
        self.emailMaskRepository = emailMaskRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - emailAddress: The external email address to verify.
    ///   - emailMaskId: The unique identifier of the email mask.
    ///   - verificationCode: Optional verification code.
    /// - Returns: The verification result.
    func execute(emailAddress: String, emailMaskId: String, verificationCode: String?) async throws -> VerifyExternalEmailAddressResultEntity {
        logger.info("Verifying external email address for mask ID: \(emailMaskId)")
        return try await emailMaskRepository.verifyExternalEmailAddress(
            emailAddress: emailAddress,
            emailMaskId: emailMaskId,
            verificationCode: verificationCode
        )
    }
}
