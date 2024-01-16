//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of email address public information associated with an email address in the Platform SDK.
public struct EmailAddressPublicInfo: Equatable {

    /// The email address in format 'local-part@domain'.
    public let emailAddress: String

    /// The raw value of the public key for the email address.
    public let publicKey: String

    /// Initialize an instance of `EmailAddressPublicInfo`.
    public init(emailAddress: String, publicKey: String) {
        self.emailAddress = emailAddress
        self.publicKey = publicKey
    }

}
