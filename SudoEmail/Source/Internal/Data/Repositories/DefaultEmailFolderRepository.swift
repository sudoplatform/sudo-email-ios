//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SudoApiClient
import SudoLogging

/// Data implementation of the core `EmailFolderRepository`.
///
/// Allows manipulation of data on the email service, via AppSync GraphQL.
class DefaultEmailFolderRepository: EmailFolderRepository {

    // MARK: - Properties

    /// App sync client for peforming operations against the email service.
    var sudoApiClient: SudoApiClient

    /// Cryptographic key worker for this device
    var deviceKeyWorker: DeviceKeyWorker

    /// Used to log diagnostic and error information.
    var logger: SudoLogging.Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultEmailFolderRepository`.
    init(appSyncClient: SudoApiClient, deviceKeyWorker: DeviceKeyWorker, logger: SudoLogging.Logger = .emailSDKLogger) {
        sudoApiClient = appSyncClient
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
        let result = try await fetch(query)
        let emailFolders = result.listEmailFoldersForEmailAddressId.items
        let transformer = EmailFolderEntityTransformer(deviceKeyWorker: deviceKeyWorker)
        let emailFolderEntities = try emailFolders.map(transformer.transform(_:))
        return ListOutputEntity(
            items: emailFolderEntities,
            nextToken: result.listEmailFoldersForEmailAddressId.nextToken
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
        let result = try await perform(mutation)
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
        let result = try await perform(mutation)
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
        let result = try await perform(mutation)
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
        let result = try await perform(mutation)
        return result.deleteMessagesByFolderId
    }
}
