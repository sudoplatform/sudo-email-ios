//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import XCTest
import SudoKeyManager
import SudoLogging
import SudoUser
@testable import SudoEmail

class DefaultDeviceKeyWorkerTests: XCTestCase {

    // MARK: - Properties

    var deviceKeyWorker: DefaultDeviceKeyWorker!

    var mockKeyManager: MockKeyManager!

    var logger = Logger.testLogger

    // MARK: - Lifecycle

    func doSetup(_ deviceKeyWorker: DefaultDeviceKeyWorker, _ mockKeyManager: MockKeyManager) {
        self.mockKeyManager = mockKeyManager
        self.deviceKeyWorker = deviceKeyWorker
    }

    override func setUp() {
        let mockKeyManager = MockKeyManager()

        doSetup(DefaultDeviceKeyWorker(
            keyManager: mockKeyManager,
            logger: logger
        ),
        mockKeyManager)
    }

    // MARK: - Utility

    func assertKeyPairEqual(
        keyId: String,
        keyRingId: String,
        publicKeyData: Data,
        privateKeyData: Data,
        keyPair: KeyPair,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(keyPair.privateKey.type, .privateKey, "keyPair privateKey type not privateKey", file: file, line: line)
        XCTAssertEqual(keyPair.privateKey.keyData, privateKeyData, file: file, line: line)
        XCTAssertEqual(keyPair.privateKey.keyId, keyId, file: file, line: line)
        XCTAssertEqual(keyPair.privateKey.keyRingId, keyRingId, file: file, line: line)
        XCTAssertEqual(
            keyPair.publicKey.type,
            .publicKey(format: .rsaPublicKey),
            "keyPair publicKey type not publicKey",
            file: file,
            line: line
        )
        XCTAssertEqual(keyPair.publicKey.keyData, publicKeyData, file: file, line: line)
        XCTAssertEqual(keyPair.publicKey.keyId, keyId, file: file, line: line)
        XCTAssertEqual(keyPair.publicKey.keyRingId, keyRingId, file: file, line: line)
    }

    func assertPublicKeyEntityEqual(
        keyId: String,
        keyRingId: String,
        publicKeyData: Data,
        keyEntity: KeyEntity,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertEqual(
            keyEntity.type,
            .publicKey(format: .rsaPublicKey),
            "keyPair publicKey type not publicKey",
            file: file,
            line: line
        )        
        XCTAssertEqual(keyEntity.keyData, publicKeyData, file: file, line: line)
        XCTAssertEqual(keyEntity.keyId, keyId, file: file, line: line)
        XCTAssertEqual(keyEntity.keyRingId, keyRingId, file: file, line: line)
    }

    // MARK: - Tests

    func test_initializer_SuccessfullyInitializesKeyManager() {
        let instanceUnderTest = DefaultDeviceKeyWorker(keyNamespace: "dummyKeyNamespace", logger: .testLogger)
        XCTAssertTrue(instanceUnderTest.keyManager is LegacySudoKeyManager)
        XCTAssertEqual(instanceUnderTest.keyManager.namespace, "dummyKeyNamespace")
    }

    // MARK: - Tests: Helpers: decrypt

    func test_decrypt_InputNotBase64Encoded() {
        XCTAssertThrowsError(try deviceKeyWorker.decryptWithKeyPair(
            "non-base64",
            withKeyId: "",
            algorithm: PublicKeyEncryptionAlgorithm("RSAEncryptionOAEPAESCBC")!
        )) { error in
            guard let err = error as? SudoEmailError else {
                return XCTFail("Failed to get expected error. Intead received: \(error)")
            }
            XCTAssertEqual(err, .internalError("Data is not base64"))
        }
    }

    func test_decrypt_SymmetricKeyNotIncludedInPayload() {
        let input = String(repeating: "0", count: 255).data(using: .utf8)!.base64EncodedString()
        XCTAssertThrowsError(try deviceKeyWorker.decryptWithKeyPair(
            input,
            withKeyId: "",
            algorithm: PublicKeyEncryptionAlgorithm("RSAEncryptionOAEPAESCBC")!
        )) { error in
            guard let err = error as? SudoEmailError else {
                return XCTFail("Failed to get expected error. Intead received: \(error)")
            }
            XCTAssertEqual(err, .internalError("Symmetric key missing from payload"))
        }
    }

