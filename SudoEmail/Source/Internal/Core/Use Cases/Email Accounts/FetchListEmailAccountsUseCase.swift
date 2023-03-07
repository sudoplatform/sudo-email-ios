//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of a operation to fetch a list of email accounts.
///
/// Fetches the list of email accounts from the email service remotely.
class FetchListEmailAccountsUseCase {

    // MARK: - Properties

    /// Domain repository to access the email accounts.
    let emailAccountRepository: EmailAccountRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `FetchListEmailAccountsUseCase`.
    init(emailAccountRepository: EmailAccountRepository) {
        self.emailAccountRepository = emailAccountRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    func execute(
        limit: Int?,
        nextToken: String?
    ) async throws -> ListOutputEntity<EmailAccountEntity> {
        try await emailAccountRepository.fetchList(limit: limit, nextToken: nextToken)
    }

}
