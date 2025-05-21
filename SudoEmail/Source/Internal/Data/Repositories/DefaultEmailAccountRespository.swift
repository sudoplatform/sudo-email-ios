//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SudoApiClient
import SudoLogging

/// Data implementation of the core `EmailAccountRepository`.
///
/// Allows manipulation of data on the email service, via AppSync GraphQL.
class DefaultEmailAccountRepository: EmailAccountRepository {

    // MARK: - Properties

    /// App sync client for peforming operations against the email service.
    var sudoApiClient: SudoApiClient

    /// Cryptographic key worker for this device
    var deviceKeyWorker: DeviceKeyWorker

    /// Used to log diagnostic and error information.
    var logger: SudoLogging.Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultEmailAccountRepository`.
    init(appSyncClient: SudoApiClient, deviceKeyWorker: DeviceKeyWorker, logger: SudoLogging.Logger = .emailSDKLogger) {
        sudoApiClient = appSyncClient
        self.deviceKeyWorker = deviceKeyWorker
        self.logger = logger
    }

    // MARK: - EmailAccountRepository

    func checkEmailAddressAvailabilityWithLocalParts(
        _ localParts: [String],
        domains: [DomainEntity]?
    ) async throws -> [EmailAddressEntity] {
        // Code is generated as a double nil so this mitigates problems with that.
        var convertedDomains: [String]?? = Optional(nil)
        if let domains = domains {
            convertedDomains = domains.map(\.name)
        }
        let input = GraphQL.CheckEmailAddressAvailabilityInput(domains: convertedDomains, localParts: localParts)
        let query = GraphQL.CheckEmailAddressAvailabilityQuery(input: input)
        let result = try await fetch(query)
        do {
            let transformer = EmailAddressEntityTransformer()
            let entities = try result.checkEmailAddressAvailability.addresses.map {
                try transformer.transform($0, alias: nil)
            }
            return entities
        } catch {
            logger.error("CheckEmailAddressAvailabilityQuery result transformation failed with \(error)")
            throw error
        }
    }

    func createWithEmailAddress(
        _ emailAddress: EmailAddressEntity,
        publicKey: KeyEntity,
        ownershipProofToken: String
    ) async throws -> EmailAccountEntity {
        let publicKeyData = publicKey.keyData.base64EncodedString()
        let createPublicKeyInput = GraphQL.ProvisionEmailAddressPublicKeyInput(
            algorithm: DefaultDeviceKeyWorker.Defaults.algorithm,
            keyId: publicKey.keyId,
            publicKey: publicKeyData
        )
        let symmetricKeyId = try (deviceKeyWorker.getCurrentSymmetricKeyId()) ??
            (deviceKeyWorker.generateNewCurrentSymmetricKey())

        var input: GraphQL.ProvisionEmailAddressInput
        if let alias = emailAddress.alias {
            let sealedAlias = try deviceKeyWorker.sealString(
                alias,
                withKeyId: symmetricKeyId
            )
            input = GraphQL.ProvisionEmailAddressInput(
                alias: .init(
                    algorithm: DefaultDeviceKeyWorker.Defaults.symmetricAlgorithm,
                    base64EncodedSealedData: sealedAlias,
                    keyId: symmetricKeyId,
                    plainTextType: "string"
                ),
                emailAddress: emailAddress.emailAddress,
                key: createPublicKeyInput,
                ownershipProofTokens: [ownershipProofToken]
            )
        } else {
            input = GraphQL.ProvisionEmailAddressInput(
                emailAddress: emailAddress.emailAddress,
                key: createPublicKeyInput,
                ownershipProofTokens: [ownershipProofToken]
            )
        }
        let mutation = GraphQL.ProvisionEmailAddressMutation(input: input)
        let result = try await perform(mutation)
        do {
            let transformer = EmailAccountEntityTransformer(deviceKeyWorker: deviceKeyWorker)
            let entity = try transformer.transform(result)
            return entity
        } catch {
            logger.error("ProvisionEmailAddressMutation result transformation failed with \(error)")
            throw error
        }
    }

    func updateMetadata(id: String, values: UpdateEmailAddressMetadataValues) async throws -> String {
        guard let symmetricKeyId = try deviceKeyWorker.getCurrentSymmetricKeyId() else {
            throw SudoEmailError.keyNotFound
        }

        var updateEmailAddressMetadataInput = GraphQL.UpdateEmailAddressMetadataInput(
            id: id,
            values: .init()
        )
        if let alias = values.alias {
            let sealedAlias = try deviceKeyWorker.sealString(
                alias,
                withKeyId: symmetricKeyId
            )
            updateEmailAddressMetadataInput.values.alias = .init(
                algorithm: DefaultDeviceKeyWorker.Defaults.symmetricAlgorithm,
                base64EncodedSealedData: sealedAlias,
                keyId: symmetricKeyId,
                plainTextType: "string"
            )
        }
        let mutation = GraphQL.UpdateEmailAddressMetadataMutation(input: updateEmailAddressMetadataInput)
        let result = try await perform(mutation)
        return result.updateEmailAddressMetadata
    }

    func deleteWithId(_ id: String) async throws -> EmailAccountEntity {
        let input = GraphQL.DeprovisionEmailAddressInput(emailAddressId: id)
        let mutation = GraphQL.DeprovisionEmailAddressMutation(input: input)
        let result = try await perform(mutation)
        do {
            let transformer = EmailAccountEntityTransformer(deviceKeyWorker: deviceKeyWorker)
            let entity = try transformer.transform(result)
            return entity
        } catch {
            logger.error("DeprovisionEmailAddressMutation result transformation failed with \(error)")
            throw error
        }
    }

    func fetchWithEmailAddressId(_ id: String) async throws -> EmailAccountEntity? {
        let query = GraphQL.GetEmailAddressQuery(id: id)
        let result = try await fetch(query)
        do {
            let transformer = EmailAccountEntityTransformer(deviceKeyWorker: deviceKeyWorker)
            guard let emailAddress = result.getEmailAddress else {
                return nil
            }
            let entity = try transformer.transform(emailAddress)
            return entity
        } catch {
            logger.error("GetEmailAddressQuery result transformation failed with \(error)")
            throw error
        }
    }

    func list(limit: Int?, nextToken: String?) async throws -> ListOutputEntity<EmailAccountEntity> {
        let input = GraphQL.ListEmailAddressesInput(limit: limit, nextToken: nextToken)
        let query = GraphQL.ListEmailAddressesQuery(input: input)
        let result = try await fetch(query)
        do {
            var emailAccountEntities: [EmailAccountEntity] = []
            let emailAddresses = result.listEmailAddresses.items
            let transformer = EmailAccountEntityTransformer(deviceKeyWorker: deviceKeyWorker)
            emailAccountEntities = try emailAddresses.map(transformer.transform(_:))
            let nextToken = result.listEmailAddresses.nextToken
            return ListOutputEntity(items: emailAccountEntities, nextToken: nextToken)
        } catch {
            logger.error("ListEmailAddressesQuery result transformation failed with \(error)")
            throw error
        }
    }

    func listForSudoId(
        sudoId: String,
        limit: Int?,
        nextToken: String?
    ) async throws -> ListOutputEntity<EmailAccountEntity> {
        let input = GraphQL.ListEmailAddressesForSudoIdInput(limit: limit, nextToken: nextToken, sudoId: sudoId)
        let query = GraphQL.ListEmailAddressesForSudoIdQuery(input: input)
        let result = try await fetch(query)
        do {
            var emailAccountEntities: [EmailAccountEntity] = []
            let emailAddresses = result.listEmailAddressesForSudoId.items
            let transformer = EmailAccountEntityTransformer(deviceKeyWorker: deviceKeyWorker)
            emailAccountEntities = try emailAddresses.map(transformer.transform(_:))
            let nextToken = result.listEmailAddressesForSudoId.nextToken
            return ListOutputEntity(items: emailAccountEntities, nextToken: nextToken)
        } catch {
            logger.error("ListEmailAddressesQuery result transformation failed with \(error)")
            throw error
        }
    }

    func lookupPublicInfo(emailAddresses: [String]) async throws -> [EmailAddressPublicInfoEntity] {
        let input = GraphQL.LookupEmailAddressesPublicInfoInput(emailAddresses: emailAddresses)
        let query = GraphQL.LookupEmailAddressesPublicInfoQuery(input: input)
        let result = try await fetch(query)
        let transformer = EmailAddressPublicInfoEntityTransformer()
        return transformer.transform(result)
    }
}
