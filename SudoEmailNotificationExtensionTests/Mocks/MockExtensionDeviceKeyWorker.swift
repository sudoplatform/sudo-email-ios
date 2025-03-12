//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

@testable import SudoKeyManager
@testable import SudoEmailNotificationExtension
import Foundation

class MockExtensionDeviceKeyWorker: DeviceKeyWorker {

    var createRandomDataCallCount = 0
    var createRandomDataProperties: Int?
    var createRandomDataError: Error?
    var createRandomDataResult = Data(count: 16)

    func createRandomData(_ size: Int) throws -> Data {
        createRandomDataCallCount += 1
        createRandomDataProperties = size
        if let error = createRandomDataError {
            throw error
        }
        return createRandomDataResult
    }

    var generateNewCurrentSymmetricKeyCallCount = 0
    var generateNewCurrentSymmetricKeyError: Error?
    var generateNewCurrentSymmetricKeyResult = "dummyGeneratedCurrentSymmetricKeyId"

    func generateNewCurrentSymmetricKey() throws -> String {
        generateNewCurrentSymmetricKeyCallCount += 1
        if let error = generateNewCurrentSymmetricKeyError {
            throw error
        }
        return generateNewCurrentSymmetricKeyResult
    }

    var generateRandomSymmetricKeyCallCount = 0
    var generateRandomSymmetricKeyError: Error?
    var generateRandomSymmetricKeyResult = Data()

    func generateRandomSymmetricKey() throws -> Data {
        generateRandomSymmetricKeyCallCount += 1
        if let error = generateRandomSymmetricKeyError {
            throw error
        }
        return generateRandomSymmetricKeyResult
    }

    var getSymmetricKeyCallCount = 0
    var getSymmetricKeyLastProperty: String?
    var getSymmetricKeyError: Error?
    var getSymmetricKeyResult: String?

    func getSymmetricKey(keyId: String) throws -> String? {
        getSymmetricKeyCallCount += 1
        getSymmetricKeyLastProperty = keyId
        if let error = getSymmetricKeyError {
            throw error
        }
        return getSymmetricKeyResult
    }

    var getCurrentSymmetricKeyIdCallCount = 0
    var getCurrentSymmetricKeyIdError: Error?
    var getCurrentSymmetricKeyIdResult: String? = "dummyGotCurrentSymmetricKeyId"

    func getCurrentSymmetricKeyId() throws -> String? {
        getCurrentSymmetricKeyIdCallCount += 1
        if let error = getCurrentSymmetricKeyIdError {
            throw error
        }
        return getCurrentSymmetricKeyIdResult
    }

    var sealStringCallCount = 0
    var sealStringError: Error?
    var sealStringResult = "dummySealStringResult"
    func sealString(_ string: String, withKeyId keyId: String) throws -> String {
        sealStringCallCount += 1
        if let error = sealStringError {
            throw error
        }
        return sealStringResult
    }

    var sealStringPaylodCallCount = 0
    var sealStringPayloadError: Error?
    var sealStringPayloadResult = "dummySealStringResult"
    func sealString(_ payload: Data, withKeyId keyId: String) throws -> String {
        sealStringPaylodCallCount += 1
        if let error = sealStringPayloadError {
            throw error
        }
        return sealStringPayloadResult
    }

    var unsealStringCallCount = 0
    var unsealStringProperties: [(string: String, keyId: String, algorithm: String)] = []
    var unsealStringError: Error?
    var unsealStringResult: String = ""

    func unsealString(_ string: String, withKeyId keyId: String, algorithm: String) throws -> String {
        unsealStringCallCount += 1
        unsealStringProperties.append((string, keyId, algorithm))
        if let error = unsealStringError {
            throw error
        }
        return unsealStringResult
    }

    var encryptWithKeyPairIdCallCount = 0
    var encryptWithKeyPairIdLastProperties: (keyId: String, data: Data, algorithm: PublicKeyEncryptionAlgorithm)?
    var encryptWithKeyPairIdError: Error?
    var encryptWithKeyPairIdResult: Data = Data()

