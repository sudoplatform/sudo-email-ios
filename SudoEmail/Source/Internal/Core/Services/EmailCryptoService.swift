//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// List of possible errors thrown by `EmailCryptoService`.
public enum EmailCryptoServiceError: Error, Equatable, LocalizedError {
    case encodingError(_ message: String? = nil, cause: String? = nil)
    case decodingError(_ message: String? = nil, cause: String? = nil)
    case invalidArgumentError(_ message: String? = nil, cause: String? = nil)
    case keyNotFoundError(_ message: String? = nil, cause: String? = nil)
    case secureDataDecryptionError(_ message: String? = nil, cause: String? = nil)
    case secureDataEncryptionError(_ message: String? = nil, cause: String? = nil)
    case secureDataParsingError(_ message: String? = nil, cause: String? = nil)

    // MARK: - Conformace: LocalizedError

    public var errorDescription: String? {
        switch self {
        case .encodingError(let message, cause: _),
             .decodingError(let message, cause: _),
             .invalidArgumentError(let message, cause: _),
             .keyNotFoundError(let message, cause: _),
             .secureDataDecryptionError(let message, cause: _),
             .secureDataEncryptionError(let message, cause: _),
             .secureDataParsingError(let message, cause: _):
            return message
        }
    }

    public var failureReason: String? {
        switch self {
        case .encodingError(_, cause: let cause),
             .decodingError(_, cause: let cause),
             .invalidArgumentError(_, cause: let cause),
             .keyNotFoundError(_, cause: let cause),
             .secureDataDecryptionError(_, cause: let cause),
             .secureDataEncryptionError(_, cause: let cause),
             .secureDataParsingError(_, cause: let cause):
            return cause
        }
    }
}

protocol EmailCryptoService: AnyObject {

    /// Encrypt email data that can be decrypted by all the recipients.
    ///
    /// - Parameter data: The body of the email that should be encrypted.
    /// - Parameter keys: Set of keys for each recipient that must be able to decrypt the message.
    /// - Returns: The encrypted body and a sealed key for each recipient.
    /// - Throws: `EmailCryptoServiceException` when the encryption operation fails.
    func encrypt(data: Data, keys: Set<KeyEntity>) throws -> SecurePackageEntity

    /// Decrypt email data using the key belonging to the current recipient.
    ///
    /// - Parameter securePackage: An attachment that contains the encrypted body of the email message.
    /// - Returns: The decrypted body of the email message.
    /// - Throws: `EmailCryptoServiceException` when the decryption operation fails.
    func decrypt(securePackage: SecurePackageEntity) throws -> Data
}
