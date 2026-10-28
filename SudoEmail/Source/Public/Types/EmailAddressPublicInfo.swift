//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of email address public information associated with an email address in the Platform SDK.
public struct EmailAddressPublicInfo: Equatable, Sendable {

    // MARK: - Properties

    /// The email address in format 'local-part@domain'.
    public let emailAddress: String

    /// Identifier associated with the public key.
    public let keyId: String

    /// The public key for the email address, including format and algorithm details.
    public let publicKeyDetails: EmailAddressPublicKey

    /// Indicates whether encryption is enabled for this email address.
    public let enableEncryption: Bool

    // MARK: - Lifecycle

    /// Initialize a`EmailAddressPublicInfo` instance.
    /// - Parameters:
    ///   - emailAddress: The email address in format 'local-part@domain'.
    ///   - keyId: Identifier associated with the public key.
    ///   - publicKeyDetails: The public key for the email address, including format and algorithm details.
    ///   - enableEncryption: Indicates whether encryption is enabled for this email address. Defaults to true.
    public init(emailAddress: String, keyId: String, publicKeyDetails: EmailAddressPublicKey, enableEncryption: Bool = true) {
        self.emailAddress = emailAddress
        self.keyId = keyId
        self.publicKeyDetails = publicKeyDetails
        self.enableEncryption = enableEncryption
    }
}
