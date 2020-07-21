//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of a operation to subscribe to new incoming and outgoing email messages.
class SubscribeToEmailMessageCreatedUseCase {

    // MARK: - Properties

    /// Email message repository used to subscribe to messages.
    let sealedEmailMessageRepository: SealedEmailMessageRepository

    let emailMessageUnsealerService: EmailMessageUnsealerService

    // MARK: - Lifecycle

    /// Initialize an instance of `SubscribeToEmailMessageCreatedUseCase`.
    init(sealedEmailMessageRepository: SealedEmailMessageRepository, emailMessageUnsealerService: EmailMessageUnsealerService) {
        self.sealedEmailMessageRepository = sealedEmailMessageRepository
        self.emailMessageUnsealerService = emailMessageUnsealerService
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameter resultHandler: Result handler to return email messages on.
    /// - Throws: `SudoEmailError` if an error occurs while setting up the initial connection the subscription.
    /// - Returns: `SubscriptionToken` object to cancel the subscription. On denitialization, the subscription will be cancelled.
    func execute(withDirection direction: DirectionEntity? = nil, resultHandler: @escaping ClientCompletion<EmailMessageEntity>) throws -> SubscriptionToken {
        return try sealedEmailMessageRepository.subscribeToEmailMessageCreated(withDirection: direction) { result in
            let result = result.mapThrowingSuccess(self.emailMessageUnsealerService.unsealEmailMessage(_:))
            resultHandler(result)
        }
    }

}
