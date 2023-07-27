//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of a operation to get a list of email accounts.
///
/// Fetches the list of email accounts from the device cache.
class ListEmailAccountsUseCase {

    // MARK: - Properties

    /// Domain repository to access the emaila ccounts.
    let emailAccountRepository: EmailAccountRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `ListEmailAccountsUseCase`.
    init(emailAccountRepository: EmailAccountRepository) {
        self.emailAccountRepository = emailAccountRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    func execute(limit: Int?, nextToken: String?) async throws -> ListOutputEntity<EmailAccountEntity> {
        return try await emailAccountRepository.list(limit: limit, nextToken: nextToken)
    }

}
