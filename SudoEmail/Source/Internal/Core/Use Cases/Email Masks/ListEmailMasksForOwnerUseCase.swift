//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of an operation to list email masks for owner.
///
/// Lists email masks owned by the current user with optional filtering and pagination.
class ListEmailMasksForOwnerUseCase {

    // MARK: - Properties

    /// Email mask repository to access the email masks from the service.
    let emailMaskRepository: EmailMaskRepository

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `ListEmailMasksForOwnerUseCase`.
    init(emailMaskRepository: EmailMaskRepository, logger: Logger) {
        self.emailMaskRepository = emailMaskRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - filter: Optional filter to apply to the email masks being listed.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    /// - Returns: A list of email mask entities with pagination information.
    func execute(filter: EmailMaskFilterEntity?, limit: Int?, nextToken: String?) async throws -> ListOutputEntity<EmailMaskEntity> {
        logger.info("Listing email masks for owner with limit: \(String(describing: limit)), nextToken: \(String(describing: nextToken))")
        return try await emailMaskRepository.listEmailMasksForOwner(filter: filter, limit: limit, nextToken: nextToken)
    }
}