    func test_decrypt_CallsPrivateKeyDecryptionCorrectly() {
        let key = String(repeating: "0", count: 256)
        let otherMatter = "dummyData"
        let input = "\(key)\(otherMatter)".data(using: .utf8)!.base64EncodedString()
        _ = try? deviceKeyWorker.decryptWithKeyPair(
            input,
            withKeyId: "dummyKeyId",
            algorithm: PublicKeyEncryptionAlgorithm("RSAEncryptionOAEPAESCBC")!
        )
        XCTAssertEqual(mockKeyManager.decryptWithPrivateKeyCallCount, 1)
        XCTAssertEqual(mockKeyManager.decryptWithPrivateKeyLastProperties?.algorithm, .rsaEncryptionOAEPSHA1)
        XCTAssertEqual(mockKeyManager.decryptWithPrivateKeyLastProperties?.data, key.data(using: .utf8)!)
        XCTAssertEqual(mockKeyManager.decryptWithPrivateKeyLastProperties?.name, "dummyKeyId")
    }

    func test_decrypt_CallsSymmetricKeyDecryptionCorrectly() {
        let aesKey = "dummyAESKey".data(using: .utf8)!
        mockKeyManager.decryptWithPrivateKeyResult = aesKey
        let key = String(repeating: "0", count: 256)
        let otherMatter = "dummyData"
        let input = "\(key)\(otherMatter)".data(using: .utf8)!.base64EncodedString()
        _ = try? deviceKeyWorker.decryptWithKeyPair(
            input,
            withKeyId: "dummyKeyId",
            algorithm: PublicKeyEncryptionAlgorithm("RSAEncryptionOAEPAESCBC")!
        )
        XCTAssertEqual(mockKeyManager.decryptWithSymmetricKeyCallCount, 1)
        XCTAssertEqual(mockKeyManager.decryptWithSymmetricKeyLastProperties?.key, aesKey)
        XCTAssertEqual(mockKeyManager.decryptWithSymmetricKeyLastProperties?.data, otherMatter.data(using: .utf8)!)
    }

    func test_decrypt_RespectsSymmetricKeyDecryptionFailure() {
        let input = String(repeating: "0", count: 257).data(using: .utf8)!.base64EncodedString()
        mockKeyManager.decryptWithPrivateKeyResult = Data()
        mockKeyManager.decryptWithSymmetricKeyError = AnyError("Failed to decrypt with symmetric key")
        XCTAssertThrowsError(try deviceKeyWorker.decryptWithKeyPair(
            input,
            withKeyId: "dummyKeyId",
            algorithm: PublicKeyEncryptionAlgorithm("RSAEncryptionOAEPAESCBC")!
        )) { error in
            guard let err = error as? AnyError else {
                return XCTFail("Failed to get expected error. Instead received: \(error)")
            }
            XCTAssertEqual(err, AnyError("Failed to decrypt with symmetric key"))
        }
    }

    // MARK: - Tests: Helpers: unsealString

    func test_unsealString_KeyPairSuccess() throws {
        let input = String(repeating: "0", count: 257).data(using: .utf8)!.base64EncodedString()
        mockKeyManager.decryptWithSymmetricKeyResult = "I_AM_STRING".data(using: .utf8)!
        let result = try deviceKeyWorker.unsealString(input, withKeyId: "", algorithm: "RSAEncryptionOAEPAESCBC")
        XCTAssertEqual(result, "I_AM_STRING")
    }

    func test_unsealString_SymmtericKeySuccess() {
        let input = String(repeating: "0", count: 257).data(using: .utf8)!.base64EncodedString()
        mockKeyManager.decryptWithSymmetricKeyResult = "I_AM_STRING".data(using: .utf8)!
        do {
            let result = try deviceKeyWorker.unsealString(input, withKeyId: "", algorithm: "AES/CBC/PKCS7Padding")
            XCTAssertEqual(result, "I_AM_STRING")
        } catch {
            XCTFail("unexpected error \(error)")
        }
    }

