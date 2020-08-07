//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSAppSync
import Foundation
import SudoKeyManager
import SudoLogging
import SudoUser
import SudoOperations

/// Data implementation of the core `KeyRepository`.
///
/// Accesses both the local device key manager and the service via AppSync GraphQL.
class DefaultKeyRepository: KeyRepository, Resetable {

    // MARK: - Supplementary

    /// Default values used within `DefaultKeyRepository`.
    enum Defaults {
        /// algorithm used when creating/registering public keys.
        static let algorithm = "RSAEncryptionOAEPAESCBC"
    }

    /// Typealias to shorten the result of the KeyRing Query data items.
    typealias KeyRingQueryItem = GetKeyRingForEmailQuery.Data.GetKeyRingForEmail.Item

    // MARK: - Properties

    /// App sync client for peforming operations against the email service.
    unowned var appSyncClient: AWSAppSyncClient

    /// Used to log diagnostic and error information.
    var logger: Logger

    /// Operation queue for enqueuing asynchronous tasks.
    var queue: PlatformOperationQueue = PlatformOperationQueue()

    /// Utility factory class to generate mutation and query operations.
    var operationFactory: OperationFactory = OperationFactory()

    var deviceKeyWorker: DeviceKeyWorker

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultKeyRepository`.
    init(appSyncClient: AWSAppSyncClient, deviceKeyWorker: DeviceKeyWorker, logger: Logger = .emailSDKLogger) {
        self.appSyncClient = appSyncClient
        self.deviceKeyWorker = deviceKeyWorker
        self.logger = logger
    }

    /// Reset and cancel any data in the repository.
    func reset() {
        queue.cancelAllOperations()
    }

    // MARK: - KeyPairRepository

    func generate() throws -> KeyPair {
        return try deviceKeyWorker.generateKeyPair()
    }

    func getCurrentKeyPair() throws -> KeyPair? {
        return try deviceKeyWorker.getCurrentKeyPair()
    }

    func registerPublicKey(_ publicKey: KeyEntity, completion: @escaping ClientCompletion<KeyEntity>) {
        guard publicKey.type == .publicKey else {
            completion(.failure(SudoEmailError.internalError("Non publicKey passed to `registerPublicKey`")))
            return
        }
        let publicKeyString = publicKey.keyData.base64EncodedString()
        let input = CreatePublicKeyInput(keyId: publicKey.keyId, keyRingId: publicKey.keyRingId, algorithm: Defaults.algorithm, publicKey: publicKeyString)
        let mutation = CreatePublicKeyForEmailMutation(input: input)
        let operation = operationFactory.generateMutationOperation(mutation: mutation, appSyncClient: appSyncClient, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation] _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = operation.result else {
                return
            }
            do {
                let transformer = KeyEntityTransformer()
                let entity = try transformer.transformPublicKey(result)
                completion(.success(entity))
            } catch {
                completion(.failure(error))
            }
        })
        operation.addObserver(completionObserver)
        queue.addOperation(operation)
    }

    func isPublicKeyRegistered(_ publicKey: KeyEntity, completion: @escaping ClientCompletion<Bool>) {
        guard publicKey.type == .publicKey else {
            completion(.failure(SudoEmailError.internalError("Non publicKey passed to `isPublicKeyRegistered`")))
            return
        }
        let query = GetKeyRingForEmailQuery(keyRingId: publicKey.keyRingId)
        let operation = operationFactory.generateQueryOperation(query: query, appSyncClient: appSyncClient, cachePolicy: .remoteOnly, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation, weak self] _, errors in
            guard let weakSelf = self else { return }
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = operation.result?.getKeyRingForEmail else {
                return
            }
            let matchedKey = weakSelf.findMatchingKey(inRegisteredKeys: result.items, forPublicKey: publicKey)
            let keyRegistered = (matchedKey != nil)
            completion(.success(keyRegistered))
        })
        operation.addObserver(completionObserver)
        queue.addOperation(operation)
    }

    func getPublicKeyById(_ id: String, completion: @escaping ClientCompletion<KeyEntity?>) {
        let query = GetPublicKeyForEmailQuery(keyId: id)
        let operation = operationFactory.generateQueryOperation(query: query, appSyncClient: appSyncClient, cachePolicy: .remoteOnly, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation] _, errors in
            if let error = errors.first {
                completion(.failure(error))
                return
            }
            guard let result = operation.result else {
                return
            }
            do {
                let transformer = KeyEntityTransformer()
                let entity = try transformer.transformPublicKey(result)
                completion(.success(entity))
            } catch {
                completion(.failure(error))
            }
        })
        operation.addObserver(completionObserver)
        queue.addOperation(operation)
    }

    // MARK: - Helpers

    /// Find the matching key in a array of key ring result items for a public key.
    /// - Parameters:
    ///   - keys: Items to search.
    ///   - publicKey: Key to match against.
    /// - Returns: The matched key, or `nil` if no matches.
    func findMatchingKey(inRegisteredKeys keys: [KeyRingQueryItem], forPublicKey publicKey: KeyEntity) -> KeyRingQueryItem? {
        assert(publicKey.type == .publicKey)
        return keys.first(where: { key in
            let keyIdMatches = (key.keyId == publicKey.keyId)
            let keyRingIdMatches = (key.keyRingId == publicKey.keyRingId)
            return keyIdMatches && keyRingIdMatches
        })
    }

}
