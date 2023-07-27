//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync
import SudoApiClient
import SudoLogging

/// Queue to handle the result events from AWS.
private let dispatchQueue = DispatchQueue(label: "com.sudoplatform.query-result-handler-queue")

/// Data implementation of the core `EmailAccountRepository`.
///
/// Allows manipulation of data on the email service, via AppSync GraphQL.
class DefaultEmailAccountRepository: EmailAccountRepository, Resetable {

    // MARK: - Supplementary

    enum Defaults {
        /// algorithm used when encrypting/decrypting with symmetric keys.
        static let symmetricAlgorithm = "AES/CBC/PKCS7Padding"
    }

    // MARK: - Properties

    /// App sync client for peforming operations against the email service.
    var appSyncClient: SudoApiClient

    /// Cryptographic key worker for this device
    var deviceKeyWorker: DeviceKeyWorker

    /// Used to log diagnostic and error information.
    var logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultEmailAccountRepository`.
    init(appSyncClient: SudoApiClient, deviceKeyWorker: DeviceKeyWorker, logger: Logger = .emailSDKLogger) {
        self.appSyncClient = appSyncClient
        self.deviceKeyWorker = deviceKeyWorker
        self.logger = logger
    }

    func reset() throws {
        try self.appSyncClient.clearCaches(options: .init(clearQueries: true, clearMutations: true, clearSubscriptions: true))
    }

    // MARK: - EmailAccountRepository

    func checkEmailAddressAvailabilityWithLocalParts(
        _ localParts: [String],
        domains: [DomainEntity]?
    ) async throws -> [EmailAddressEntity] {
        // Code is generated as a double nil so this mitigates problems with that.
        var convertedDomains: [String]?? = Optional(nil)
        if let domains = domains {
            convertedDomains = domains.map { $0.name }
        }
        let input = GraphQL.CheckEmailAddressAvailabilityInput(domains: convertedDomains, localParts: localParts)
        let query = GraphQL.CheckEmailAddressAvailabilityQuery(input: input)
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
                case ApiOperationError.invalidArgument:
                    throw SudoEmailError.invalidArgument("")
                case ApiOperationError.notSignedIn:
                    throw SudoEmailError.notSignedIn
                default:
                    throw SudoEmailError.internalError("Unexpected error: \(error)")
                }
            }
            throw SudoEmailError.internalError("Unexpected error")
        }
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
                    algorithm: Defaults.symmetricAlgorithm,
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
        let (performResult, performError) = try await self.appSyncClient.perform(mutation: mutation, queue: dispatchQueue)
        guard let result = performResult?.data else {
            if let error = performError {
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
                algorithm: Defaults.symmetricAlgorithm,
                base64EncodedSealedData: sealedAlias,
                keyId: symmetricKeyId,
                plainTextType: "string"
            )
        }
        let mutation = GraphQL.UpdateEmailAddressMetadataMutation(input: updateEmailAddressMetadataInput)
        let (performResult, performError) = try await self.appSyncClient.perform(mutation: mutation, queue: dispatchQueue)
        guard let result = performResult?.data else {
            if let error = performError {
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
        return result.updateEmailAddressMetadata
    }

    func deleteWithId(_ id: String) async throws -> EmailAccountEntity {
        let input = GraphQL.DeprovisionEmailAddressInput(emailAddressId: id)
        let mutation = GraphQL.DeprovisionEmailAddressMutation(input: input)
        let (performResult, performError) = try await self.appSyncClient.perform(mutation: mutation, queue: dispatchQueue)
        guard let result = performResult?.data else {
            if let error = performError {
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
            let transformer = EmailAccountEntityTransformer(deviceKeyWorker: deviceKeyWorker)
            let entity = try transformer.transform(result)
            return entity
        } catch {
            logger.error("DeprovisionEmailAddressMutation result transformation failed with \(error)")
            throw error
        }
    }

    func getWithEmailAddressId(_ id: String) async throws -> EmailAccountEntity? {
        let cachePolicy: CachePolicy = .cacheOnly
        return try await getEmailAddressQueryWithEmailAddressId(id, cachePolicy: cachePolicy)
    }

    func fetchWithEmailAddressId(_ id: String) async throws -> EmailAccountEntity? {
        let cachePolicy: CachePolicy = .remoteOnly
        return try await getEmailAddressQueryWithEmailAddressId(id, cachePolicy: cachePolicy)
    }

    func fetchList(
        limit: Int?,
        nextToken: String?
    ) async throws -> ListOutputEntity<EmailAccountEntity> {
        let cachePolicy: CachePolicy = .remoteOnly
        return try await listEmailAddressesQuery(
            limit: limit,
            nextToken: nextToken,
            cachePolicy: cachePolicy
        )
    }

    func list(
        limit: Int?,
        nextToken: String?
    ) async throws -> ListOutputEntity<EmailAccountEntity> {
        let cachePolicy: CachePolicy = .cacheOnly
        return try await listEmailAddressesQuery(
            limit: limit,
            nextToken: nextToken,
            cachePolicy: cachePolicy
        )
    }

    func listForSudoId(
        sudoId: String,
        cachePolicy: CachePolicy? = .remoteOnly,
        limit: Int?,
        nextToken: String?
    ) async throws -> ListOutputEntity<EmailAccountEntity> {
        let input = GraphQL.ListEmailAddressesForSudoIdInput(
            limit: limit,
            nextToken: nextToken,
            sudoId: sudoId
        )
        let query = GraphQL.ListEmailAddressesForSudoIdQuery(input: input)
        let cachePolicy = cachePolicy ?? .remoteOnly
        let cachePolicyTransformer = CachePolicyAPITransformer()
        let queryCachePolicy = cachePolicyTransformer.transform(cachePolicy)
        let (fetchResult, fetchError) = try await self.appSyncClient.fetch(
            query: query,
            cachePolicy: queryCachePolicy,
            queue: dispatchQueue
        )
        guard let result = fetchResult?.data else {
            guard let error = fetchError else {
                return ListOutputEntity(items: [], nextToken: nil)
            }
            throw SudoEmailError.internalError("\(error)")
        }
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

    // MARK: - Helpers

    func getEmailAddressQueryWithEmailAddressId(
        _ emailAddressId: String,
        cachePolicy: CachePolicy
    ) async throws -> EmailAccountEntity? {
        let query = GraphQL.GetEmailAddressQuery(id: emailAddressId)
        let cachePolicyTransformer = CachePolicyAPITransformer()
        let queryCachePolicy = cachePolicyTransformer.transform(cachePolicy)
        let (fetchResult, fetchError) = try await self.appSyncClient.fetch(
            query: query,
            cachePolicy: queryCachePolicy,
            queue: dispatchQueue
        )
        guard let result = fetchResult?.data else {
            guard let error = fetchError else {
                return nil
            }
            throw SudoEmailError.internalError("\(error)")
        }
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

    /// Performs a `ListEmailAddressesQuery` to access the email accounts.
    /// - Parameters:
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    ///   - cachePolicy: Policy to be used to detemine whether to access from the service or the cache.
    /// - Returns: List of Email Accounts.
    func listEmailAddressesQuery(
        limit: Int?,
        nextToken: String?,
        cachePolicy: CachePolicy
    ) async throws -> ListOutputEntity<EmailAccountEntity> {
        let input = GraphQL.ListEmailAddressesInput(
            limit: limit,
            nextToken: nextToken
        )
        let query = GraphQL.ListEmailAddressesQuery(input: input)
        let cachePolicyTransformer = CachePolicyAPITransformer()
        let queryCachePolicy = cachePolicyTransformer.transform(cachePolicy)
        let (fetchResult, fetchError) = try await self.appSyncClient.fetch(
            query: query,
            cachePolicy: queryCachePolicy,
            queue: dispatchQueue
        )
        guard let result = fetchResult?.data else {
            guard let error = fetchError else {
                return ListOutputEntity(items: [], nextToken: nil)
            }
            throw SudoEmailError.internalError("\(error)")
        }
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
}