    func test_unsealString_SymmetricKeyInputNotBase64Encoded() {
        let input = "I am not base64 encoded"
        do {
            let result = try deviceKeyWorker.unsealString(input, withKeyId: "", algorithm: "AES/CBC/PKCS7Padding")
            XCTFail("unexpected result \(result)")
        } catch {
            XCTAssertEqual(error as? SudoEmailError, SudoEmailError.internalError("Data is not base64"))
        }
    }

    func test_unsealString_SymmetricKeyDecryptError() {
        let input = String(repeating: "0", count: 257).data(using: .utf8)!.base64EncodedString()
        mockKeyManager.decryptWithSymmetricKeyError = AnyError("Test generated failed to decrypt with symmetric key")
        do {
            let result = try deviceKeyWorker.unsealString(input, withKeyId: "", algorithm: "AES/CBC/PKCS7Padding")
            XCTFail("unexpected result \(result)")
        } catch {
            XCTAssertEqual(error as? AnyError, AnyError("Test generated failed to decrypt with symmetric key"))
        }
    }

    // MARK: - Tests: generateNewCurrentSymmetricKey

    func test_generateNewCurrentSymmetricKey_Success() {
        mockKeyManager.generateKeyIdResult = "dummyKeyId"
        do {
            let result = try deviceKeyWorker.generateNewCurrentSymmetricKey()
            XCTAssertEqual(result, "dummyKeyId")
            XCTAssertEqual(mockKeyManager.generateKeyIdCallCount, 1)
            XCTAssertEqual(mockKeyManager.deletePasswordCallCount, 1)
            XCTAssertEqual(mockKeyManager.addPasswordCallCount, 1)
            XCTAssertEqual(mockKeyManager.generateSymmetricKeyCallCount, 1)
        } catch {
            XCTFail("unexpected error \(error)")
        }
    }

    func test_generateNewCurrentSymmetricKey_generateKeyIdError() {
        mockKeyManager.generateKeyIdError = AnyError("Test generated error")
        do {
            let result = try deviceKeyWorker.generateNewCurrentSymmetricKey()
            XCTFail("unexpected success \(result)")
        } catch {
            guard let err = error as? AnyError else {
                return XCTFail("Failed to get expected error. Instead received: \(error)")
            }
            XCTAssertEqual(err, AnyError("Test generated error"))
            XCTAssertEqual(mockKeyManager.generateKeyIdCallCount, 1)
            XCTAssertEqual(mockKeyManager.deletePasswordCallCount, 0)
            XCTAssertEqual(mockKeyManager.addPasswordCallCount, 0)
            XCTAssertEqual(mockKeyManager.generateSymmetricKeyCallCount, 0)
        }
    }

    func test_generateNewCurrentSymmetricKey_deletePasswordError() {
        mockKeyManager.deletePasswordError = AnyError("Test generated error")
        do {
            let result = try deviceKeyWorker.generateNewCurrentSymmetricKey()
            XCTFail("unexpected success \(result)")
        } catch {
            guard let err = error as? AnyError else {
                return XCTFail("Failed to get expected error. Instead received: \(error)")
            }
            XCTAssertEqual(err, AnyError("Test generated error"))
            XCTAssertEqual(mockKeyManager.generateKeyIdCallCount, 1)
            XCTAssertEqual(mockKeyManager.deletePasswordCallCount, 1)
            XCTAssertEqual(mockKeyManager.addPasswordCallCount, 0)
            XCTAssertEqual(mockKeyManager.generateSymmetricKeyCallCount, 0)
        }
    }

    func test_generateNewCurrentSymmetricKey_addPasswordError() {
        mockKeyManager.addPasswordError = AnyError("Test generated error")
        do {
            let result = try deviceKeyWorker.generateNewCurrentSymmetricKey()
            XCTFail("unexpected success \(result)")
        } catch {
            guard let err = error as? SudoEmailError else {
                return XCTFail("Failed to get expected error. Instead received: \(error)")
            }
            XCTAssertEqual(
                err.errorDescription,
                "Unable to save new current symmetric key id pointer: . Error: Test generated error"
            )
            XCTAssertEqual(mockKeyManager.generateKeyIdCallCount, 1)
            XCTAssertEqual(mockKeyManager.deletePasswordCallCount, 1)
            XCTAssertEqual(mockKeyManager.addPasswordCallCount, 1)
            XCTAssertEqual(mockKeyManager.generateSymmetricKeyCallCount, 0)
        }
    }

