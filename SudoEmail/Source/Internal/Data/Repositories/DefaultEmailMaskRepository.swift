//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SudoApiClient
import SudoLogging

/// Data implementation of the core `EmailMaskRepository`.
///
/// Allows manipulation of email mask data on the email service, via AppSync GraphQL.
class DefaultEmailMaskRepository: EmailMaskRepository, Repository {

    // MARK: - Properties

    /// App sync client for performing operations against the email service.
    var sudoApiClient: SudoApiClient

    /// Cryptographic key worker for this device
    var deviceKeyWorker: DeviceKeyWorker

    /// Used to log diagnostic and error information.
    var logger: SudoLogging.Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultEmailMaskRepository`.
    init(appSyncClient: SudoApiClient, deviceKeyWorker: DeviceKeyWorker, logger: SudoLogging.Logger = .emailSDKLogger) {
        sudoApiClient = appSyncClient
        self.deviceKeyWorker = deviceKeyWorker
        self.logger = logger
    }

    // MARK: - EmailMaskRepository

    func provisionEmailMask(
        maskAddress: String,
        realAddress: String,
        ownershipProofToken: String,
        publicKey: KeyEntity,
        metadata: [String: String]?,
        expiresAt: Date?
    ) async throws -> EmailMaskEntity {
        logger.debug("Provisioning email mask: \(maskAddress) -> \(realAddress)")

        let symmetricKeyId = try (deviceKeyWorker.getCurrentSymmetricKeyId()) ??
            (deviceKeyWorker.generateNewCurrentSymmetricKey())

        let publicKeyData = publicKey.keyData.base64EncodedString()

        // Extract format from the public key and transform to GraphQL format
        let keyFormatTransformer = KeyFormatGQLTransformer()
        let publicKeyFormat = try publicKey.getPublicKeyFormat()
        let graphQLKeyFormat = keyFormatTransformer.transform(publicKeyFormat)

        let publicKeyInput = GraphQL.ProvisionEmailMaskPublicKeyInput(
            algorithm: DefaultDeviceKeyWorker.Defaults.algorithm,
            keyFormat: graphQLKeyFormat,
            keyId: publicKey.keyId,
            publicKey: publicKeyData
        )

        var sealedMetadata: GraphQL.SealedAttributeInput?
        if let metadata = metadata, !metadata.isEmpty {
            // JSON encode the metadata dictionary
            let jsonData = try JSONSerialization.data(withJSONObject: metadata, options: [])
            let jsonString = String(data: jsonData, encoding: .utf8)!

            // Seal the JSON string
            let sealedData = try deviceKeyWorker.sealString(jsonString, withKeyId: symmetricKeyId)
            sealedMetadata = GraphQL.SealedAttributeInput(
                algorithm: DefaultDeviceKeyWorker.Defaults.symmetricAlgorithm,
                base64EncodedSealedData: sealedData,
                keyId: symmetricKeyId,
                plainTextType: "string"
            )
        }

        let provisionEmailMaskInput = GraphQL.ProvisionEmailMaskInput(
            expiresAtEpochSec: {
                if let expiresAt = expiresAt {
                    let epochSeconds = Int(expiresAt.timeIntervalSince1970)
                    return epochSeconds == 0 ? nil : epochSeconds
                }
                return nil
            }(),
            key: publicKeyInput,
            maskAddress: maskAddress,
            metadata: sealedMetadata,
            ownershipProofTokens: [ownershipProofToken],
            realAddress: realAddress
        )

        let mutation = GraphQL.ProvisionEmailMaskMutation(input: provisionEmailMaskInput)
        let result = try await perform(mutation)

        let transformer = EmailMaskEntityTransformer(deviceKeyWorker: deviceKeyWorker)
        return try transformer.transform(result)
    }

    func deprovisionEmailMask(emailMaskId: String) async throws -> EmailMaskEntity {
        logger.debug("Deprovisioning email mask with ID: \(emailMaskId)")
        let deprovisionEmailMaskInput = GraphQL.DeprovisionEmailMaskInput(
            emailMaskId: emailMaskId
        )

        let mutation = GraphQL.DeprovisionEmailMaskMutation(input: deprovisionEmailMaskInput)
        let result = try await perform(mutation)

        let transformer = EmailMaskEntityTransformer(deviceKeyWorker: deviceKeyWorker)
        return try transformer.transform(result)
    }

    func updateEmailMask(
        emailMaskId: String,
        metadata: [String: String]?,
        expiresAt: Date?
    ) async throws -> EmailMaskEntity {
        logger.debug("Updating email mask with ID: \(emailMaskId)")
        let symmetricKeyId = try (deviceKeyWorker.getCurrentSymmetricKeyId()) ??
            (deviceKeyWorker.generateNewCurrentSymmetricKey())

        var sealedMetadata: GraphQL.SealedAttributeInput??
        if let metadata = metadata {
            if metadata.isEmpty {
                // Empty metadata map means clear existing metadata
                sealedMetadata = GraphQL.SealedAttributeInput??.some(nil)
            } else {
                let jsonData = try JSONSerialization.data(withJSONObject: metadata, options: [])
                let jsonString = String(data: jsonData, encoding: .utf8)!
                let sealedData = try deviceKeyWorker.sealString(jsonString, withKeyId: symmetricKeyId)
                let sealedInput = GraphQL.SealedAttributeInput(
                    algorithm: DefaultDeviceKeyWorker.Defaults.symmetricAlgorithm,
                    base64EncodedSealedData: sealedData,
                    keyId: symmetricKeyId,
                    plainTextType: "string"
                )
                sealedMetadata = GraphQL.SealedAttributeInput??.some(sealedInput)
            }
        }

        var expiresAtEpochSec: Int??
        if let expiresAt = expiresAt {
            let epochSeconds = Int(expiresAt.timeIntervalSince1970)
            if epochSeconds == 0 {
                // Date of 0 means clear existing expiration - pass Optional(.some(nil))
                expiresAtEpochSec = Int??.some(nil)
            } else {
                // Non-zero date - set expiration - pass Optional(.some(epochSeconds))
                expiresAtEpochSec = Int??.some(epochSeconds)
            }
        }
        let updateEmailMaskInput = GraphQL.UpdateEmailMaskInput(
            expiresAtEpochSec: expiresAtEpochSec,
            id: emailMaskId,
            metadata: sealedMetadata
        )

        let mutation = GraphQL.UpdateEmailMaskMutation(input: updateEmailMaskInput)
        let result = try await perform(mutation)

        let transformer = EmailMaskEntityTransformer(deviceKeyWorker: deviceKeyWorker)
        return try transformer.transform(result)
    }

    func enableEmailMask(emailMaskId: String) async throws -> EmailMaskEntity {
        logger.debug("Enabling email mask with ID: \(emailMaskId)")
        let enableEmailMaskInput = GraphQL.EnableEmailMaskInput(
            emailMaskId: emailMaskId
        )

        let mutation = GraphQL.EnableEmailMaskMutation(input: enableEmailMaskInput)
        let result = try await perform(mutation)

        let transformer = EmailMaskEntityTransformer(deviceKeyWorker: deviceKeyWorker)
        return try transformer.transform(result)
    }

    func disableEmailMask(emailMaskId: String) async throws -> EmailMaskEntity {
        logger.debug("Disabling email mask with ID: \(emailMaskId)")
        let disableEmailMaskInput = GraphQL.DisableEmailMaskInput(
            emailMaskId: emailMaskId
        )

        let mutation = GraphQL.DisableEmailMaskMutation(input: disableEmailMaskInput)
        let result = try await perform(mutation)

        let transformer = EmailMaskEntityTransformer(deviceKeyWorker: deviceKeyWorker)
        return try transformer.transform(result)
    }

    func listEmailMasksForOwner(filter: EmailMaskFilterEntity?, limit: Int?, nextToken: String?) async throws -> ListOutputEntity<EmailMaskEntity> {
        logger.debug("Listing email masks for owner with limit: \(limit ?? -1), nextToken: \(nextToken ?? "nil")")

        var graphQLFilter: GraphQL.EmailMaskFilterInput?
        if let filter = filter {
            graphQLFilter = filter.toGraphQLFilter()
        }
        let input = GraphQL.ListEmailMasksForOwnerInput(
            filter: graphQLFilter,
            limit: limit,
            nextToken: nextToken
        )

        let query = GraphQL.ListEmailMasksForOwnerQuery(input: input)
        let result = try await fetch(query)

        do {
            var emailMaskEntities: [EmailMaskEntity] = []
            let emailMasks = result.listEmailMasksForOwner.items
            let transformer = EmailMaskEntityTransformer(deviceKeyWorker: deviceKeyWorker)
            emailMaskEntities = try emailMasks.map(transformer.transform(_:))
            let nextToken = result.listEmailMasksForOwner.nextToken
            return ListOutputEntity(items: emailMaskEntities, nextToken: nextToken)
        } catch {
            logger.error("ListEmailMasksForOwner result transformation failed with \(error)")
            throw error
        }
    }
}
