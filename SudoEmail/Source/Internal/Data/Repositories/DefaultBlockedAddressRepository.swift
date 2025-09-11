//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoApiClient
import SudoKeyManager
import SudoLogging

/// Data implementation of the core `BlockedAddressRepository`
///
/// Allows manipulation of data on the email service via AppSync GraphQL
class DefaultBlockedAddressRepository: BlockedAddressRepository {

    // MARK: - Properties

    /// App sync client for peforming operations against the email service.
    var sudoApiClient: SudoApiClient

    /// Used to log diagnostic and error information.
    var logger: Logger

    /// Key pair repository to access the public key for the user's account.
    let keyWorker: DeviceKeyWorker

    /// Transformer for blockedEmailAddressActions
    let blockedAddressActionTransformer = BlockedAddressActionGQLTransformer()

    /// Initialize an instance of `DefaultBlockedAddressRepository`.
    init(appSyncClient: SudoApiClient, logger: Logger = .emailSDKLogger, keyWorker: DeviceKeyWorker) {
        sudoApiClient = appSyncClient
        self.logger = logger
        self.keyWorker = keyWorker
    }

    // MARK: - BlockedAddressRepository

    func blockAddresses(
        addresses: [String],
        action: UnsealedBlockedAddress.BlockedAddressAction,
        owner: String,
        emailAddressId: String?,
        blockLevel: BlockedEmailAddressLevel,
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
            if EmailAddressParser.validate(email: address) {
                let normalizedAddress = try EmailAddressParser.normalize(address: address)
                let stringToHash = switch blockLevel {
                case .address:
                    normalizedAddress
                case .domain:
                    EmailAddressParser.getDomain(email: normalizedAddress)
                }
                if !normalizedAddresses.contains(stringToHash) {
                    normalizedAddresses.append(stringToHash)
                    try hashedBlockedAddresses.append(EmailAddressBlocklistUtil.generateAddressHash(plaintextAddress: stringToHash, prefix: prefix))
                    try sealedBlockedValues.append(self.keyWorker.sealString(stringToHash, withKeyId: symmetricKeyId!))
                }
            } else {
                throw SudoEmailError.invalidArgument("Invalid email address: \(address)")
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
        let result = try await perform(mutation)

        var status: BatchOperationResultStatus
        let resultStatus = result.blockEmailAddresses.getBlockedAddressesStatus()
        if resultStatus == .failed {
            status = .failure
        } else if resultStatus == .partial {
            status = .partial
        } else if resultStatus == .success {
            status = .success
        } else {
            logger.error("Unknown status returned by BlockEmailAddresses mutation \(resultStatus)")
            throw SudoEmailError.internalError("Unknown status returned by BlockEmailAddresses mutation \(resultStatus)")
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
        let result = try await perform(mutation)

        var status: BatchOperationResultStatus
        let resultStatus = result.unblockEmailAddresses.getBlockedAddressesStatus()
        if resultStatus == .failed {
            status = .failure
        } else if resultStatus == .partial {
            status = .partial
        } else if resultStatus == .success {
            status = .success
        } else {
            logger.error("Unknown status returned by UnblockEmailAddresses mutation \(resultStatus)")
            throw SudoEmailError.internalError("Unknown status returned by UnblockEmailAddresses mutation \(resultStatus)")
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
        let result = try await fetch(query)
        if result.getEmailAddressBlocklist.blockedAddresses.isEmpty {
            return []
        }
        var unsealedBlockedAddresses: [UnsealedBlockedAddress] = []
        let transformer = BlockedEmailAddressTransformer(deviceKeyWorker: keyWorker)
        unsealedBlockedAddresses = try result.getEmailAddressBlocklist.blockedAddresses.map(transformer.transform(_:))

        return unsealedBlockedAddresses
    }
}
