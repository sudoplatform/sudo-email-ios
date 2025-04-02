//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of different public key formats.
enum PublicKeyFormatEntity: String, Equatable {

    /// PKCS#1 RSA Public Key.
    case rsaPublicKey

    /// X.509 Subject Public Key Info.
    case spki
}