    func test_generateNewCurrentSymmetricKey_generateSymmetricKeyError() {
        mockKeyManager.generateSymmetricKeyError = AnyError("Test generated error")
        do {
            let result = try deviceKeyWorker.generateNewCurrentSymmetricKey()
            XCTFail("unexpected success \(result)")
        } catch {
            guard let err = error as? AnyError else {
                return XCTFail("Failed to get expected error. Instead received: \(error)")
            }
            XCTAssertEqual(err, AnyError("Test generated error"))
            XCTAssertEqual(mockKeyManager.generateKeyIdCallCount, 1)
            XCTAssertEqual(mockKeyManager.deletePasswordCallCount, 1)
            XCTAssertEqual(mockKeyManager.addPasswordCallCount, 1)
            XCTAssertEqual(mockKeyManager.generateSymmetricKeyCallCount, 1)
        }
    }

    // MARK: - Tests: generateRandomSymmetricKeyId

    func test_generateRandomSymmetricKey_Success() {
        let keyId = "dummyKeyId"
        let keyData = Data()
        mockKeyManager.generateKeyIdResult = keyId
        mockKeyManager.getSymmetricKeyResult = keyData

        do {
            let result = try deviceKeyWorker.generateRandomSymmetricKey()
            XCTAssertEqual(result, keyData)
            XCTAssertEqual(mockKeyManager.generateKeyIdCallCount, 1)
            XCTAssertEqual(mockKeyManager.generateSymmetricKeyCallCount, 1)
            XCTAssertEqual(mockKeyManager.getSymmetricKeyCallCount, 1)
            XCTAssertEqual(mockKeyManager.getSymmetricKeyLastProperty, keyId)
        } catch {
            XCTFail("unexpected error \(error)")
        }
    }

    func test_generateRandomSymmetricKey_GenerateSymmetricKeyError() {
        let expectedError = AnyError("Test generated error")
        mockKeyManager.generateSymmetricKeyError = expectedError

        do {
            let result = try deviceKeyWorker.generateRandomSymmetricKey()
            XCTFail("unexpected success \(result)")
        } catch {
            guard let err = error as? AnyError else {
                return XCTFail("Failed to get expected error. Instead received: \(error)")
            }
            XCTAssertEqual(err, expectedError)
            XCTAssertEqual(mockKeyManager.generateKeyIdCallCount, 1)
            XCTAssertEqual(mockKeyManager.generateSymmetricKeyCallCount, 1)
        }
    }

    // MARK: - Tests: getCurrentSymmetricKeyId

    func test_getCurrentSymmetricKeyId_Success() {
        mockKeyManager.getPasswordResult = "dummyPassword".data(using: .utf8)
        mockKeyManager.getSymmetricKeyResult = "dummySymmetricKey".data(using: .utf8)
        do {
            let result = try deviceKeyWorker.getCurrentSymmetricKeyId()
            XCTAssertEqual(result, "dummyPassword")
            XCTAssertEqual(mockKeyManager.getPasswordCallCount, 1)
            XCTAssertEqual(mockKeyManager.getSymmetricKeyCallCount, 1)
        } catch {
            XCTFail("unexpected error \(error)")
        }
    }

    func test_getCurrentSymmetricKeyId_NilPasswordSuccess() {
        mockKeyManager.getPasswordResult = nil
        do {
            let result = try deviceKeyWorker.getCurrentSymmetricKeyId()
            XCTAssertNil(result)
            XCTAssertEqual(mockKeyManager.getPasswordCallCount, 1)
            XCTAssertEqual(mockKeyManager.getSymmetricKeyCallCount, 0)
        } catch {
            XCTFail("unexpected error \(error)")
        }
    }

