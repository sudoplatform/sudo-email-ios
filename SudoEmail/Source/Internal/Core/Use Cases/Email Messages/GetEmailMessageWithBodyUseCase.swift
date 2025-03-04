//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Gzip

class GetEmailMessageWithBodyUseCase {

    // MARK: - Properties

    /// Email message repository used to send the email message.
    let emailMessageRepository: EmailMessageRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `GetEmailMessageWithBodyUseCase`.
    init(emailMessageRepository: EmailMessageRepository) {
        self.emailMessageRepository = emailMessageRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - id: Identifier of the email message to be accessed.
    ///   - completion: Body of the email message associated with `id`, or error on failure.
    func execute(withInput input: GetEmailMessageWithBodyInput) async throws -> EmailMessageWithBody? {
        let messageId = input.id
        let emailAddressId = input.emailAddressId
        let emailMessageWithBody = try await emailMessageRepository.getEmailMessageWithBody(
            messageId: messageId,
            emailAddressId: emailAddressId
        )
        return emailMessageWithBody
    }
}
