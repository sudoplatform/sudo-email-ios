//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of a operation to subscribe to new incoming and outgoing email messages.
class SubscribeToEmailMessageCreatedUseCase {

    // MARK: - Properties

    /// Email message repository used to subscribe to messages.
    let emailMessageRepository: EmailMessageRepository

    let emailMessageUnsealerService: EmailMessageUnsealerService

    // MARK: - Lifecycle

    /// Initialize an instance of `SubscribeToEmailMessageCreatedUseCase`.
    init(emailMessageRepository: EmailMessageRepository, emailMessageUnsealerService: EmailMessageUnsealerService) {
        self.emailMessageRepository = emailMessageRepository
        self.emailMessageUnsealerService = emailMessageUnsealerService
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///  - direction: The direction, ie, inbound or outbound, of the email message
    ///  - resultHandler: Result handler to return email messages on.
    /// - Throws: `SudoEmailError` if an error occurs while setting up the initial connection the subscription.
    /// - Returns: `SubscriptionToken` object to cancel the subscription. On denitialization, the subscription will be cancelled.
    func execute(
        withDirection direction: DirectionEntity? = nil,
        resultHandler: @escaping ClientCompletion<EmailMessage>
    ) async throws -> SubscriptionToken? {
        return try await emailMessageRepository.subscribeToEmailMessageCreated(
            withDirection: direction
        ) { result in
            let emailMessageEntity = result.mapThrowingSuccess(self.emailMessageUnsealerService.unsealEmailMessage(_:))
            let transformer = EmailMessageAPITransformer()
            let result = emailMessageEntity.map(transformer.transform(_:))
            resultHandler(result)
        }
    }

}