    func test_getCurrentSymmetricKeyId_NilSymmetricKeySuccess() {
        mockKeyManager.getPasswordResult = "dummyPassword".data(using: .utf8)
        mockKeyManager.getSymmetricKeyResult = nil
        do {
            let result = try deviceKeyWorker.getCurrentSymmetricKeyId()
            XCTAssertNil(result)
            XCTAssertEqual(mockKeyManager.getPasswordCallCount, 1)
            XCTAssertEqual(mockKeyManager.getSymmetricKeyCallCount, 1)
        } catch {
            XCTFail("unexpected error \(error)")
        }
    }

    func test_getCurrentSymmetricKeyId_getPasswordError() {
        mockKeyManager.getPasswordError = AnyError("Test generated error")
        do {
            let result = try deviceKeyWorker.getCurrentSymmetricKeyId()
            XCTFail("unexpected success \(String(describing: result))")
        } catch {
            XCTAssertEqual(error as? AnyError, AnyError("Test generated error"))
            XCTAssertEqual(mockKeyManager.getPasswordCallCount, 1)
            XCTAssertEqual(mockKeyManager.getSymmetricKeyCallCount, 0)
        }
    }

    func test_getCurrentSymmetricKeyId_getSymmetricKeyError() {
        mockKeyManager.getPasswordResult = "dummyPassword".data(using: .utf8)
        mockKeyManager.getSymmetricKeyError = AnyError("Test generated error")
        do {
            let result = try deviceKeyWorker.getCurrentSymmetricKeyId()
            XCTFail("unexpected success \(String(describing: result))")
        } catch {
            XCTAssertEqual(error as? AnyError, AnyError("Test generated error"))
            XCTAssertEqual(mockKeyManager.getPasswordCallCount, 1)
            XCTAssertEqual(mockKeyManager.getSymmetricKeyCallCount, 1)
        }
    }

    // MARK: - Tests: getSymmetricKey

    func test_getSymmetricKey_Success() {
        let keyId = "dummyKeyId"
        let symmetricKeyData = "dummySymmetricKey".data(using: .utf8)
        let symmetricKey = symmetricKeyData?.base64EncodedString()
        mockKeyManager.getSymmetricKeyResult = symmetricKeyData
        do {
            let result = try deviceKeyWorker.getSymmetricKey(keyId: keyId)
            XCTAssertEqual(result, symmetricKey)
            XCTAssertEqual(mockKeyManager.getSymmetricKeyCallCount, 1)
            XCTAssertEqual(mockKeyManager.getSymmetricKeyLastProperty, keyId)
        } catch {
            XCTFail("unexpected error \(error)")
        }
    }

    func test_getSymmetricKey_NilSymmetricKeySuccess() {
        let keyId = "dummyKeyId"
        mockKeyManager.getSymmetricKeyResult = nil

        do {
            let result = try deviceKeyWorker.getSymmetricKey(keyId: keyId)
            XCTAssertNil(result)
            XCTAssertEqual(mockKeyManager.getSymmetricKeyCallCount, 1)
            XCTAssertEqual(mockKeyManager.getSymmetricKeyLastProperty, keyId)
        } catch {
            XCTFail("unexpected error \(error)")
        }
    }

    // MARK: - Tests: createRandomData

    func test_createRandomData_Success() {
        let size = 123
        let data = Data()
        mockKeyManager.createRandomDataResult = data
        do {
            let result = try deviceKeyWorker.createRandomData(size)
            XCTAssertEqual(result, data)
            XCTAssertEqual(mockKeyManager.createRandomDataCallCount, 1)
            XCTAssertEqual(mockKeyManager.createRandomDataLastProperty, size)
        } catch {
            XCTFail("unexpected error \(error)")
        }
    }

    func test_createRandomData_Error() {
        let size = 123
        mockKeyManager.createRandomDataError = AnyError("Test generated error")
        do {
            let result = try deviceKeyWorker.createRandomData(size)
            XCTFail("unexpected success \(String(describing: result))")
        } catch {
            XCTAssertEqual(error as? AnyError, AnyError("Test generated error"))
            XCTAssertEqual(mockKeyManager.createRandomDataCallCount, 1)
        }
    }

    // MARK: - Tests: sealString

