//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync
import SudoApiClient
import SudoLogging
import SudoKeyManager

class DefaultEmailCryptoService: EmailCryptoService {

    // MARK: - Properties

    private var deviceKeyWorker: DeviceKeyWorker

    private let logger: Logger

    private struct Constants {
        static let IV_SIZE = 16
        static let ENCRYPTION_ERROR_MSG = "Error while encrypting the email body and keys"
        static let DECRYPTION_ERROR_MSG = "Error while decrypting the email body"
        static let DECRYPTION_KEY_NOT_FOUND_ERROR_MSG = "Could not find a key to decrypt the email message body"
    }

    // MARK: - Lifecycle

    init(deviceKeyWorker: DeviceKeyWorker, logger: Logger = .emailSDKLogger) {
        self.deviceKeyWorker = deviceKeyWorker
        self.logger = logger
    }

    // MARK: - Methods

    func encrypt(data: Data, keyIds: Set<String>) throws -> SecurePackageEntity {
        guard let data = data.isEmpty ? nil : data else {
            throw EmailCryptoServiceError.invalidArgumentError("Empty data")
        }
        guard let keyIds = keyIds.isEmpty ? nil : keyIds else {
            throw EmailCryptoServiceError.invalidArgumentError("Empty key ids")
        }

        do {
            // Create a symmetric key that will be used to encrypt the input data
            let symmetricKey = try deviceKeyWorker.generateRandomSymmetricKey()

            // Encrypt the input data using the symmetric key with an AES/CBC/PKCS7Padding cipher
            let initVector = try deviceKeyWorker.createRandomData(Constants.IV_SIZE)
            let encryptedBodyData = try deviceKeyWorker.encryptWithSymmetricKey(symmetricKey, data: data, initVector: initVector)
            let secureBodyData = SecureDataEntity(encryptedData: encryptedBodyData, initVectorKeyID: initVector)
            let serializedBodyData = try secureBodyData.toJson()

            // Build an email attachment of the secure email body data
            let secureBodyAttachment = buildEmailAttachment(data: serializedBodyData, attachmentType: SecureEmailAttachmentType.BODY)

            // Iterate through each public key for each recipient and encrypt the symmetric key with the public key
            var secureKeyAttachments: Set<EmailAttachment> = []
            for (index, keyId) in keyIds.enumerated() {
                var sealedKey = SealedKeyEntity(publicKeyId: keyId, symmetricKey: symmetricKey)
                let encryptedKeySealedKey = try deviceKeyWorker.encryptWithKeyPairId(
                    keyId,
                    data: sealedKey.symmetricKey,
                    algorithm: sealedKey.algorithm
                )
                sealedKey.encryptedKey = encryptedKeySealedKey
                let sealedKeyData = try sealedKey.toJson()

                let emailAttachment = buildEmailAttachment(
                    data: sealedKeyData,
                    attachmentType: SecureEmailAttachmentType.KEY_EXCHANGE,
                    attachmentNumber: index + 1
                )
                secureKeyAttachments.insert(emailAttachment)
            }

            return SecurePackageEntity(keyAttachments: secureKeyAttachments, bodyAttachment: secureBodyAttachment)
        } catch {
            let msg = "\(Constants.ENCRYPTION_ERROR_MSG): \(error.localizedDescription)"
            logger.error(msg)
            throw EmailCryptoServiceError.secureDataEncryptionError(msg)
        }
    }

    func decrypt(securePackage: SecurePackageEntity) throws -> Data {
        guard var bodyAttachmentData = (securePackage.bodyAttachment.data.isEmpty ? nil : securePackage.bodyAttachment.data),
              let keyAttachments = (securePackage.keyAttachments.isEmpty ? nil : securePackage.keyAttachments) else {
            throw EmailCryptoServiceError.invalidArgumentError()
        }

        do {
            // Body attachment data is base64 encoded from `Rfc822MessageDataProcessor`.
            bodyAttachmentData = try decodeBase64String(bodyAttachmentData)

            if securePackage.bodyAttachment.contentId == SecureEmailAttachmentType.LEGACY_BODY_CONTENT_ID {
                // Legacy system base64 encodes this data, so decode it (again) here
                bodyAttachmentData = try decodeBase64String(bodyAttachmentData)
            }

            let secureBodyData = try SecureDataEntity.fromJson(bodyAttachmentData)

            // Iterate through the set of keyAttachments and search for the key belonging to the current recipient.
            var keyComponents: SealedKeyComponentsEntity? = nil
            try keyAttachments.forEach({ key in
                if !key.data.isEmpty {
                    // Key attachment data is base64 encoded from `Rfc822MessageDataProcessor`.
                    var keyData = try decodeBase64String(key.data)

                    if key.contentId == SecureEmailAttachmentType.LEGACY_KEY_EXCHANGE_CONTENT_ID {
                        // Legacy system base64 encodes this data, so decode it (again) here
                        keyData = try decodeBase64String(keyData)
                    }

                    // Parse the key and pluck the publicKeyId
                    let sealedKeyComponents = try SealedKeyComponentsEntity.fromJson(keyData)
                    // Check if the private key pair exists based on the publicKeyId
                    if deviceKeyWorker.keyExists(keyId: sealedKeyComponents.publicKeyId, keyType: KeyType.privateKey) {
                        // Found the right key
                        keyComponents = sealedKeyComponents
                    }
                }
            })
            guard let sealedKeyComponents = keyComponents else {
                throw EmailCryptoServiceError.keyNotFoundError(Constants.DECRYPTION_KEY_NOT_FOUND_ERROR_MSG)
            }

            // Decrypt the symmetric key with the private key using the RSA/ECB/OAEPSHA1 cipher.
            let symmetricKeyData = try deviceKeyWorker.decryptWithKeyPairId(
                sealedKeyComponents.publicKeyId,
                data: sealedKeyComponents.encryptedKey,
                algorithm: sealedKeyComponents.algorithm
            )

            return try deviceKeyWorker.decryptWithSymmetricKey(symmetricKeyData,
                data: secureBodyData.encryptedData,
                initVector: secureBodyData.initVectorKeyID
            )
        } catch {
            let msg = "\(Constants.DECRYPTION_ERROR_MSG): \(error.localizedDescription)"
            logger.error(msg)
            throw EmailCryptoServiceError.secureDataDecryptionError(msg)
        }
    }

    private func decodeBase64String(_ base64String: String) throws -> String {
        if let data = Data(base64Encoded: base64String),
           let decodedString = String(data: data, encoding: .utf8) {
            return decodedString
        } else {
            throw EmailCryptoServiceError.decodingError("Failed to decode base64 string in secure package")
        }
    }

    private func buildEmailAttachment(data: String, attachmentType: SecureEmailAttachmentType, attachmentNumber: Int = -1) -> EmailAttachment {
        let attachmentFileName = attachmentType.fileName()
        let filename = attachmentNumber >= 0 ? "\(attachmentFileName) \(attachmentNumber)" : attachmentFileName
        return EmailAttachment(
            filename: filename,
            contentId: attachmentType.contentId(),
            mimetype: attachmentType.mimeType(),
            inlineAttachment: false,
            data: data
        )
    }
}
