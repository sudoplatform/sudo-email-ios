//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of a operation to deprovision an email account.
class DeprovisionEmailAccountUseCase {

    // MARK: - Properties

    /// Email account repository to delete the email account.
    let emailAccountRepository: EmailAccountRepository

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DeprovisionEmailAccountUseCase`.
    init(emailAccountRepository: EmailAccountRepository, logger: Logger = .emailSDKLogger) {
        self.emailAccountRepository = emailAccountRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - emailAccountId: Identifier of the email account to deprovision.
    ///   - completion: Returns the email account that was deleted on success, or error on failure.
    func execute(emailAccountId: String) async throws -> EmailAccountEntity {
        let emailAccount = try await emailAccountRepository.deleteWithId(emailAccountId)
        return emailAccount
    }
}
