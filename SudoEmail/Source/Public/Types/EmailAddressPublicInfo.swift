//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of email address public information associated with an email address in the Platform SDK.
public struct EmailAddressPublicInfo: Equatable {

    // MARK: - Properties

    /// The email address in format 'local-part@domain'.
    public let emailAddress: String

    /// Identifier associated with the public key.
    public let keyId: String

    /// The public key for the email address, including format and algorithm details.
    public let publicKeyDetails: EmailAddressPublicKey

    // MARK: - Properties: Deprecated

    /// The raw value of the public key for the email address.
    @available(*, deprecated, message: "Use `publicKeyDetails` instead")
    public let publicKey: String

    // MARK: - Lifecycle

    /// Initialize a`EmailAddressPublicInfo` instance.
    /// - Parameters:
    ///   - emailAddress: The email address in format 'local-part@domain'.
    ///   - keyId: Identifier associated with the public key.
    ///   - publicKeyDetails: The public key for the email address, including format and algorithm details.
    public init(emailAddress: String, keyId: String, publicKeyDetails: EmailAddressPublicKey) {
        self.emailAddress = emailAddress
        self.keyId = keyId
        self.publicKeyDetails = publicKeyDetails
        publicKey = publicKeyDetails.publicKey
    }

    @available(*, deprecated, message: "Use `init(emailAddress:keyId:publicKeyDetails:)` instead")
    public init(emailAddress: String, keyId: String, publicKey: String) {
        self.emailAddress = emailAddress
        self.keyId = keyId
        self.publicKey = publicKey
        publicKeyDetails = EmailAddressPublicKey(
            publicKey: publicKey,
            keyFormat: .rsaPublicKey,
            algorithm: DefaultDeviceKeyWorker.Defaults.algorithm
        )
    }
}
