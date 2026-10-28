//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SudoApiClient
import SudoLogging

/// Data implementation of the core `EmailAliasRepository`.
///
/// Allows manipulation of email alias data on the email service, via AppSync GraphQL.
class DefaultEmailAliasRepository: EmailAliasRepository, Repository {

    // MARK: - Properties

    /// App sync client for performing operations against the email service.
    var sudoApiClient: SudoApiClient

    /// Cryptographic key worker for this device
    var deviceKeyWorker: DeviceKeyWorker

    /// Used to log diagnostic and error information.
    var logger: SudoLogging.Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultEmailAliasRepository`.
    init(appSyncClient: SudoApiClient, deviceKeyWorker: DeviceKeyWorker, logger: SudoLogging.Logger = .emailSDKLogger) {
        sudoApiClient = appSyncClient
        self.deviceKeyWorker = deviceKeyWorker
        self.logger = logger
    }

    // MARK: - EmailAliasRepository

    func provisionEmailAlias(
        aliasAddress: String,
        realAddress: String,
        ownershipProofToken: String,
        publicKey: KeyEntity,
        metadata: [String: String]?,
        expiresAt: Date?
    ) async throws -> EmailAliasEntity {
        logger.debug("Provisioning email alias: \(aliasAddress) -> \(realAddress)")

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
            maskAddress: aliasAddress,
            metadata: sealedMetadata,
            ownershipProofTokens: [ownershipProofToken],
            realAddress: realAddress
        )

        let mutation = GraphQL.ProvisionEmailMaskMutation(input: provisionEmailMaskInput)
        let result = try await perform(mutation)

        let transformer = EmailAliasEntityTransformer(deviceKeyWorker: deviceKeyWorker)
        return try transformer.transform(result)
    }

    func deprovisionEmailAlias(emailAliasId: String) async throws -> EmailAliasEntity {
        logger.debug("Deprovisioning email alias with ID: \(emailAliasId)")
        let deprovisionEmailMaskInput = GraphQL.DeprovisionEmailMaskInput(
            emailMaskId: emailAliasId
        )

        let mutation = GraphQL.DeprovisionEmailMaskMutation(input: deprovisionEmailMaskInput)
        let result = try await perform(mutation)

        let transformer = EmailAliasEntityTransformer(deviceKeyWorker: deviceKeyWorker)
        return try transformer.transform(result)
    }

    func updateEmailAlias(
        emailAliasId: String,
        metadata: [String: String]?,
        expiresAt: Date?,
        realAddress: String?
    ) async throws -> EmailAliasEntity {
        logger.debug("Updating email alias with ID: \(emailAliasId)")
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
        // Use double optional pattern: .none means don't include field, .some(value) means include it
        let realAddressInput: String?? = realAddress.map { .some($0) } ?? .none

        let updateEmailMaskInput = GraphQL.UpdateEmailMaskInput(
            expiresAtEpochSec: expiresAtEpochSec,
            id: emailAliasId,
            metadata: sealedMetadata,
            realAddress: realAddressInput
        )

        let mutation = GraphQL.UpdateEmailMaskMutation(input: updateEmailMaskInput)
        let result = try await perform(mutation)

        let transformer = EmailAliasEntityTransformer(deviceKeyWorker: deviceKeyWorker)
        return try transformer.transform(result)
    }

    func enableEmailAlias(emailAliasId: String) async throws -> EmailAliasEntity {
        logger.debug("Enabling email alias with ID: \(emailAliasId)")
        let enableEmailMaskInput = GraphQL.EnableEmailMaskInput(
            emailMaskId: emailAliasId
        )

        let mutation = GraphQL.EnableEmailMaskMutation(input: enableEmailMaskInput)
        let result = try await perform(mutation)

        let transformer = EmailAliasEntityTransformer(deviceKeyWorker: deviceKeyWorker)
        return try transformer.transform(result)
    }

    func disableEmailAlias(emailAliasId: String) async throws -> EmailAliasEntity {
        logger.debug("Disabling email alias with ID: \(emailAliasId)")
        let disableEmailMaskInput = GraphQL.DisableEmailMaskInput(
            emailMaskId: emailAliasId
        )

        let mutation = GraphQL.DisableEmailMaskMutation(input: disableEmailMaskInput)
        let result = try await perform(mutation)

        let transformer = EmailAliasEntityTransformer(deviceKeyWorker: deviceKeyWorker)
        return try transformer.transform(result)
    }

    func verifyExternalEmailAddress(emailAddress: String, emailAliasId: String, verificationCode: String?) async throws -> VerifyExternalEmailAddressResultEntity {
        logger.debug("Verifying external email address for alias ID: \(emailAliasId)")

        // Use double optional pattern: .none means don't include field, .some(value) means include it
        let verificationCodeInput: String?? = verificationCode.map { .some($0) } ?? .none

        let verifyInput = GraphQL.VerifyExternalEmailAddressInput(
            emailAddress: emailAddress,
            emailMaskId: emailAliasId,
            verificationCode: verificationCodeInput
        )

        let mutation = GraphQL.VerifyExternalEmailAddressMutation(input: verifyInput)
        let result = try await perform(mutation)

        // If response is nil/undefined, it means verification email was sent
        // Return a result indicating not yet verified
        guard let verifyResult = result.verifyExternalEmailAddress else {
            return VerifyExternalEmailAddressResultEntity(
                isVerified: false,
                reason: "Verification email sent"
            )
        }

        return VerifyExternalEmailAddressResultEntity(
            isVerified: verifyResult.isVerified,
            reason: verifyResult.reason
        )
    }

    func listEmailAliasesForOwner(filter: EmailAliasFilterEntity?, limit: Int?, nextToken: String?) async throws -> ListOutputEntity<EmailAliasEntity> {
        logger.debug("Listing email aliases for owner with limit: \(limit ?? -1), nextToken: \(nextToken ?? "nil")")

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
            var emailMaskEntities: [EmailAliasEntity] = []
            let emailMasks = result.listEmailMasksForOwner.items
            let transformer = EmailAliasEntityTransformer(deviceKeyWorker: deviceKeyWorker)
            emailMaskEntities = try emailMasks.map(transformer.transform(_:))
            let nextToken = result.listEmailMasksForOwner.nextToken
            return ListOutputEntity(items: emailMaskEntities, nextToken: nextToken)
        } catch {
            logger.error("ListEmailMasksForOwner result transformation failed with \(error)")
            throw error
        }
    }
}
