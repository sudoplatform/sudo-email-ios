//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoApiClient
import SudoKeyManager
import SudoLogging

/// Queue to handle the result events from AWS.
private let dispatchQueue = DispatchQueue(label: "com.sudoplatform.query-result-handler-queue")

/// Data implementation of the core `BlockedAddressRepository`
///
/// Allows manipulation of data on the email service via AppSync GraphQL
class DefaultBlockedAddressRepository: BlockedAddressRepository, Resetable {

    // MARK: - Properties

    /// App sync client for peforming operations against the email service.
    var appSyncClient: SudoApiClient

    /// Used to log diagnostic and error information.
    var logger: Logger

    /// Key pair repository to access the public key for the user's account.
    let keyWorker: DeviceKeyWorker

    /// Transformer for blockedEmailAddressActions
    let blockedAddressActionTransformer = BlockedAddressActionGQLTransformer()

    /// Initialize an instance of `DefaultBlockedAddressRepository`.
    init(appSyncClient: SudoApiClient, logger: Logger = .emailSDKLogger, keyWorker: DeviceKeyWorker) {
        self.appSyncClient = appSyncClient
        self.logger = logger
        self.keyWorker = keyWorker
    }

    func reset() throws {
        try appSyncClient.clearCaches(options: .init(clearQueries: true, clearMutations: true, clearSubscriptions: true))
    }

    // MARK: - BlockedAddressRepository

    func blockAddresses(
        addresses: [String],
        action: UnsealedBlockedAddress.BlockedAddressAction,
        owner: String,
        emailAddressId: String?
    ) async throws -> BatchOperationResult<String, String> {
        logger.debug("blockAddresses init: \(owner), \(addresses)")
        if addresses.isEmpty {
            logger.error("At least one email address must be passed")
            throw SudoEmailError.invalidArgument("At least one email address must be passed")
        }

        let symmetricKeyId = try keyWorker.getCurrentSymmetricKeyId()

        if symmetricKeyId == nil {
            logger.error("No symmetric key found")
            throw SudoEmailError.keyNotFound
        }

        var normalizedAddresses: [String] = []
        var hashedBlockedAddresses: [String] = []
        var sealedBlockedValues: [String] = []
        let prefix = emailAddressId?.nilIfEmpty ?? owner

        try addresses.forEach { address in
            let normalizedAddress = try EmailAddressParser.normalize(address: address)
            if !normalizedAddresses.contains(normalizedAddress) {
                normalizedAddresses.append(normalizedAddress)
                try hashedBlockedAddresses.append(EmailAddressBlocklistUtil.generateAddressHash(plaintextAddress: normalizedAddress, prefix: prefix))
                try sealedBlockedValues.append(self.keyWorker.sealString(normalizedAddress, withKeyId: symmetricKeyId!))
            }
        }

        let blockedAddresses = normalizedAddresses.enumerated().map { index, _ in
            return GraphQL.BlockedEmailAddressInput(
                action: blockedAddressActionTransformer.transform(action),
                hashAlgorithm: GraphQL.BlockedAddressHashAlgorithm.sha256,
                hashedBlockedValue: hashedBlockedAddresses[index],
                sealedValue: GraphQL.SealedAttributeInput(
                    algorithm: DefaultDeviceKeyWorker.Defaults.symmetricAlgorithm,
                    base64EncodedSealedData: sealedBlockedValues[index],
                    keyId: symmetricKeyId!,
                    plainTextType: "string"
                )
            )
        }
        
        let input: GraphQL.BlockEmailAddressesInput
        if let emailAddressId, !emailAddressId.isEmpty {
            input = GraphQL.BlockEmailAddressesInput(
                blockedAddresses: blockedAddresses,
                emailAddressId: emailAddressId,
                owner: owner
            )
        } else {
            input = GraphQL.BlockEmailAddressesInput(blockedAddresses: blockedAddresses, owner: owner)
        }
        let mutation = GraphQL.BlockEmailAddressesMutation(input: input)

        let (performResult, performError) = try await appSyncClient.perform(mutation: mutation, queue: dispatchQueue)

        guard let result = performResult?.data else {
            if let error = performError {
                switch error {
                case ApiOperationError.notSignedIn:
                    logger.error("User not logged in")
                    throw SudoEmailError.notSignedIn
                case ApiOperationError.graphQLError(let cause):
                    guard let sudoEmailError = SudoEmailError(graphQLError: cause) else {
                        logger.error("Unexpected error: \(String(describing: error))")
                        throw SudoEmailError.internalError("Unexpected error?: \(String(describing: error))")
                    }
                    throw sudoEmailError
                default:
                    logger.error("Unexpected error: \(String(describing: error))")
                    throw SudoEmailError.internalError("Unexpected error: \(String(describing: error))")
                }
            }
            logger.error("Unexpected error")
            throw SudoEmailError.internalError("Unexpected error")
        }

        var status: BatchOperationResultStatus
        if result.blockEmailAddresses.status == .failed {
            status = .failure
        } else if result.blockEmailAddresses.status == .partial {
            status = .partial
        } else if result.blockEmailAddresses.status == .success {
            status = .success
        } else {
            logger.error("Unknown status returned by BlockEmailAddresses mutation \(result.blockEmailAddresses.status)")
            throw SudoEmailError.internalError("Unknown status returned by BlockEmailAddresses mutation \(result.blockEmailAddresses.status)")
        }
        return BatchOperationResult<String, String>(
            status: status,
            successItems: result.blockEmailAddresses.successAddresses,
            failureItems: result.blockEmailAddresses.failedAddresses
        )
    }

