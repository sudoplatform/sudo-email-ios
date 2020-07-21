//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Type of key entity.
enum KeyEntityType {
    /// Public key type.
    case publicKey
    /// Private key type.
    case privateKey
}

/// Core entity representation of a key business rule. Depicts either a public or private key for use with encrypting and decrypting user's data.
struct KeyEntity: Equatable {

    /// Type of the key.
    var type: KeyEntityType

    /// Id associated with the key pair.
    var keyId: String

    /// Key ring id associated with the key pair.
    var keyRingId: String

    /// Data of the key.
    var keyData: Data

}
