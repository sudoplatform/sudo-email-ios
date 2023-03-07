//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

class GetEmailMessageUseCase {

    // MARK: - Properties

    let emailMessageRepository: EmailMessageRepository

    let emailMessageUnsealerService: EmailMessageUnsealerService

    // MARK: - Lifecycle

    init(
        emailMessageRepository: EmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService
    ) {
        self.emailMessageRepository = emailMessageRepository
        self.emailMessageUnsealerService = emailMessageUnsealerService
    }

    // MARK: - Methods

    func execute(withMessageId id: String) async throws -> EmailMessageEntity? {
        guard let sealedMessage = try await emailMessageRepository.getEmailMessageById(id) else { return nil }
        return try self.emailMessageUnsealerService.unsealEmailMessage(sealedMessage)
    }
}
