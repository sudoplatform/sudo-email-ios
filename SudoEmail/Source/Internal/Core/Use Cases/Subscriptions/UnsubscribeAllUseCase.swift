//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of an operation to unsubscribe from all sudo email notifications.
class UnsubscribeAllUseCase {

    // MARK: - Properties

    /// Email message repository used to unsubscribe from sudo email notifications.
    let emailMessageRepository: EmailMessageRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `UnsubscribeAllUseCase`.
    init(emailMessageRepository: EmailMessageRepository) {
        self.emailMessageRepository = emailMessageRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    func execute() {
        emailMessageRepository.unsubscribeAll()
    }

}