    func encryptWithKeyPairId(_ keyId: String, data: Data, algorithm: PublicKeyEncryptionAlgorithm) throws -> Data {
        encryptWithKeyPairIdCallCount += 1
        encryptWithKeyPairIdLastProperties = (keyId, data, algorithm)
        if let error = encryptWithKeyPairIdError {
            throw error
        }
        return encryptWithKeyPairIdResult
    }

    var decryptWithKeyPairIdCallCount = 0
    var decryptWithKeyPairIdLastProperties: (keyId: String, data: Data, algorithm: PublicKeyEncryptionAlgorithm)?
    var decryptWithKeyPairIdError: Error?
    var decryptWithKeyPairIdResult: Data = Data()

    func decryptWithKeyPairId(_ keyId: String, data: Data, algorithm: PublicKeyEncryptionAlgorithm) throws -> Data {
        decryptWithKeyPairIdCallCount += 1
        decryptWithKeyPairIdLastProperties = (keyId, data, algorithm)
        if let error = decryptWithKeyPairIdError {
            throw error
        }
        return decryptWithKeyPairIdResult
    }

    var encryptWithPublicKeyCallCount = 0
    var encryptWithPublicKeyLastProperties: (key: Data, data: Data, algorithm: PublicKeyEncryptionAlgorithm)?
    var encryptWithPublicKeyError: Error?
    var encryptWithPublicKeyResult: Data = Data()

    func encryptWithPublicKey(_ publicKey: Data, data: Data, algorithm: PublicKeyEncryptionAlgorithm) throws -> Data {
        encryptWithPublicKeyCallCount += 1
        encryptWithPublicKeyLastProperties = (publicKey, data, algorithm)
        if let error = encryptWithPublicKeyError {
            throw error
        }
        return encryptWithPublicKeyResult
    }

    var encryptWithSymmetricKeyCallCount = 0
    var encryptWithSymmetricKeyLastProperties: (symmetricKey: Data, data: Data, initVector: Data?)?
    var encryptWithSymmetricKeyError: Error?
    var encryptWithSymmetricKeyResult: Data = Data()

    func encryptWithSymmetricKey(_ symmetricKey: Data, data: Data, initVector: Data?) throws -> Data {
        encryptWithSymmetricKeyCallCount += 1
        encryptWithSymmetricKeyLastProperties = (symmetricKey, data, initVector)
        if let error = encryptWithSymmetricKeyError {
            throw error
        }
        return encryptWithSymmetricKeyResult
    }

    var decryptWithSymmetricKeyCallCount = 0
    var decryptWithSymmetricKeyLastProperties: (symmetricKey: Data, data: Data, initVector: Data?)?
    var decryptWithSymmetricKeyError: Error?
    var decryptWithSymmetricKeyResult: Data = Data()

    func decryptWithSymmetricKey(_ symmetricKey: Data, data: Data, initVector: Data?) throws -> Data {
        decryptWithSymmetricKeyCallCount += 1
        decryptWithSymmetricKeyLastProperties = (symmetricKey, data, initVector)
        if let error = decryptWithSymmetricKeyError {
            throw error
        }
        return decryptWithSymmetricKeyResult
    }
    var exportKeysCallCount = 0
    var exportKeysError: Error?
    var exportKeysResult: Data = Data(count: 1)

    func exportKeys() throws -> Data {
        exportKeysCallCount += 1
        if let error = exportKeysError {
            throw error
        }
        return exportKeysResult
    }

    var importKeysCallCount = 0
    var importKeysError: Error?

    func importKeys(archiveData: Data) throws {
        importKeysCallCount += 1
        if let error = importKeysError {
            throw error
        }
    }

    var removeAllKeysCallCount = 0
    var removeAllKeysError: Error?

    func removeAllKeys() throws {
        if let error = removeAllKeysError {
            throw error
        }
    }
    
    var keyExistsCallCount = 0
    var keyExistsResult: Bool = true
    func keyExists(keyId: String, keyType: KeyType) -> Bool {
        keyExistsCallCount += 1
        return keyExistsResult
    }
}
