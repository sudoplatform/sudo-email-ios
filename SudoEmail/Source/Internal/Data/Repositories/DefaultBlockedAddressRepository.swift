//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoApiClient
import SudoLogging
import SudoKeyManager

/// Queue to handle the result events from AWS.
private let dispatchQueue = DispatchQueue(label: "com.sudoplatform.query-result-handler-queue")

/// Data implementation of the core `BlockedAddressRepository`
///
/// Allows manipulation of data on the email service via AppSync GraphQL
class DefaultBlockedAddressRepository: BlockedAddressRepository, Resetable {
    
    enum Defaults {
        /// algorithm used when encrypting/decrypting with symmetric keys.
        static let symmetricAlgorithm = "AES/CBC/PKCS7Padding"
    }
    
    // MARK: - Properties

    /// App sync client for peforming operations against the email service.
    var appSyncClient: SudoApiClient
    
    /// Used to log diagnostic and error information.
    var logger: Logger
    
    /// Key pair repository to access the public key for the user's account.
    let keyWorker: DeviceKeyWorker
    
    /// Initialize an instance of `DefaultBlockedAddressRepository`.
    init(appSyncClient: SudoApiClient, logger: Logger = .emailSDKLogger, keyWorker: DeviceKeyWorker) {
        self.appSyncClient = appSyncClient
        self.logger = logger
        self.keyWorker = keyWorker
    }
    
    func reset() throws {
        try self.appSyncClient.clearCaches(options: .init(clearQueries: true, clearMutations: true, clearSubscriptions: true))
    }
    
    // MARK: - BlockedAddressRepository
    
    func blockAddresses(addresses: [String], owner: String) async throws -> BatchOperationResult<String> {
        self.logger.debug("blockAddresses init: \(owner), \(addresses)")
        if (addresses.isEmpty) {
            self.logger.error("At least one email address must be passed")
            throw SudoEmailError.invalidArgument("At least one email address must be passed")
        }
        
        let symmetricKeyId = try self.keyWorker.getCurrentSymmetricKeyId()
        
        if (symmetricKeyId == nil) {
            self.logger.error("No symmetric key found")
            throw SudoEmailError.keyNotFound
        }

        var normalizedAddresses: [String] = []
        var hashedBlockedAddresses: [String] = []
        var sealedBlockedValues: [String] = []
        
        try addresses.forEach { address in
            let normalizedAddress = try EmailAddressParser.normalize(address: address)
            if (normalizedAddresses.contains(normalizedAddress)) {
                self.logger.error("Duplicate email address found")
                throw SudoEmailError.invalidArgument("Duplicate email address found. Please include each address only once")
            }
            normalizedAddresses.append(normalizedAddress)
            try hashedBlockedAddresses.append(EmailAddressBlocklistUtil.generateAddressHash(plaintextAddress: normalizedAddress, ownerId: owner))
            try sealedBlockedValues.append(self.keyWorker.sealString(normalizedAddress, withKeyId: symmetricKeyId!))
        }
        
        let blockedAddresses = addresses.enumerated().map { (index, address) in
            return GraphQL.BlockedEmailAddressInput(hashAlgorithm: GraphQL.BlockedAddressHashAlgorithm.sha256,
                hashedBlockedValue: hashedBlockedAddresses[index],
                sealedValue: GraphQL.SealedAttributeInput(
                    algorithm: Defaults.symmetricAlgorithm,
                    base64EncodedSealedData: sealedBlockedValues[index],
                    keyId: symmetricKeyId!,
                    plainTextType: "string"
                )
            )
        }
        
        let input = GraphQL.BlockEmailAddressesInput(blockedAddresses: blockedAddresses, owner: owner)
        
        let mutation = GraphQL.BlockEmailAddressesMutation(input: input)
        
        let (performResult, performError) = try await self.appSyncClient.perform(mutation: mutation, queue: dispatchQueue)
        
        guard let result = performResult?.data else {
            if let error = performError {
                switch error {
                case ApiOperationError.notSignedIn:
                    self.logger.error("User not logged in")
                    throw SudoEmailError.notSignedIn
                case ApiOperationError.graphQLError(let cause):
                    guard let sudoEmailError = SudoEmailError(graphQLError: cause) else {
                        self.logger.error("Unexpected error: \(String(describing:error))")
                        throw SudoEmailError.internalError("Unexpected error?: \(String(describing:error))")
                    }
                    throw sudoEmailError
                default:
                    self.logger.error("Unexpected error: \(String(describing:error))")
                    throw SudoEmailError.internalError("Unexpected error: \(String(describing:error))")
                }
            }
            self.logger.error("Unexpected error")
            throw SudoEmailError.internalError("Unexpected error")
        }
        
        switch result.blockEmailAddresses.status {
        case .success:
            return BatchOperationResult<String>.success
        case .failed:
            return BatchOperationResult<String>.failure
        case .partial:
            let partialResult = BatchOperationResult.BatchOperationPartialResult(
                successItems: result.blockEmailAddresses.successAddresses ?? [],
                failureItems: result.blockEmailAddresses.failedAddresses ?? []
            )
            return BatchOperationResult<String>.partial(partialResult)
        case .unknown:
            self.logger.error("Unknown status returned by BlockEmailAddresses mutation")
            throw SudoEmailError.internalError("Unknown status returned by BlockEmailAddresses mutation")
        }
    }
    
