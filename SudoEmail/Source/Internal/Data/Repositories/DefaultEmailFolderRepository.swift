//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSAppSync
import Foundation
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

    /// Cryptographic key worker for this device
    var deviceKeyWorker: DeviceKeyWorker

    /// Used to log diagnostic and error information.
    var logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultEmailFolderRepository`.
    init(appSyncClient: SudoApiClient, deviceKeyWorker: DeviceKeyWorker, logger: Logger = .emailSDKLogger) {
        self.appSyncClient = appSyncClient
        self.deviceKeyWorker = deviceKeyWorker
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
        let (fetchResult, fetchError) = try await appSyncClient.fetch(
            query: query,
            cachePolicy: queryCachePolicy,
            queue: dispatchQueue
        )
        if let error = fetchError {
            try RepositoryErrorUtil.processError(error: error, logger: logger)
        }
        let emailFolders = fetchResult?.data?.listEmailFoldersForEmailAddressId.items ?? []
        let transformer = EmailFolderEntityTransformer(deviceKeyWorker: deviceKeyWorker)
        let emailFolderEntities = try emailFolders.map(transformer.transform(_:))
        return ListOutputEntity(
            items: emailFolderEntities,
            nextToken: fetchResult?.data?.listEmailFoldersForEmailAddressId.nextToken
        )
    }

    func createCustomEmailFolder(withInput input: CreateCustomEmailFolderInput) async throws -> EmailFolderEntity {
        let symmetricKeyId = try (deviceKeyWorker.getCurrentSymmetricKeyId()) ??
            (deviceKeyWorker.generateNewCurrentSymmetricKey())
        let sealedCustomEmailFolderName = try deviceKeyWorker.sealString(input.customFolderName, withKeyId: symmetricKeyId)

        let mutationInput = GraphQL.CreateCustomEmailFolderInput(
            customFolderName: .init(
                algorithm: DefaultDeviceKeyWorker.Defaults.symmetricAlgorithm,
                base64EncodedSealedData: sealedCustomEmailFolderName,
                keyId: symmetricKeyId,
                plainTextType: "string"
            ),
            emailAddressId: input.emailAddressId
        )
        let mutation = GraphQL.CreateCustomEmailFolderMutation(input: mutationInput)
        let (performResult, performError) = try await appSyncClient.perform(mutation: mutation, queue: dispatchQueue)
        guard let result = performResult?.data else {
            if let error = performError {
                try RepositoryErrorUtil.processError(error: error, logger: logger)
            }
            throw SudoEmailError.internalError("Unexpected error")
        }
        do {
            let transformer = EmailFolderEntityTransformer(deviceKeyWorker: deviceKeyWorker)
            let entity = try transformer.transform(result.createCustomEmailFolder)
            return entity
        } catch {
            logger.error("CreateCustomEmailFolder result transformation failed with \(error)")
            throw error
        }
    }

    func deleteCustomEmailFolder(withInput input: DeleteCustomEmailFolderInput) async throws -> EmailFolderEntity? {
        let mutationInput = GraphQL.DeleteCustomEmailFolderInput(
            emailAddressId: input.emailAddressId, emailFolderId: input.emailFolderId
        )

        let mutation = GraphQL.DeleteCustomEmailFolderMutation(input: mutationInput)
        let (performResult, performError) = try await appSyncClient.perform(mutation: mutation, queue: dispatchQueue)
        guard let result = performResult?.data else {
            if let error = performError {
                try RepositoryErrorUtil.processError(error: error, logger: logger)
            }
            return nil
        }
        do {
            let transformer = EmailFolderEntityTransformer(deviceKeyWorker: deviceKeyWorker)
            guard let entity = result.deleteCustomEmailFolder else {
                return nil
            }
            return try transformer.transform(entity)
        } catch {
            logger.error("DeleteCustomEmailFolder result transformation failed with \(error)")
            throw error
        }
    }

    func updateCustomEmailFolder(withInput input: UpdateCustomEmailFolderInput) async throws -> EmailFolderEntity {
        guard let symmetricKeyId = try deviceKeyWorker.getCurrentSymmetricKeyId() else {
            throw SudoEmailError.keyNotFound
        }

        var updateCustomEmailAddressInput = GraphQL.UpdateCustomEmailFolderInput(
            emailAddressId: input.emailAddressId,
            emailFolderId: input.emailFolderId,
            values: .init()
        )
        if let customFolderName = input.values.customFolderName {
            let sealedCustomFolderName = try deviceKeyWorker.sealString(
                customFolderName,
                withKeyId: symmetricKeyId
            )
            updateCustomEmailAddressInput.values.customFolderName = .init(
                algorithm: DefaultDeviceKeyWorker.Defaults.symmetricAlgorithm,
                base64EncodedSealedData: sealedCustomFolderName,
                keyId: symmetricKeyId,
                plainTextType: "string"
            )
        }
        let mutation = GraphQL.UpdateCustomEmailFolderMutation(input: updateCustomEmailAddressInput)
        let (performResult, performError) = try await appSyncClient.perform(mutation: mutation, queue: dispatchQueue)
        guard let result = performResult?.data else {
            if let error = performError {
                try RepositoryErrorUtil.processError(error: error, logger: logger)
            }
            throw SudoEmailError.internalError("Unexpected error")
        }
        do {
            let transformer = EmailFolderEntityTransformer(deviceKeyWorker: deviceKeyWorker)
            let entity = try transformer.transform(result.updateCustomEmailFolder)
            return entity
        } catch {
            logger.error("UpdateCustomEmailFolder result transformation failed with \(error)")
            throw error
        }
    }

    func deleteMessagesForFolderId(withInput input: DeleteMessagesForFolderIdInput) async throws -> String {
        let mutationInput = input.hardDelete == nil ? GraphQL.DeleteMessagesByFolderIdInput(
            emailAddressId: input.emailAddressId, folderId: input.emailFolderId
        ) : GraphQL.DeleteMessagesByFolderIdInput(
            emailAddressId: input.emailAddressId,
            folderId: input.emailFolderId,
            hardDelete: input.hardDelete
        )

        let mutation = GraphQL.DeleteMessagesByFolderIdMutation(input: mutationInput)

        let (performResult, performError) = try await appSyncClient.perform(mutation: mutation, queue: dispatchQueue)

        guard let result = performResult?.data else {
            if let error = performError {
                try RepositoryErrorUtil.processError(error: error, logger: logger)
            }
            logger.error("Unexpected error")
            throw SudoEmailError.internalError("Unexpected error")
        }
        return result.deleteMessagesByFolderId
    }

    func reset() throws {
        try appSyncClient.clearCaches(options: .init(clearQueries: true, clearMutations: true, clearSubscriptions: true))
    }
}
