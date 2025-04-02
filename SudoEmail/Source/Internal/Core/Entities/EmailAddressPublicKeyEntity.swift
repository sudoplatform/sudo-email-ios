//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core representation of email address public key information.
struct EmailAddressPublicKeyEntity: Equatable {

    /// The raw value of the public key for the email address.
    let publicKey: String

    /// The format of the public key (i.e. RSA Public Key or SPKI).
    let keyFormat: PublicKeyFormatEntity

    /// The algorithm to use with the public key.
    let algorithm: String
}