    func unblockAddresses(hashedAddresses: [String], owner: String) async throws -> BatchOperationResult<String> {
        self.logger.debug("unblockAddresses init: \(hashedAddresses) \(owner)")
        
        let input = GraphQL.UnblockEmailAddressesInput(owner: owner, unblockedAddresses: hashedAddresses)
        
        let mutation = GraphQL.UnblockEmailAddressesMutation(input: input)
        
        let (performResult, performError) = try await self.appSyncClient.perform(mutation: mutation, queue: dispatchQueue)
        
        guard let result = performResult?.data else {
            if let error = performError {
                switch error {
                case ApiOperationError.notSignedIn:
                    self.logger.error("User not logged in")
                    throw SudoEmailError.notSignedIn
                case ApiOperationError.graphQLError(let cause):
                    guard let sudoEmailError = SudoEmailError(graphQLError: cause) else {
                        self.logger.error("Unexpected error: \(String(describing:error))")
                        throw SudoEmailError.internalError("Unexpected error?: \(String(describing:error))")
                    }
                    throw sudoEmailError
                default:
                    self.logger.error("Unexpected error: \(String(describing:error))")
                    throw SudoEmailError.internalError("Unexpected error: \(String(describing:error))")
                }
            }
            self.logger.error("Unexpected error")
            throw SudoEmailError.internalError("Unexpected error")
        }
        
        switch result.unblockEmailAddresses.status {
        case .success:
            return BatchOperationResult<String>.success
        case .failed:
            return BatchOperationResult<String>.failure
        case.partial:
            let partialResult = BatchOperationResult.BatchOperationPartialResult(
                successItems: result.unblockEmailAddresses.successAddresses ?? [],
                failureItems: result.unblockEmailAddresses.failedAddresses ?? []
            )
            return BatchOperationResult<String>.partial(partialResult)
        case .unknown:
            self.logger.error("Unknown status returned by UnblockEmailAddresses mutation")
            throw SudoEmailError.internalError("Unknown status returned by UnblockEmailAddresses mutation")
        }
    }
    
    func getEmailAddressBlocklist(owner: String) async throws -> [UnsealedBlockedAddress] {
        let input = GraphQL.GetEmailAddressBlocklistInput(owner: owner)
        
        let query = GraphQL.GetEmailAddressBlocklistQuery(input: input)
        let cachePolicy = CachePolicy.remoteOnly
        let cachePolicyTransformer = CachePolicyAPITransformer()
        let queryCachePolicy = cachePolicyTransformer.transform(cachePolicy)
        
        let (fetchResult, fetchError) = try await self.appSyncClient.fetch(
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
        
        if (result.getEmailAddressBlocklist.blockedAddresses.isEmpty) {
            return []
        }
        
        var unsealedBlockedAddresses: [UnsealedBlockedAddress] = []
        let transformer = BlockedEmailAddressTransformer(deviceKeyWorker: keyWorker)
        unsealedBlockedAddresses = try result.getEmailAddressBlocklist.blockedAddresses.map(transformer.transform(_:))

        
        return unsealedBlockedAddresses
    }
}
