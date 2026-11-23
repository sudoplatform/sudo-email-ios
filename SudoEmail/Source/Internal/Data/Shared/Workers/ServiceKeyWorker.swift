//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import Security
import SudoKeyManager
import SudoLogging
import SudoUser
import Synchronization

typealias KeyPair = (publicKey: KeyEntity, privateKey: KeyEntity)

/// Result of `ServiceKeyWorker.createSingletonKeyPairIfAbsent()`.
struct SingletonKeyPairResult {
    /// Public key of the singleton key pair.
    let key: KeyEntity
    /// `true` if the call created the singleton key pair, `false` if it already existed.
    let created: Bool
}

protocol ServiceKeyWorker: DeviceKeyWorker {

    /// Get the public key of the singleton key pair. Never creates one.
    ///
    /// - Returns: The singleton's public key `KeyEntity`, or nil if no singleton is recorded or its
    ///   private key is not on this device.
    /// - Throws: `SudoEmailError.internalError` if the singleton's private key is on this device but its
    ///   public key is not.
    func getSingletonKeyPair() async throws -> KeyEntity?

    /// Get the singleton key pair, creating it if there isn't one.
    ///
    /// Does not change the current key pair. If the recorded singleton's private key is missing from this
    /// device, a replacement singleton is created and the replacement is reported as an error.
    ///
    /// - Returns: The singleton's public key, and whether this call created it.
    /// - Throws: `SudoEmailError`.
    func createSingletonKeyPairIfAbsent() async throws -> SingletonKeyPairResult

    /// The id of the singleton key pair, or nil if none has been created. The key pair itself may not be on this
    /// device.
    /// - Throws: An error from the key manager.
    func singletonKeyId() throws -> String?

    /// Remove a key pair from the device. Removing the singleton key pair is a no-op.
    ///
    /// If the key pair is the current key pair, the current key pair pointer is removed too.
    ///
    /// - Parameter keyId: Identifier of the key pair to remove.
    /// - Throws: `SudoEmailError`.
    func removeKeyPair(keyId: String) throws

    /// Generate a key pair on the device. Returns the freshly generated key pair.
    /// Throws: `SudoEmailError`.
    func generateKeyPair() async throws -> KeyPair

    /// Get the Public Key matching the key id if it exists.
    ///
    /// - Parameter keyId: Identifier of the Public Key to retrieve.
    /// - Returns: The Public Key `KeyEntity` matching the provided key id, or nil
    /// - Throws: `SudoEmailError`.
    func getPublicKeyWithId(keyId: String) async throws -> KeyEntity?
}

class DefaultServiceKeyWorker: DefaultDeviceKeyWorker, ServiceKeyWorker {

    // MARK: - Supplementary

    /// Default values used within `DefaultServiceKeyWorker`.
    enum Defaults {
        /// Key name for the current key pair id to access on the key manager.
        static let currentKeyPairIdPointerName: String = "current"
        /// Key name for the current symmetric key id to access on the key manager.
        static let currentSymmetricKeyIdPointerName: String = "email-symmetric-key"
        /// Tag name used for the key manager initialization.
        static let keyManagerKeyTag = "com.sudoplatform"
        /// Key ring service name used for the key manager initialization.
        static let keyRingServiceName = "sudo-email"
        /// Size of the AES symmetric key in bits.
        static let aesKeySize = 256
        /// RSA block size in bytes.
        static let rsaBlockSize = 256
        /// algorithm used when creating/registering public keys.
        static let algorithm = "RSAEncryptionOAEPAESCBC"
        /// The format to use when creating public keys.
        static let publicKeyFormat = PublicKeyFormatEntity.rsaPublicKey
        /// Key name of the password whose value is the singleton key pair's id.
        static let singletonKeyIdName = "singleton-key-id"
    }

    /// Key id and public key data of a key pair in the key manager.
    typealias StoredPublicKey = (keyId: String, publicKey: Data)

    // MARK: - Properties

    /// Guards every read-modify-write of the singleton key id's record. The state it protects lives in the
    /// key manager, so the mutex holds no value of its own.
    let singletonLock = Mutex(())

    /// User client for getting the subject (owner identifier) of the user for key ring id.
    var userClient: SudoUserClient

    // MARK: - Lifecycle

