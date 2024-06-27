//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoKeyManager
import SudoLogging
import SudoUser

typealias KeyPair = (publicKey: KeyEntity, privateKey: KeyEntity)

protocol ServiceKeyWorker: DeviceKeyWorker {

    /// Generate a key pair on the device. Returns the freshly generated key pair.
    /// Throws: `SudoEmailError`.
    func generateKeyPair() throws -> KeyPair

    /// Get the Public Key matching the key id if it exists.
    ///
    /// - Parameter keyId: Identifier of the Public Key to retrieve.
    /// - Returns: The Public Key `KeyEntity` matching the provided key id, or nil
    /// - Throws: `SudoEmailError`.
    func getPublicKeyWithId(keyId: String) throws -> KeyEntity?
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
    }
    
    // MARK: - Properties
    
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
    
    // MARK: - ServiceKeyWorker
    
    func generateKeyPair() throws -> KeyPair {
        let keyRingId = try getKeyRingId()
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
    
    func getPublicKeyWithId(keyId: String) throws -> KeyEntity? {
        let keyRingId = try getKeyRingId()
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
        
        let keyEntity = KeyEntity(type: .publicKey, keyId: keyId, keyRingId: keyRingId, keyData: publicKey)
        return keyEntity
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
            publicKey: KeyEntity(type: .publicKey, keyId: keyId, keyRingId: keyRingId, keyData: publicKeyData),
            privateKey: KeyEntity(type: .privateKey, keyId: keyId, keyRingId: keyRingId, keyData: privateKeyData)
        )
    }

    /// Get the user's key ring id. If the user is not signed in, this will fail.
    /// - Throws: `SudoEmailError.notSignedIn`.
    /// - Returns: Key ring id of the user.
    func getKeyRingId() throws -> String {
        guard let userId = try userClient.getSubject() else {
            throw SudoEmailError.notSignedIn
        }
        return "\(Defaults.keyRingServiceName).\(userId)"
    }
}
