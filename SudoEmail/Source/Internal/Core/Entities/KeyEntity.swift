//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Type of key entity.
enum KeyEntityType: Equatable, Hashable {
    /// Public key type.
    case publicKey(format: PublicKeyFormatEntity)
    /// Private key type.
    case privateKey
}

/// Core entity representation of a key business rule. Depicts either a public or private key for use with encrypting and decrypting user's data.
struct KeyEntity: Equatable, Hashable {

    // MARK: - Properties

    /// Type of the key.
    let type: KeyEntityType

    /// Id associated with the key pair.
    let keyId: String

    /// Key ring id associated with the key pair.
    let keyRingId: String

    /// Data of the key.
    let keyData: Data

    // MARK: - Lifecycle

    init(type: KeyEntityType, keyId: String, keyRingId: String = "", keyData: Data) {
        self.type = type
        self.keyId = keyId
        self.keyRingId = keyRingId
        self.keyData = keyData
    }

    // MARK: - Helper Methods

    /// Extracts the PublicKeyFormatEntity from the key type if it's a public key.
    /// - Returns: The PublicKeyFormatEntity for public keys.
    /// - Throws: SudoEmailError.internalError if the key is not a public key.
    func getPublicKeyFormat() throws -> PublicKeyFormatEntity {
        switch type {
        case .publicKey(let format):
            return format
        case .privateKey:
            throw SudoEmailError.internalError("Cannot extract public key format from private key")
        }
    }

    // MARK: - Conformance: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(keyId)
        hasher.combine(keyRingId)
        hasher.combine(keyData)
    }
}
