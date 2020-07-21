//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoKeyManager
import SudoLogging
import SudoUser

protocol DeviceKeyWorker: class {

    /// Generate a key pair on the device. Returns the freshly generated key pair.
    /// Throws: `SudoEmailError`.
    func generateKeyPair() throws -> KeyPair

    /// Get the current key pair on the device. Returns `nil` if there is no current key pair.
    /// Throws: `SudoEmailError`.
    func getCurrentKeyPair() throws -> KeyPair?

    /// Unseal an integer property.
    ///
    /// - Parameter int: Base 64 encoded encrypted int value as a string to be decrypted.
    /// - Parameter keyId: Key Id to be used to access the stored key and decrypt the data with.
    /// - Parameter algorithm: Algorithm in plain text to use to decrypt the AES key.
    /// - Throws:
    ///     - `UnsealingError.dataDecodingFailed`:
    ///         - If the input data cannot be encoded to a base 64 data object.
    ///         - If The decrypted data cannot be decoded to a string.
    ///         - If the unsealed object cannot be decoded to an `Int`.
    ///     - `KeyManagerError` if the data cannot be decrypted.
    func unsealInt(_ intString: String, withKeyId keyId: String, algorithm: String) throws -> Int

    /// Unseal an double property.
    ///
    /// - Parameter double: Base 64 encoded encrypted double value as a string to be decrypted.
    /// - Parameter keyId: Key Id to be used to access the stored key and decrypt the data with.
    /// - Parameter algorithm: Algorithm in plain text to use to decrypt the AES key.
    /// - Throws:
    ///     - `UnsealingError.dataDecodingFailed`:
    ///         - If the input data cannot be encoded to a base 64 data object.
    ///         - If The decrypted data cannot be decoded to a string.
    ///         - If the unsealed object cannot be decoded to an `Double`.
    ///     - `KeyManagerError` if the data cannot be decrypted.
    func unsealDouble(_ doubleString: String, withKeyId keyId: String, algorithm: String) throws -> Double

    /// Unseal an string property.
    ///
    /// - Parameter string: Base 64 encoded encrypted string value as a string to be decrypted.
    /// - Parameter keyId: Key Id to be used to access the stored key and decrypt the data with.
    /// - Parameter algorithm: Algorithm in plain text to use to decrypt the AES key.
    /// - Throws:
    ///     - `UnsealingError.dataDecodingFailed`:
    ///         - If the input data cannot be encoded to a base 64 data object.
    ///         - If the unsealed object cannot be decoded to an `String`.
    ///     - `KeyManagerError` if the data cannot be decrypted.
    func unsealString(_ string: String, withKeyId keyId: String, algorithm: String) throws -> String

    /// Unseal an date property.
    ///
    /// - Parameter date: Base 64 encoded encrypted date value as a string to be decrypted.
    /// - Parameter keyId: Key Id to be used to access the stored key and decrypt the data with.
    /// - Parameter algorithm: Algorithm in plain text to use to decrypt the AES key.
    /// - Throws:
    ///     - `UnsealingError.dataDecodingFailed`:
    ///         - If the input data cannot be encoded to a base 64 data object.
    ///         - If The decrypted data cannot be decoded to a string.
    ///         - If the unsealed object cannot be decoded to an `Date`.
    ///     - `KeyManagerError` if the data cannot be decrypted.
    func unsealDate(_ dateString: String, withKeyId keyId: String, algorithm: String) throws -> Date

}

class DefaultDeviceKeyWorker: DeviceKeyWorker {

    // MARK: - Supplementary

    /// Default values used within `DefaultDeviceKeyWorker`.
    enum Defaults {
        /// Key name for the current key id to access on the key manager.
        static let currentKeyIdPointerName: String = "current"
        /// Tag name used for the key manager initialization.
        static let keyManagerKeyTag = "com.sudoplatform"
        /// Key ring service name used for the key manager initialization.
        static let keyRingServiceName = "sudo-email"
        /// Size of the AES symmetric key.
        static let aesKeySize = 256
    }

    // MARK: - Properties

    /// Key manager for access and manipulation of keys on the local device.
    var keyManager: SudoKeyManager

    /// User client for getting the subject (owner identifier) of the user for key ring id.
    var userClient: SudoUserClient

    /// Used to log diagnostic and error information.
    var logger: Logger

    // MARK: - Lifecycle

    convenience init(keyNamespace: String, userClient: SudoUserClient, logger: Logger = .emailSDKLogger) {
        let keyManager = SudoKeyManagerImpl(serviceName: Defaults.keyRingServiceName, keyTag: Defaults.keyManagerKeyTag, namespace: keyNamespace)
        self.init(keyManager: keyManager, userClient: userClient, logger: logger)
    }

    init(keyManager: SudoKeyManager, userClient: SudoUserClient, logger: Logger) {
        self.keyManager = keyManager
        self.userClient = userClient
        self.logger = logger
    }

    // MARK: - DeviceKeyWorker