    func unblockAddresses(hashedAddresses: [String], owner: String) async throws -> BatchOperationResult<String, String> {
        logger.debug("unblockAddresses init: \(hashedAddresses) \(owner)")

        let input = GraphQL.UnblockEmailAddressesInput(owner: owner, unblockedAddresses: hashedAddresses)

        let mutation = GraphQL.UnblockEmailAddressesMutation(input: input)

        let (performResult, performError) = try await appSyncClient.perform(mutation: mutation, queue: dispatchQueue)

        guard let result = performResult?.data else {
            if let error = performError {
                switch error {
                case ApiOperationError.notSignedIn:
                    logger.error("User not logged in")
                    throw SudoEmailError.notSignedIn
                case ApiOperationError.graphQLError(let cause):
                    guard let sudoEmailError = SudoEmailError(graphQLError: cause) else {
                        logger.error("Unexpected error: \(String(describing: error))")
                        throw SudoEmailError.internalError("Unexpected error?: \(String(describing: error))")
                    }
                    throw sudoEmailError
                default:
                    logger.error("Unexpected error: \(String(describing: error))")
                    throw SudoEmailError.internalError("Unexpected error: \(String(describing: error))")
                }
            }
            logger.error("Unexpected error")
            throw SudoEmailError.internalError("Unexpected error")
        }

        var status: BatchOperationResultStatus
        if result.unblockEmailAddresses.status == .failed {
            status = .failure
        } else if result.unblockEmailAddresses.status == .partial {
            status = .partial
        } else if result.unblockEmailAddresses.status == .success {
            status = .success
        } else {
            logger.error("Unknown status returned by UnblockEmailAddresses mutation \(result.unblockEmailAddresses.status)")
            throw SudoEmailError.internalError("Unknown status returned by UnblockEmailAddresses mutation \(result.unblockEmailAddresses.status)")
        }
        return BatchOperationResult<String, String>(
            status: status,
            successItems: result.unblockEmailAddresses.successAddresses,
            failureItems: result.unblockEmailAddresses.failedAddresses
        )
    }

    func unblockCleartextAddresses(cleartextAddresses: [String], owner: String) async throws -> BatchOperationResult<String, String> {
        var normalizedAddresses: [String] = []
        var hashedAddresses: [String] = []

        try cleartextAddresses.forEach { address in
            let normalizedAddress = try EmailAddressParser.normalize(address: address)
            if !normalizedAddresses.contains(normalizedAddress) {
                normalizedAddresses.append(normalizedAddress)
                try hashedAddresses.append(EmailAddressBlocklistUtil.generateAddressHash(plaintextAddress: normalizedAddress, prefix: owner))
            }
        }

        return try await unblockAddresses(hashedAddresses: hashedAddresses, owner: owner)
    }

    func getEmailAddressBlocklist(owner: String) async throws -> [UnsealedBlockedAddress] {
        let input = GraphQL.GetEmailAddressBlocklistInput(owner: owner)

        let query = GraphQL.GetEmailAddressBlocklistQuery(input: input)
        let cachePolicy = CachePolicy.remoteOnly
        let cachePolicyTransformer = CachePolicyAPITransformer()
        let queryCachePolicy = cachePolicyTransformer.transform(cachePolicy)

        let (fetchResult, fetchError) = try await appSyncClient.fetch(
            query: query,
            cachePolicy: queryCachePolicy,
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

        if result.getEmailAddressBlocklist.blockedAddresses.isEmpty {
            return []
        }

        var unsealedBlockedAddresses: [UnsealedBlockedAddress] = []
        let transformer = BlockedEmailAddressTransformer(deviceKeyWorker: keyWorker)
        unsealedBlockedAddresses = try result.getEmailAddressBlocklist.blockedAddresses.map(transformer.transform(_:))

        return unsealedBlockedAddresses
    }
}
