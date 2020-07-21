//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
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
    ///   - filter: Filter rules to be applied to the list.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    ///   - completion: Returns a list of results with a next token is there if more results to fetch, or error on failure.
    func execute(
        withFilter filter: EmailAccountFilterEntity?,
        limit: Int?,
        nextToken: String?,
        completion: @escaping ClientCompletion<ListOutputEntity<EmailAccountEntity>>
    ) {
        emailAccountRepository.listWithFilter(filter, limit: limit, nextToken: nextToken, completion: completion)
    }

}
