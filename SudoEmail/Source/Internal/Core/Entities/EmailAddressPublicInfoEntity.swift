//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core representation of email address public information. Depicts the email address and public key for an email address resource.
struct EmailAddressPublicInfoEntity: Equatable {
    /// The email address in format 'local-part@domain'.
    let emailAddress: String

    /// The raw value of the public key for the email address.
    let publicKey: String
}
