//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of an operation to list email aliases for owner.
///
/// Lists email aliases owned by the current user with optional filtering and pagination.
class ListEmailAliasesForOwnerUseCase {

    // MARK: - Properties

    /// Email alias repository to access the email aliases from the service.
    let emailAliasRepository: EmailAliasRepository

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `ListEmailAliasesForOwnerUseCase`.
    init(emailAliasRepository: EmailAliasRepository, logger: Logger) {
        self.emailAliasRepository = emailAliasRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - filter: Optional filter to apply to the email aliases being listed.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    /// - Returns: A list of email alias entities with pagination information.
    func execute(filter: EmailAliasFilterEntity?, limit: Int?, nextToken: String?) async throws -> ListOutputEntity<EmailAliasEntity> {
        logger.info("Listing email aliases for owner with limit: \(String(describing: limit)), nextToken: \(String(describing: nextToken))")
        return try await emailAliasRepository.listEmailAliasesForOwner(filter: filter, limit: limit, nextToken: nextToken)
    }
}
