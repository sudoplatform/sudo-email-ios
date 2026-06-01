//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

class GetEmailMessageWithBodyUseCase {

    // MARK: - Properties

    /// Email message repository used to retrieve the email message.
    let emailMessageRepository: EmailMessageRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `GetEmailMessageWithBodyUseCase`.
    init(emailMessageRepository: EmailMessageRepository) {
        self.emailMessageRepository = emailMessageRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - input: Input containing the message ID and email address ID.
    /// - Returns: The email message with parsed body, or nil if not found.
    func execute(withInput input: GetEmailMessageWithBodyInput) async throws -> EmailMessageWithBody? {
        let messageId = input.id
        let emailAddressId = input.emailAddressId
        return try await emailMessageRepository.getEmailMessageWithBody(
            messageId: messageId,
            emailAddressId: emailAddressId
        )
    }
}
