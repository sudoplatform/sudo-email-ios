//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SudoApiClient
import SudoLogging

class DefaultEmailConfigurationDataRepository: EmailConfigurationDataRepository {

    // MARK: - Properties

    /// App sync client for peforming operations against the email service.
    var appSyncClient: SudoApiClient

    /// Used to log diagnostic and error information.
    var logger: SudoLogging.Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultEmailConfigurationDataRepository`.
    init(appSyncClient: SudoApiClient, logger: SudoLogging.Logger = .emailSDKLogger) {
        self.appSyncClient = appSyncClient
        self.logger = logger
    }

    // MARK: query

    func getConfigurationData() async throws -> EmailConfigurationDataEntity {
        let query = GraphQL.GetEmailConfigQuery()
        let result = try await fetch(query)
        do {
            let transformer = EmailConfigurationDataEntityTransformer()
            return try transformer.transform(result.getEmailConfig)
        } catch {
            logger.error("transforming graphQL getEmailConfig query result failed with \(error)")
            throw error
        }
    }
}
