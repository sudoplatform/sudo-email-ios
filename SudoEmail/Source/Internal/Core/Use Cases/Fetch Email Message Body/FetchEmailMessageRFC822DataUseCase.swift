//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of a operation to fetch the RFC 6854 (supersedes RFC 822) data of the email message remotely.
class FetchEmailMessageRFC822DataUseCase {

    // MARK: - Properties

    /// Email message repository used to access email message records and the RFC 6854 (supersedes RFC 822) data of the message.
    let emailMessageRepository: EmailMessageRepository

    let emailMessageUnsealerService: EmailMessageUnsealerService

    // MARK: - Lifecycle

    /// Initialize an instance of `FetchEmailMessageRFC822DataUseCase`.
    init(
        emailMessageRepository: EmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService
    ) {
        self.emailMessageRepository = emailMessageRepository
        self.emailMessageUnsealerService = emailMessageUnsealerService
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - id: Identifier of the email message to be accessed.
    ///   - completion: Body of the email message associated with `id`, or error on failure.
    func execute(withMessageId id: String, emailAddressId: String) async throws -> Data {
        guard let emailMessage = try await emailMessageRepository.fetchEmailMessageById(id) else {
            throw SudoEmailError.noEmailMessageRFC822Available
        }
        guard let rfc822Data = try await self.emailMessageRepository.fetchEmailMessageRFC822Data(id, emailAddressId: emailAddressId) else {
            throw SudoEmailError.noEmailMessageRFC822Available
        }
        return try self.emailMessageUnsealerService.unsealEmailMessageRFC822Data(
            rfc822Data,
            withKeyId: emailMessage.keyId,
            algorithm: emailMessage.algorithm
        )
    }
}
