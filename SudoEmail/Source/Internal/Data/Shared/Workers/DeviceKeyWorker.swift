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

protocol DeviceKeyWorker: AnyObject {

    /// Creates random data of size specified by `size` input.
    ///
    /// - Parameter size: Number of bytes used to create the random data.
    /// - Returns: The random data.
    /// - Throws: `KeyManagerError`.
    func createRandomData(_ size: Int) throws -> Data

    /// Generate a key pair on the device. Returns the freshly generated key pair.
    /// Throws: `SudoEmailError`.
    func generateKeyPair() throws -> KeyPair

    /// Get the Public Key matching the key id if it exists.
    ///
    /// - Parameter keyId: Identifier of the Public Key to retrieve.
    /// - Returns: The Public Key `KeyEntity` matching the provided key id, or nil
    /// - Throws: `SudoEmailError`.
    func getPublicKeyWithId(keyId: String) throws -> KeyEntity?
    
    /// Generate a new symmetric key
    ///  Throws: `SudoKeyManagerError`.
    func generateNewCurrentSymmetricKey() throws -> String

    /// Generate a random symmetric key which is not persisted in the iOS Keychain.
    ///
    /// - Returns: The generated random symmetric key data.
    /// - Throws:
    ///     - `KeyManagerError`
    ///     - `SudoEmailError`
    func generateRandomSymmetricKey() throws -> Data

    /// Get the symmetric key matching the key id if it exists.
    ///
    /// - Parameter keyId: Key id to be used to access the stored symmetric key.
    /// - Returns: The Symmetric Key matching the key id, or nil if no symmetric key is found.
    /// - Throws: `SudoKeyManagerError`
    func getSymmetricKey(keyId: String) throws -> String?

    /// Get the id of the current symmetric key
    ///  Throws: `SudoKeyManagerError`.
    func getCurrentSymmetricKeyId() throws -> String?

    /// Seal a string property.
    ///
    ///  - Parameter string: String to be encrypted.
    ///  - Parameter keyId: Key Id to be used to access the stored key and encrypt the data.
    func sealString(_ string: String, withKeyId keyId: String) throws -> String

    /// Seal a data payload.
    ///
    ///  - Parameter string: String to be encrypted.
    ///  - Parameter keyId: Key Id to be used to access the stored key and encrypt the data.
    func sealString(_ payload: Data, withKeyId keyId: String) throws -> String

    /// Unseal a string property.
    ///
    /// - Parameter string: Base 64 encoded encrypted string value as a string to be decrypted.
    /// - Parameter keyId: Key Id to be used to access the stored key and decrypt the data.
    /// - Parameter algorithm: Algorithm in plain text to use to decrypt the AES key.
    /// - Throws:
    ///     - `UnsealingError.dataDecodingFailed`:
    ///         - If the input data cannot be encoded to a base 64 data object.
    ///         - If the unsealed object cannot be decoded to an `String`.
    ///     - `KeyManagerError` if the data cannot be decrypted.
    func unsealString(_ string: String, withKeyId keyId: String, algorithm: String) throws -> String

    /// Encrypts the given data with the specified key pair id.
    ///
    /// - Parameter keyId: Key Id to be used to access the stored key and encrypt the data.
    /// - Parameter data: The data to encrypt.
    /// - Parameter algorithm: Algorithm in plain text to use to encrypt.
    /// - Returns: The encrypted data.
    /// - Throws: `KeyManagerError` if the data cannot be encrypted.
    func encryptWithKeyPairId(_ keyId: String, data: Data, algorithm: PublicKeyEncryptionAlgorithm) throws -> Data

    /// Decrypt the provided data using the keyId.
    ///
    /// - Parameter keyId: Key Id to be used to access the stored key and decrypt the data with.
    /// - Parameter data: The data to be decrypted.
    /// - Parameter algorithm: Algorithm in plain text to use to decrypt.
    /// - Throws: `KeyManagerError` if the data cannot be decrypted.
    func decryptWithKeyPairId(_ keyId: String, data: Data, algorithm: PublicKeyEncryptionAlgorithm) throws -> Data

    /// Encrypt the data using the specificed Public Key.
    ///
    /// - Parameter publicKey: Public Key data used to encrypt the data.
    /// - Parameter data: The data to encrypt.
    /// - Parameter algorithm: Algorithm in plain text to use to encrypt.
    /// - Returns: The encrypted data.
    /// - Throws: `KeyManagerError` if the data cannot be encrypted.
    func encryptWithPublicKey(_ publicKey: Data, data: Data, algorithm: PublicKeyEncryptionAlgorithm) throws -> Data

    /// Encrypt the data using the Symmetric Key data.
    ///
    /// - Parameter symmetricKey: The Symmetric Key data to use to decrypt the data with.
    /// - Parameter data: The data to be decrypted.
    /// - Parameter initVector: The initialization vector.
    /// - Returns: The encrypted data.
    /// - Throws: `KeyManagerError` if the data cannot be encrypted.
    func encryptWithSymmetricKey(_ symmetricKey: Data, data: Data, initVector: Data?) throws -> Data