    func generateKeyPair() throws -> KeyPair {
        let keyRingId = try getKeyRingId()
        let keyPairId = try keyManager.generateKeyId()
        guard let keyPairIdDataEncoded = keyPairId.data(using: .utf8) else {
            let msg = "Unable to encode key pair id on generation"
            logger.error(msg)
            throw SudoEmailError.internalError(msg)
        }
        // Try to delete the existing password if it exists.
        try keyManager.deletePassword(Defaults.currentKeyIdPointerName)
        try keyManager.generateKeyPair(keyPairId)
        do {
            try keyManager.addPassword(keyPairIdDataEncoded, name: Defaults.currentKeyIdPointerName)
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
            try keyManager.deletePassword(Defaults.currentKeyIdPointerName)
            try keyManager.deleteKeyPair(keyPairId)
            throw SudoEmailError.internalError(msg)
        }
        let keyPair = createKeyPairWithKeyId(keyPairId, keyRingId: keyRingId, publicKeyData: publicKey, privateKeyData: privateKey)
        return keyPair
    }

    func getCurrentKeyPair() throws -> KeyPair? {
        let keyRingId = try getKeyRingId()
        guard
            let currentKeyIdData = try keyManager.getPassword(Defaults.currentKeyIdPointerName),
            let currentKeyId = String(data: currentKeyIdData, encoding: .utf8),
            let publicKey = try keyManager.getPublicKey(currentKeyId),
            let privateKey = try keyManager.getPrivateKey(currentKeyId)
        else {
            return nil
        }
        let keyPair = createKeyPairWithKeyId(currentKeyId, keyRingId: keyRingId, publicKeyData: publicKey, privateKeyData: privateKey)
        return keyPair
    }

    func unsealInt(_ intString: String, withKeyId keyId: String, algorithm: String) throws -> Int {
        let decrypted = try decrypt(intString, withKeyId: keyId, algorithm: algorithm)
        guard let int = Int(decrypted) else {
            throw SudoEmailError.internalError("Integer data encoding failed")
        }
        return int
    }

    func unsealDouble(_ doubleString: String, withKeyId keyId: String, algorithm: String) throws -> Double {
        let decrypted = try decrypt(doubleString, withKeyId: keyId, algorithm: algorithm)
        guard let double = Double(decrypted) else {
            throw SudoEmailError.internalError("Double data encoding failed")
        }
        return double
    }

    func unsealString(_ string: String, withKeyId keyId: String, algorithm: String) throws -> String {
        return try decrypt(string, withKeyId: keyId, algorithm: algorithm)
    }

    func unsealDate(_ dateString: String, withKeyId keyId: String, algorithm: String) throws -> Date {
        let double = try unsealDouble(dateString, withKeyId: keyId, algorithm: algorithm)
        return Date(millisecondsSince1970: double)
    }

    // MARK: - Helpers

    /// Get the user's key ring id. If the user is not signed in, this will fail.
    /// - Throws: `SudoEmailError.notSignedIn`.
    /// - Returns: Key ring id of the user.
    func getKeyRingId() throws -> String {
        guard let userId = try userClient.getSubject() else {
            throw SudoEmailError.notSignedIn
        }
        return "\(Defaults.keyRingServiceName).\(userId)"
    }

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

    /// Decrypt the input string using the keyId.
    ///
    /// - Parameter input: Input string to be decrypted.
    /// - Parameter keyId: Key Id to be used to access the stored key and decrypt the AES data with.
    /// - Parameter algorithm: Algorithm in plain text to use to decrypt the AES key.
    /// - Throws:
    ///     - `UnsealingError.dataDecodingFailed`:
    ///         - If the input data cannot be encoded to a base 64 data object.
    ///         - If the decrypted data cannot be decoded to a string.
    ///     - `KeyManagerError` if the data cannot be decrypted.
    func decrypt(_ input: String, withKeyId keyId: String, algorithm: String) throws -> String {
        guard let decodedAlgorithm = PublicKeyEncryptionAlgorithm(algorithm) else {
            throw SudoEmailError.internalError("Unsupported key algorithm: \(algorithm)")
        }
        guard let payload = Data(base64Encoded: input) else {
            throw SudoEmailError.internalError("Data is not base64")
        }
        guard payload.count > Defaults.aesKeySize else {
            throw SudoEmailError.internalError("Symmetric key missing from payload")
        }
        let aesEncrypted = payload.subdata(in: Range(uncheckedBounds: (0, Defaults.aesKeySize)))
        let aesDecrypted = try keyManager.decryptWithPrivateKey(keyId, data: aesEncrypted, algorithm: decodedAlgorithm)
        let cipherData = payload.subdata(in: Range(uncheckedBounds: (Defaults.aesKeySize, payload.count)))
        let decrypted = try keyManager.decryptWithSymmetricKey(aesDecrypted, data: cipherData)
        guard let string = String(data: decrypted, encoding: .utf8) else {
            throw SudoEmailError.internalError("Data is not encoded in UTF8")
        }
        return string
    }
}
