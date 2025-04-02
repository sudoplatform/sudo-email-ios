//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
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

    // MARK: - Conformance: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(keyId)
        hasher.combine(keyRingId)
        hasher.combine(keyData)
    }
}
