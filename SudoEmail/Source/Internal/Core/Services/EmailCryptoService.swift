//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// List of possible errors thrown by `EmailCryptoService`.
public enum EmailCryptoServiceError: Error, Equatable, LocalizedError {
    case encodingError(_ message: String? = nil, cause: String? = nil)
    case decodingError(_ message: String? = nil, cause: String? = nil)
    case invalidArgumentError(_ message: String? = nil, cause: String? = nil)
    case keyNotFoundError(_ message: String? = nil, cause: String? = nil)
    case secureDataDecryptionError(_ message: String? = nil, cause: String? = nil)
    case secureDataEncryptionError(_ message: String? = nil, cause: String? = nil)
    case secureDataParsingError(_ message: String? = nil, cause: String? = nil)
}

protocol EmailCryptoService: AnyObject {

    /// Encrypt email data that can be decrypted by all the recipients.
    ///
    /// - Parameter data: The body of the email that should be encrypted.
    /// - Parameter keyIds: Set of key ids for each recipient that must be able to decrypt the message.
    /// - Returns: The encrypted body and a sealed key for each recipient.
    /// - Throws: `EmailCryptoServiceException` when the encryption operation fails.
    func encrypt(data: Data, keyIds: Set<String>) throws -> SecurePackageEntity

    /// Decrypt email data using the key belonging to the current recipient.
    ///
    /// - Parameter securePackage: An attachment that contains the encrypted body of the email message.
    /// - Returns: The decrypted body of the email message.
    /// - Throws: `EmailCryptoServiceException` when the decryption operation fails.
    func decrypt(securePackage: SecurePackageEntity) throws -> Data
}
