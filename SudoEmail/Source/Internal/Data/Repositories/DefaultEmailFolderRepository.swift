//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync
import SudoApiClient
import SudoLogging

/// Queue to handle the result events from AWS.
private let dispatchQueue = DispatchQueue(label: "com.sudoplatform.query-result-handler-queue")

/// Data implementation of the core `EmailFolderRepository`.
///
/// Allows manipulation of data on the email service, via AppSync GraphQL.
class DefaultEmailFolderRepository: EmailFolderRepository, Resetable {

    // MARK: - Properties

    /// App sync client for peforming operations against the email service.
    var appSyncClient: SudoApiClient

    /// Used to log diagnostic and error information.
    var logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultEmailFolderRepository`.
    init(appSyncClient: SudoApiClient, logger: Logger = .emailSDKLogger) {
        self.appSyncClient = appSyncClient
        self.logger = logger
    }

    func listEmailFoldersForEmailAddressId(
        withInput input: ListEmailFoldersForEmailAddressIdInput
    ) async throws -> ListOutputEntity<EmailFolderEntity> {
        let graphQLInput = GraphQL.ListEmailFoldersForEmailAddressIdInput(
            emailAddressId: input.emailAddressId,
            limit: input.limit,
            nextToken: input.nextToken
        )
        let query = GraphQL.ListEmailFoldersForEmailAddressIdQuery(input: graphQLInput)
        let cachePolicy = input.cachePolicy ?? .remoteOnly
        let cachePolicyTransformer = CachePolicyAPITransformer()
        let queryCachePolicy = cachePolicyTransformer.transform(cachePolicy)
        let (fetchResult, fetchError) = try await self.appSyncClient.fetch(
            query: query,
            cachePolicy: queryCachePolicy,
            queue: dispatchQueue
        )
        if let error = fetchError {
            switch error {
            case ApiOperationError.graphQLError(let cause):
                guard let sudoEmailError = SudoEmailError(graphQLError: cause) else {
                    throw SudoEmailError.internalError("Unexpected error: \(error)")
                }
                throw sudoEmailError
            default:
                throw SudoEmailError.fromApiOperationError(error: error)
            }
        }
        let emailFolders = fetchResult?.data?.listEmailFoldersForEmailAddressId.items ?? []
        let transformer = EmailFolderEntityTransformer()
        let emailFolderEntities = emailFolders.map(transformer.transform(_:))
        return ListOutputEntity(
            items: emailFolderEntities,
            nextToken: fetchResult?.data?.listEmailFoldersForEmailAddressId.nextToken
        )
    }

    func reset() throws {
        try self.appSyncClient.clearCaches(options: .init(clearQueries: true, clearMutations: true, clearSubscriptions: true))
    }

}