    convenience init(
        keyNamespace: String,
        userClient: SudoUserClient,
        logger: Logger = .emailSDKLogger
    ) {
        let keyManager = LegacySudoKeyManager(serviceName: Defaults.keyRingServiceName, keyTag: Defaults.keyManagerKeyTag, namespace: keyNamespace)
        self.init(keyManager: keyManager, userClient: userClient, logger: logger)
    }

    init(keyManager: SudoKeyManager, userClient: SudoUserClient, logger: Logger) {
        self.userClient = userClient
        super.init(keyManager: keyManager, logger: logger)
    }

    // MARK: - Overrides

    override func importKeys(archiveData: Data) throws {
        // Import replaces the singleton key id's record along with every key.
        try withSingletonLock {
            try super.importKeys(archiveData: archiveData)
            do {
                try restoreSingletonPublicKey()
            } catch let error as SudoEmailError {
                throw error
            } catch {
                throw loggedInternalError("Restoring the singleton public key failed: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - ServiceKeyWorker

    func generateKeyPair() async throws -> KeyPair {
        let keyRingId = try await getKeyRingId()
        let keyPairId = try keyManager.generateKeyId()
        guard let keyPairIdDataEncoded = keyPairId.data(using: .utf8) else {
            let msg = "Unable to encode key pair id on generation"
            logger.error(msg)
            throw SudoEmailError.internalError(msg)
        }

        // Try to delete the existing password if it exists.
        try keyManager.deletePassword(Defaults.currentKeyPairIdPointerName)
        try keyManager.generateKeyPair(keyPairId)
        do {
            try keyManager.addPassword(keyPairIdDataEncoded, name: Defaults.currentKeyPairIdPointerName)
        } catch {
            // Adding the new key pair has failed, clean up and throw an error.
            let msg = "Unable to save new current key id pointer: \(keyPairId). Error: \(error.localizedDescription)"
            logger.error(msg)
            try keyManager.deleteKeyPair(keyPairId)
            throw SudoEmailError.internalError(msg)
        }

        let publicKey: Data
        let privateKey: Data
        do {
            guard let pubKey = try keyManager.getPublicKey(keyPairId),
                  let privKey = try keyManager.getPrivateKey(keyPairId)
            else {
                throw SudoEmailError.internalError("Unable to access key pair from key manager")
            }
            publicKey = pubKey
            privateKey = privKey
        } catch {
            let msg = "Failed to get generated key pair: \(error.localizedDescription)"
            logger.error(msg)
            try keyManager.deletePassword(Defaults.currentKeyPairIdPointerName)
            try keyManager.deleteKeyPair(keyPairId)
            throw SudoEmailError.internalError(msg)
        }

        let keyPair = createKeyPairWithKeyId(keyPairId, keyRingId: keyRingId, publicKeyData: publicKey, privateKeyData: privateKey)
        return keyPair
    }

    func getPublicKeyWithId(keyId: String) async throws -> KeyEntity? {
        let keyRingId = try await getKeyRingId()
        let publicKey: Data

        do {
            guard let pubKey = try keyManager.getPublicKey(keyId) else {
                return nil
            }
            publicKey = pubKey
        } catch {
            let msg = "Failed to get public key: \(error.localizedDescription)"
            logger.error(msg)
            throw SudoEmailError.internalError(msg)
        }

        let keyEntity = KeyEntity(
            type: .publicKey(format: Defaults.publicKeyFormat),
            keyId: keyId,
            keyRingId: keyRingId,
            keyData: publicKey
        )
        return keyEntity
    }

    func getSingletonKeyPair() async throws -> KeyEntity? {
        let keyRingId = try await getKeyRingId()
        let singleton: StoredPublicKey? = try withSingletonLock {
            do {
                return try existingSingletonKeyPair()
            } catch let error as SudoEmailError {
                throw error
            } catch {
                throw loggedInternalError("Singleton key pair retrieval failed: \(error.localizedDescription)")
            }
        }
        return singleton.map { publicKeyEntity(keyId: $0.keyId, keyRingId: keyRingId, publicKeyData: $0.publicKey) }
    }

    func createSingletonKeyPairIfAbsent() async throws -> SingletonKeyPairResult {
        let keyRingId = try await getKeyRingId()
        // Serialise get-or-create so concurrent calls can't each create a "singleton" key.
        let (singleton, created): (StoredPublicKey, Bool) = try withSingletonLock {
            do {
                if let existing = try existingSingletonKeyPair() {
                    return (existing, false)
                }
                // No singleton yet, or its private key is missing: start a new one.
                let missingKeyId = try singletonKeyId()
                let replacement = try generateSingletonKeyPair()
                if let missingKeyId {
                    reportReplacedSingletonKeyPair(missingKeyId: missingKeyId, replacementKeyId: replacement.keyId)
                } else {
                    logger.info("Created singleton key pair \(replacement.keyId)")
                }
                return (replacement, true)
            } catch let error as SudoEmailError {
                throw error
            } catch {
                throw loggedInternalError("Singleton key pair creation failed: \(error.localizedDescription)")
            }
        }
        let key = publicKeyEntity(keyId: singleton.keyId, keyRingId: keyRingId, publicKeyData: singleton.publicKey)
        return SingletonKeyPairResult(key: key, created: created)
    }

    func removeKeyPair(keyId: String) throws {
        try withSingletonLock {
            do {
                guard try keyId != singletonKeyId() else { return }
                try keyManager.deleteKeyPair(keyId)
                if try passwordKeyId(named: Defaults.currentKeyPairIdPointerName) == keyId {
                    try keyManager.deletePassword(Defaults.currentKeyPairIdPointerName)
                }
            } catch {
                throw loggedInternalError("Removing key pair \(keyId) failed: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Helpers

    /// Create the entity level key pair from the supplied data.
    /// - Parameters:
    ///   - keyId: Identifier of the key.
    ///   - keyRingId: Identifier of the key ring.
    ///   - publicKeyData: Data of the public key.
    ///   - privateKeyData: Data of the private key.
    /// - Returns: Key pair entities.
    func createKeyPairWithKeyId(_ keyId: String, keyRingId: String, publicKeyData: Data, privateKeyData: Data) -> KeyPair {
        return KeyPair(
            publicKey: KeyEntity(
                type: .publicKey(format: Defaults.publicKeyFormat),
                keyId: keyId,
                keyRingId: keyRingId,
                keyData: publicKeyData
            ),
            privateKey: KeyEntity(
                type: .privateKey,
                keyId: keyId,
                keyRingId: keyRingId,
                keyData: privateKeyData
            )
        )
    }

    /// Get the user's key ring id. If the user is not signed in, this will fail.
    /// - Throws: `SudoEmailError.notSignedIn`.
    /// - Returns: Key ring id of the user.
    func getKeyRingId() async throws -> String {
        guard let userId = try await userClient.getSubject() else {
            throw SudoEmailError.notSignedIn
        }
        return "\(Defaults.keyRingServiceName).\(userId)"
    }

    /// Create the entity level public key from the supplied data.
    /// - Parameters:
    ///   - keyId: Identifier of the key.
    ///   - keyRingId: Identifier of the key ring.
    ///   - publicKeyData: Data of the public key.
    /// - Returns: Public key entity.
    func publicKeyEntity(keyId: String, keyRingId: String, publicKeyData: Data) -> KeyEntity {
        KeyEntity(type: .publicKey(format: Defaults.publicKeyFormat), keyId: keyId, keyRingId: keyRingId, keyData: publicKeyData)
    }

    /// Runs `body` while holding the singleton lock. The body is synchronous, so the lock can never be held
    /// across a suspension point.
    /// - Parameter body: Work to run while holding the lock.
    /// - Returns: The result of `body`.
    func withSingletonLock<Result: Sendable>(_ body: () throws -> Result) throws -> Result {
        try singletonLock.withLock { _ in try body() }
    }

    /// The singleton key pair, or nil if none is recorded or its private key isn't on this device. Call while
    /// holding the singleton lock.
    /// - Returns: The singleton's key id and public key data.
    /// - Throws: `SudoEmailError.internalError` if the private key exists but the public key does not.
    func existingSingletonKeyPair() throws -> StoredPublicKey? {
        guard
            let keyId = try singletonKeyId(),
            try keyManager.getPrivateKey(keyId) != nil
        else { return nil }
        // Import restores the public key, so a private key without one means the key store is inconsistent.
        // Replacing the key pair would abandon the private key that messages are sealed to, so fail instead.
        guard let publicKey = try keyManager.getPublicKey(keyId) else {
            throw loggedInternalError("Singleton key pair \(keyId) has a private key but no public key")
        }
        return (keyId, publicKey)
    }

    /// Generates a key pair and records it as the singleton. Call while holding the singleton lock.
    ///
    /// The key pair is generated before its id is recorded, so a failed generation never leaves the record
    /// naming a key pair that doesn't exist.
    /// - Returns: The new singleton's key id and public key data.
    func generateSingletonKeyPair() throws -> StoredPublicKey {
        let keyId = try keyManager.generateKeyId()
        try keyManager.generateKeyPair(keyId)
        do {
            guard let publicKey = try keyManager.getPublicKey(keyId) else {
                throw loggedInternalError("Public key missing after generating singleton key pair \(keyId)")
            }
            try keyManager.deletePassword(Defaults.singletonKeyIdName)
            try keyManager.addPassword(Data(keyId.utf8), name: Defaults.singletonKeyIdName)
            return (keyId, publicKey)
        } catch {
            try? keyManager.deleteKeyPair(keyId)
            throw error
        }
    }

    /// The id of the singleton key pair, or nil if none has been created.
    func singletonKeyId() throws -> String? {
        try passwordKeyId(named: Defaults.singletonKeyIdName)
    }

    /// The key id stored as the value of a key manager password.
    /// - Parameter name: Name of the password.
    /// - Returns: The key id, or nil if the password doesn't exist or is empty.
    func passwordKeyId(named name: String) throws -> String? {
        guard
            let data = try keyManager.getPassword(name),
            let keyId = String(data: data, encoding: .utf8),
            !keyId.isEmpty
        else { return nil }
        return keyId
    }

    /// Stores the singleton key pair's public key again after an import. Call while holding the singleton lock.
    ///
    /// `exportKeys()` leaves public keys out of the archive, so an import restores only the singleton's private
    /// key. The public key is derived from the private key here, rather than abandoning the key pair that
    /// messages are still sealed to.
    func restoreSingletonPublicKey() throws {
        guard
            let keyId = try singletonKeyId(),
            try keyManager.getPublicKey(keyId) == nil,
            let privateKey = try keyManager.getPrivateKey(keyId)
        else { return }
        try keyManager.addPublicKey(Self.derivePublicKey(fromPrivateKey: privateKey), name: keyId)
        logger.info("Restored the public key of singleton key pair \(keyId) from its private key")
    }

    /// Reports that the singleton key pair's private key was missing from this device, so a new singleton
    /// replaced it.
    ///
    /// Logged as an error and output as one, so an app's log driver can record it as a non-fatal: messages
    /// sealed to the missing key can no longer be read on this device until a key archive containing it is
    /// imported.
    /// - Parameters:
    ///   - missingKeyId: Id of the singleton whose private key is missing.
    ///   - replacementKeyId: Id of the singleton that replaced it.
    func reportReplacedSingletonKeyPair(missingKeyId: String, replacementKeyId: String) {
        let message = "Singleton key pair \(missingKeyId) has no private key on this device; replaced it with \(replacementKeyId). "
            + "Messages sealed to \(missingKeyId) can't be read here until a key archive containing it is imported."
        logger.error(message)
        logger.outputError(
            SudoEmailError.internalError(message),
            withUserInfo: ["missingKeyId": missingKeyId, "replacementKeyId": replacementKeyId]
        )
    }

    /// Logs `message` as an error and returns it as an internal error, ready to throw.
    /// - Parameter message: Description of the failure.
    /// - Returns: `SudoEmailError.internalError` carrying `message`.
    func loggedInternalError(_ message: String) -> SudoEmailError {
        logger.error(message)
        return SudoEmailError.internalError(message)
    }

    /// The PKCS#1 public key for a PKCS#1 RSA private key, as the key manager stores them.
    /// - Parameter privateKeyData: PKCS#1 RSA private key data.
    /// - Returns: PKCS#1 RSA public key data.
    static func derivePublicKey(fromPrivateKey privateKeyData: Data) throws -> Data {
        let attributes: [CFString: Any] = [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass: kSecAttrKeyClassPrivate
        ]
        var error: Unmanaged<CFError>?
        guard
            let privateKey = SecKeyCreateWithData(privateKeyData as CFData, attributes as CFDictionary, &error),
            let publicKey = SecKeyCopyPublicKey(privateKey),
            let publicKeyData = SecKeyCopyExternalRepresentation(publicKey, &error)
        else {
            let cause = error.map { "\($0.takeRetainedValue())" } ?? "unknown"
            throw SudoEmailError.internalError("Deriving public key failed: \(cause)")
        }
        return publicKeyData as Data
    }
}
