//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Represents different public key formats.
public enum PublicKeyFormat: String, Equatable {

    /// PKCS#1 RSA Public Key.
    case rsaPublicKey

    /// X.509 Subject Public Key Info.
    case spki
}