    /// Decrypt the provided data using Symmetric Key data.
    ///
    /// - Parameter symmetricKey: The Symmetric Key data to use to decrypt the data with.
    /// - Parameter data: The data to be decrypted.
    /// - Parameter initVector: The initialization vector.
    /// - Returns: The decrypted data.
    /// - Throws: `KeyManagerError` if the data cannot be decrypted.
    func decryptWithSymmetricKey(_ symmetricKey: Data, data: Data, initVector: Data?) throws -> Data

    /// Export the cryptographic keys to a key archive.
    ///
    /// - Returns: Key archive data.
    func exportKeys() throws -> Data

    /// Imports cryptographic keys from a key archive.
    ///
    /// - Parameter archiveData: Key archive data to import the keys from.
    func importKeys(archiveData: Data) throws

    /// remove all cryptographic keys from the KeyManager
    func removeAllKeys() throws
    
    /// Checks if the key with the given id and type exists.
    ///
    /// - Parameter keyId: Key identifier to use to check existence of key.
    /// - Parameter keyType: Type of the key to check existence of.
    /// - Returns: True if key exists, otherwise false.
    func keyExists(keyId: String, keyType: KeyType) -> Bool

}

class DefaultDeviceKeyWorker: DeviceKeyWorker {

    // MARK: - Supplementary

    /// Default values used within `DefaultDeviceKeyWorker`.
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

    /// Key manager for access and manipulation of keys on the local device.
    var keyManager: SudoKeyManager

    /// User client for getting the subject (owner identifier) of the user for key ring id.
    var userClient: SudoUserClient

