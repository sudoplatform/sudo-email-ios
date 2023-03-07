//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync
import SudoApiClient
import SudoLogging

/// Queue to handle the result events from AWS.
private let dispatchQueue = DispatchQueue(label: "com.sudoplatform.query-result-handler-queue")

class DefaultEmailConfigurationDataRepository: EmailConfigurationDataRepository {

    // MARK: - Properties

    /// App sync client for peforming operations against the email service.
    var appSyncClient: SudoApiClient

    /// Used to log diagnostic and error information.
    var logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultEmailConfigurationDataRepository`.
    init(appSyncClient: SudoApiClient, logger: Logger = .emailSDKLogger) {
        self.appSyncClient = appSyncClient
        self.logger = logger
    }

    // MARK: query

    func getConfigurationData() async throws -> EmailConfigurationDataEntity {
        let query = GraphQL.GetEmailConfigQuery()
        let cachePolicy: AWSAppSync.CachePolicy = AWSAppSync.CachePolicy.fetchIgnoringCacheData
        let (fetchResult, fetchError) = try await self.appSyncClient.fetch(
            query: query,
            cachePolicy: cachePolicy,
            queue: dispatchQueue
        )
        guard let result = fetchResult?.data else {
            if let error = fetchError {
                switch error {
                case ApiOperationError.graphQLError(let cause):
                    guard let sudoEmailError = SudoEmailError(graphQLError: cause) else {
                        throw SudoEmailError.internalError("Unexpected error: \(error)")
                    }
                    throw sudoEmailError
                case ApiOperationError.notSignedIn:
                    throw SudoEmailError.notSignedIn
                default:
                    throw SudoEmailError.internalError("Unexpected error: \(error)")
                }
            }
            throw SudoEmailError.internalError("Unexpected error")
        }
        do {
            let transformer = EmailConfigurationDataEntityTransformer()
            return try transformer.transform(result.getEmailConfig)
        } catch {
            logger.error("transforming graphQL getEmailConfig query result failed with \(error)")
            throw error
        }
    }

}
