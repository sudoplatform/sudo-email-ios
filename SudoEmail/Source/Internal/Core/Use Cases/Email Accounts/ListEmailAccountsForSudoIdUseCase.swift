//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of a operation to get a list of email accounts.
///
/// List the email accounts owned by a particular sudo.
class ListEmailAccountsForSudoIdUseCase {

    // MARK: - Properties

    /// Domain repository to access the email accounts.
    let emailAccountRepository: EmailAccountRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `ListEmailAccountsForSudoIdUseCase`.
    init(emailAccountRepository: EmailAccountRepository) {
        self.emailAccountRepository = emailAccountRepository
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - sudoId: Identifier of the sudo associated with the email accounts to list.
    ///   - cachePolicy: Determines how the email accounts will be fetched. Default usage is `remoteOnly`.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    func execute(
        sudoId: String,
        cachePolicy: CachePolicy? = .remoteOnly,
        limit: Int?,
        nextToken: String?
    ) async throws -> ListOutputEntity<EmailAccountEntity> {
        return try await emailAccountRepository.listForSudoId(
            sudoId: sudoId,
            cachePolicy: cachePolicy,
            limit: limit,
            nextToken: nextToken
        )
    }

}
