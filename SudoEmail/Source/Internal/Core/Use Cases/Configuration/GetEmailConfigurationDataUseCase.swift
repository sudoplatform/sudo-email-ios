//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of an operation to retrieve the email configuration data.
class GetEmailConfigurationDataUseCase {

    // MARK: - Properties

    let emailConfigurationDataRepository: EmailConfigurationDataRepository

    // MARK: - Lifecycle

    init(emailConfigurationDataRepository: EmailConfigurationDataRepository) {
        self.emailConfigurationDataRepository = emailConfigurationDataRepository
    }

    // MARK: - Execution

    /// Execute the use case.
    /// - Returns:
    ///   - the configured limits for the email service.
    func execute() async throws -> EmailConfigurationDataEntity {
        return try await emailConfigurationDataRepository.getConfigurationData()
    }
}
