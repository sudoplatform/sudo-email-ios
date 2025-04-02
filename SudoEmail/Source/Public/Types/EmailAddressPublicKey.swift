//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of public key details associated with an email address in the Platform SDK.
public struct EmailAddressPublicKey: Equatable {

    // MARK: - Properties

    /// The raw value of the public key for the email address.
    public let publicKey: String

    /// The format of the public key (i.e. RSA Public Key or SPKI).
    public let keyFormat: PublicKeyFormat

    /// The algorithm to use with the public key.
    public let algorithm: String

    // MARK: - Lifecycle

    /// Initialize a `EmailAddressPublicKey` instance.
    /// - Parameters:
    ///   - publicKey: The raw value of the public key for the email address.
    ///   - keyFormat: The format of the public key (i.e. RSA Public Key or SPKI).
    ///   - algorithm: The algorithm to use with the public key.
    public init(publicKey: String, keyFormat: PublicKeyFormat, algorithm: String) {
        self.publicKey = publicKey
        self.keyFormat = keyFormat
        self.algorithm = algorithm
    }
}
