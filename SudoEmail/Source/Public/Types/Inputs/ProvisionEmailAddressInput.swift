//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for Provisioning an email address using `SudoEmailClient`
public struct ProvisionEmailAddressInput: Equatable {

    /// The email address to provision, in the form `${localPart}@${domain}`.
    public let emailAddress: String

    /// The signed ownership proof of the Sudo to be associated with the provisioned email address.
    ///  The ownership proof must contain an audience of "sudoplatform".
    public let ownershipProofToken: String

    /// An optional user defined display name for the email address.
    public let displayName: String?

    /// Optional identifier of the Public Key to use to provision the email address.
    public let keyId: String?

    public init(emailAddress: String, ownershipProofToken: String, displayName: String? = nil, keyId: String? = nil) {
        self.emailAddress = emailAddress
        self.ownershipProofToken = ownershipProofToken
        self.displayName = displayName
        self.keyId = keyId
    }
}
