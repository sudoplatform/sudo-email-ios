//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of an operation to list email aliases.
///
/// Lists email aliases owned by the current user with optional filtering and pagination.
class ListEmailAliasesUseCase {

    // MARK: - Properties

    /// Email alias repository to access the email aliases from the service.
    let emailAliasRepository: EmailAliasRepository

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `ListEmailAliasesUseCase`.
    init(emailAliasRepository: EmailAliasRepository, logger: Logger) {
        self.emailAliasRepository = emailAliasRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - sudoId: Optional identifier of a Sudo to filter email aliases by.
    ///   - filter: Optional filter to apply to the email aliases being listed.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    /// - Returns: A list of email alias entities with pagination information.
    func execute(sudoId: String?, filter: EmailAliasFilterEntity?, limit: Int?, nextToken: String?) async throws -> ListOutputEntity<EmailAliasListItemEntity> {
        logger.info("Listing email aliases with sudoId: \(String(describing: sudoId)), limit: \(String(describing: limit)), nextToken: \(String(describing: nextToken))")
        return try await emailAliasRepository.listEmailAliases(sudoId: sudoId, filter: filter, limit: limit, nextToken: nextToken)
    }
}