    func test_sealString_InputStringSuccess() {
        mockKeyManager.encryptWithSymmetricKeyResult = "dummyEncryptedResult".data(using: .utf8)
        do {
            let result = try deviceKeyWorker.sealString("dummyInput", withKeyId: "dummyKeyId")
            XCTAssertEqual(result, "dummyEncryptedResult".data(using: .utf8)?.base64EncodedString())
            XCTAssertEqual(mockKeyManager.encryptWithSymmetricKeyCallCount, 1)
            XCTAssertEqual(mockKeyManager.encryptWithSymmetricKeyLastProperties!.name, "dummyKeyId")
            XCTAssertEqual(mockKeyManager.encryptWithSymmetricKeyLastProperties!.data, Data("dummyInput".utf8))
        } catch {
            XCTFail("unexpected error \(error)")
        }
    }

    func test_sealString_encryptError() {
        mockKeyManager.encryptWithSymmetricKeyError = AnyError("Test generated error")
        do {
            let result = try deviceKeyWorker.sealString("dummyInput", withKeyId: "dummyKeyId")
            XCTFail("unexpected success \(result)")
        } catch {
            XCTAssertEqual(mockKeyManager.encryptWithSymmetricKeyCallCount, 1)
            XCTAssertEqual(mockKeyManager.encryptWithSymmetricKeyLastProperties!.name, "dummyKeyId")
            XCTAssertEqual(mockKeyManager.encryptWithSymmetricKeyLastProperties!.data, Data("dummyInput".utf8))
            XCTAssertEqual(error as? AnyError, AnyError("Test generated error"))
        }
    }

    func test_sealString_InputDataSuccess() {
        mockKeyManager.encryptWithSymmetricKeyResult = "dummyEncryptedResult".data(using: .utf8)
        do {
            let result = try deviceKeyWorker.sealString(Data("dummyInput".utf8), withKeyId: "dummyKeyId")
            XCTAssertEqual(result, "dummyEncryptedResult".data(using: .utf8)?.base64EncodedString())
            XCTAssertEqual(mockKeyManager.encryptWithSymmetricKeyCallCount, 1)
            XCTAssertEqual(mockKeyManager.encryptWithSymmetricKeyLastProperties!.name, "dummyKeyId")
            XCTAssertEqual(mockKeyManager.encryptWithSymmetricKeyLastProperties!.data, Data("dummyInput".utf8))
        } catch {
            XCTFail("unexpected error \(error)")
        }
    }

    func test_sealString_InputDataEncryptError() {
        mockKeyManager.encryptWithSymmetricKeyError = AnyError("Test generated error")
        do {
            let result = try deviceKeyWorker.sealString(Data("dummyInput".utf8), withKeyId: "dummyKeyId")
            XCTFail("unexpected success \(result)")
        } catch {
            XCTAssertEqual(mockKeyManager.encryptWithSymmetricKeyCallCount, 1)
            XCTAssertEqual(mockKeyManager.encryptWithSymmetricKeyLastProperties!.name, "dummyKeyId")
            XCTAssertEqual(mockKeyManager.encryptWithSymmetricKeyLastProperties!.data, Data("dummyInput".utf8))
            XCTAssertEqual(error as? AnyError, AnyError("Test generated error"))
        }
    }

    // MARK: - Tests: exportKeys

    func test_exportKeys_NoKeys() {
        do {
            _ = try deviceKeyWorker.exportKeys()
            XCTFail("exportKeys succeeded, when an archiveEmpty error was expected")
        } catch {
            logger.debug("error thrown \(error)")
            guard let err = error as? SecureKeyArchiveError else {
                XCTFail("Unexpected error: \(error)")
                return
            }
            XCTAssertEqual(err, SecureKeyArchiveError.archiveEmpty)
        }
    }

    // MARK: - Tests: importKeys

    func test_importKeys_InvalidArchive() {
        do {
            try deviceKeyWorker.importKeys(archiveData: Data(count: 64))
            XCTFail("expected an error but successfully imported an archive of 0 filled bytes")
        } catch {
            logger.debug("error thrown \(error)")
            guard let err = error as? SudoEmailError else {
                XCTFail("Unexpected error: \(error)")
                return
            }
            XCTAssertEqual(err, SudoEmailError.invalidKeyArchive)
        }
    }
}