    /// Used to log diagnostic and error information.
    var logger: Logger

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
        self.keyManager = keyManager
        self.userClient = userClient
        self.logger = logger
    }

    // MARK: - DeviceKeyWorker

    func createRandomData(_ size: Int) throws -> Data {
        return try keyManager.createRandomData(size)
    }

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

    func generateNewCurrentSymmetricKey() throws -> String {
        let keyId = try keyManager.generateKeyId()
        // We need to delete any old key id information before adding a new key.
        try keyManager.deletePassword(Defaults.currentSymmetricKeyIdPointerName)
        guard let keyIdDataEncoded = keyId.data(using: .utf8) else {
            let msg = "Unable to encode key id on generation"
            logger.error(msg)
            throw SudoEmailError.internalError(msg)
        }
        do {
            try keyManager.addPassword(
                keyIdDataEncoded,
                name: Defaults.currentSymmetricKeyIdPointerName
            )
        } catch {
            // Adding the new symmetric key has failed, clean up and throw an error.
            let msg = "Unable to save new current symmetric key id pointer: \(keyId). Error: \(error.localizedDescription)"
            logger.error(msg)
            try keyManager.deleteSymmetricKey(keyId)
            throw SudoEmailError.internalError(msg)
        }
        try keyManager.generateSymmetricKey(keyId)
        return keyId
    }

    func generateRandomSymmetricKey() throws -> Data {
        let keyId = try keyManager.generateKeyId()
        try keyManager.generateSymmetricKey(keyId)

        guard let symmetricKey = try keyManager.getSymmetricKey(keyId) else {
            let msg = "Unable to generate random symmetric key"
            logger.error(msg)
            throw SudoEmailError.internalError(msg)
        }
        return symmetricKey
    }

    func getSymmetricKey(keyId: String) throws -> String? {
        var symmetricKey: String

        do {
            guard let symmetricKeyData = try keyManager.getSymmetricKey(keyId) else {
                return nil
            }
            guard let symmetricKeyDataDecoded = String(data: symmetricKeyData, encoding: .utf8) else {
                let msg = "Unable to decode symmetric key data"
                logger.error(msg)
                throw SudoEmailError.internalError(msg)
            }
            symmetricKey = symmetricKeyDataDecoded
        } catch {
            let msg = "Unable to get symmetric key with id: \(keyId). Error: \(error.localizedDescription)"
            logger.error(msg)
            throw SudoEmailError.internalError(msg)
        }

        return symmetricKey
    }

    func getCurrentSymmetricKeyId() throws -> String? {
        guard let keyIdDataEncoded = try keyManager.getPassword(Defaults.currentSymmetricKeyIdPointerName) else {
            return nil
        }
        guard let keyId = String(bytes: keyIdDataEncoded, encoding: .utf8) else { return nil }
        if try keyManager.getSymmetricKey(keyId) == nil {
            return nil
        }
        return keyId
    }

    func sealString(_ input: String, withKeyId keyId: String) throws -> String {
        return try sealString(Data(input.utf8), withKeyId: keyId)
    }

    func sealString(_ payload: Data, withKeyId keyId: String) throws -> String {
        let cipherData = try keyManager.encryptWithSymmetricKey(keyId, data: payload)
        let base64EncodedText = cipherData.base64EncodedString()
        return base64EncodedText
    }

    func unsealString(_ string: String, withKeyId keyId: String, algorithm: String) throws -> String {
        if let decodedAlgorithm = PublicKeyEncryptionAlgorithm(algorithm) {
            return try decryptWithKeyPair(string, withKeyId: keyId, algorithm: decodedAlgorithm)
        } else {
            return try decryptWithSymmetricKey(string, withKeyId: keyId)
        }
    }

    func encryptWithKeyPairId(_ keyId: String, data: Data, algorithm: PublicKeyEncryptionAlgorithm) throws -> Data {
        return try keyManager.encryptWithPublicKey(keyId, data: data, algorithm: algorithm)
    }

    func decryptWithKeyPairId(_ keyId: String, data: Data, algorithm: PublicKeyEncryptionAlgorithm) throws -> Data {
        return try keyManager.decryptWithPrivateKey(keyId, data: data, algorithm: algorithm)
    }

    func encryptWithPublicKey(_ publicKey: Data, data: Data, algorithm: PublicKeyEncryptionAlgorithm) throws -> Data {
        return try keyManager.encryptWithPublicKey(publicKey, data: data, algorithm: algorithm)
    }

    func encryptWithSymmetricKey(_ symmetricKey: Data, data: Data, initVector: Data? = nil) throws -> Data {
        if let iv = initVector {
            return try keyManager.encryptWithSymmetricKey(symmetricKey, data: data, iv: iv)
        } else {
            return try keyManager.encryptWithSymmetricKey(symmetricKey, data: data)
        }
    }

    func decryptWithSymmetricKey(_ symmetricKey: Data, data: Data, initVector: Data? = nil) throws -> Data {
        if let iv = initVector {
            return try keyManager.decryptWithSymmetricKey(symmetricKey, data: data, iv: iv)
        } else {
            return try keyManager.decryptWithSymmetricKey(symmetricKey, data: data)
        }
    }

    func exportKeys() throws -> Data {
        let archive = SecureKeyArchiveImpl(keyManager: self.keyManager, zip: true)
        // exclude public keys to limit size of the archive
        archive.excludedKeyTypes = [KeyType.publicKey.rawValue]
        try archive.loadKeys()
        return try archive.archive(nil)
    }

    func importKeys(archiveData: Data) throws {
        try self.keyManager.removeAllKeys()
        guard let archive = SecureKeyArchiveImpl(
            archiveData: archiveData,
            keyManager: self.keyManager,
            zip: true
        ) else {
            throw SudoEmailError.invalidKeyArchive
        }
        try archive.unarchive(nil)
        try archive.saveKeys()
    }

    func removeAllKeys() throws {
        return try keyManager.removeAllKeys()
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
    func decryptWithKeyPair(_ input: String, withKeyId keyId: String, algorithm: PublicKeyEncryptionAlgorithm) throws -> String {
        guard let payload = Data(base64Encoded: input) else {
            throw SudoEmailError.internalError("Data is not base64")
        }
        guard payload.count > Defaults.aesKeySize else {
            throw SudoEmailError.internalError("Symmetric key missing from payload")
        }
        let aesEncrypted = payload.subdata(in: Range(uncheckedBounds: (0, Defaults.rsaBlockSize)))
        var aesDecrypted = Data()
        do {
            aesDecrypted = try keyManager.decryptWithPrivateKey(keyId, data: aesEncrypted, algorithm: algorithm)
        } catch {
            throw error
        }
        let cipherData = payload.subdata(in: Range(uncheckedBounds: (Defaults.aesKeySize, payload.count)))
        let decrypted = try keyManager.decryptWithSymmetricKey(aesDecrypted, data: cipherData)
        guard let string = String(data: decrypted, encoding: .utf8) else {
            throw SudoEmailError.internalError("Data is not encoded in UTF8")
        }
        return string
    }

    func decryptWithSymmetricKey(_ input: String, withKeyId keyId: String) throws -> String {
        guard let encryptedData = Data(base64Encoded: input) else {
            throw SudoEmailError.internalError("Data is not base64")
        }
        let decryptedData = try keyManager.decryptWithSymmetricKey(keyId, data: encryptedData)
        guard let decryptedString = String(data: decryptedData, encoding: .utf8) else {
            throw SudoEmailError.internalError("Data is not encoded in UTF8")
        }
        return decryptedString
    }

    func keyExists(keyId: String, keyType: KeyType) -> Bool {
        do {
            switch (keyType) {
                case KeyType.symmetricKey:
                    let key = try keyManager.getSymmetricKey(keyId)
                    return key != nil
                case KeyType.publicKey:
                    let key = try keyManager.getPublicKey(keyId)
                    return key != nil
                case KeyType.privateKey:
                    let key = try keyManager.getPrivateKey(keyId)
                    return key != nil
                default:
                    return false
            }
        } catch {
            return false
        }
    }
}
