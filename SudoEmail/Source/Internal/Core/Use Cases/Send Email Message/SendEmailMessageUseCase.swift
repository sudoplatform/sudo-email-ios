//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SudoLogging

/// Core use case representation of a operation to send an email message via a user's account.
class SendEmailMessageUseCase {

    // MARK: - Properties

    /// Email message repository used to send the email message.
    let emailMessageRepository: EmailMessageRepository

    /// Logs diagnostic and error information.
    var logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `SendEmailMessageUseCase`.
    init(emailMessageRepository: EmailMessageRepository, logger: Logger = .emailSDKLogger) {
        self.emailMessageRepository = emailMessageRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Executes the use case.
    /// - Parameters:
    ///   - data: RFC 6854 (supersedes RFC 822) data of the email to send to the email service.
    ///   - emailAccountId: Identifier of the email account to send the email from.
    /// - Returns: The identifier of the email message on success.
    func execute(withRFC822Data data: Data, emailAccountId: String) async throws -> String {
        return try await emailMessageRepository.sendEmailMessage(withRFC822Data: data, emailAccountId: emailAccountId)
    }
}
