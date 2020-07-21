//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of a operation to subscribe to deleted messages.
class SubscribeToEmailMessageDeletedUseCase {

    // MARK: - Properties

    /// Email message repository used to subscribe to deleted messages.
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
    func execute(withResultHandler resultHandler: @escaping ClientCompletion<EmailMessageEntity>) throws -> SubscriptionToken {
        return try sealedEmailMessageRepository.subscribeToEmailMessageDeleted { result in
            let result = result.mapThrowingSuccess(self.emailMessageUnsealerService.unsealEmailMessage(_:))
            resultHandler(result)
        }
    }

}
