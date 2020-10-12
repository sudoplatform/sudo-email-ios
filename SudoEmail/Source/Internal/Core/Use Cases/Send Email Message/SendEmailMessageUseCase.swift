//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SudoLogging

/// Core use case representation of a operation to send an email message via a user's account.
class SendEmailMessageUseCase {

    // MARK: - Properties

    /// Email message repository used to send the email message.
    let sealedEmailMessageRepository: SealedEmailMessageRepository

    /// Logs diagnostic and error information.
    var logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `SendEmailMessageUseCase`.
    init(sealedEmailMessageRepository: SealedEmailMessageRepository, logger: Logger = .emailSDKLogger) {
        self.sealedEmailMessageRepository = sealedEmailMessageRepository
        self.logger = logger
    }

    // MARK: - Methods

    // TODO: RFC822Data is probably a violation of clean and will change when we allow users to pass in structured information to send.

    /// Executes the use case.
    /// - Parameters:
    ///   - data: RFC 6854 (supersedes RFC 822) data of the email to send to the email service.
    ///   - emailAccountId: Identifier of the email account to send the email from.
    ///   - completion: Returns the identifier of the email message on success, or failure on error.
    func execute(withRFC822Data data: Data, emailAccountId: String, completion: @escaping ClientCompletion<String>) {
        sealedEmailMessageRepository.sendEmailMessage(withRFC822Data: data, emailAccountId: emailAccountId, completion: completion)
    }
}
