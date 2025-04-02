//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core representation of email address public information. Depicts the email address and public key for an email address resource.
struct EmailAddressPublicInfoEntity: Equatable {

    /// The email address in format 'local-part@domain'.
    let emailAddress: String

    /// Identifier associated with the public key.
    let keyId: String

    /// The details of the public key for the email address.
    let publicKeyDetails: EmailAddressPublicKeyEntity
}
