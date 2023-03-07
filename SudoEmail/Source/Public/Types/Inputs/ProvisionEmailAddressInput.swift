//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
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

    /// An alias for the email address.
    public let alias: String?

    public init(emailAddress: String, ownershipProofToken: String, alias: String? = nil) {
        self.emailAddress = emailAddress
        self.ownershipProofToken = ownershipProofToken
        self.alias = alias
    }
}
