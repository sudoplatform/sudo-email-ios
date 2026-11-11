//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

class GetEmailAliasByIdUseCase {

    // MARK: - Properties

    let emailAliasRepository: EmailAliasRepository

    // MARK: - Lifecycle

    init(emailAliasRepository: EmailAliasRepository) {
        self.emailAliasRepository = emailAliasRepository
    }

    // MARK: - Methods

    func execute(withId id: String) async throws -> EmailAliasEntity {
        return try await emailAliasRepository.getEmailAliasById(id: id)
    }
}
