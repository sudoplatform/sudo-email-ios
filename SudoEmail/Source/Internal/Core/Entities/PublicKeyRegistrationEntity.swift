//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of one registration of a public key with the email service: the key, and the key ring
/// of the email address or email alias it is registered for. A key shared by several addresses or aliases has one
/// registration for each of them.
struct PublicKeyRegistrationEntity: Equatable {

    /// Identifier of the key pair the public key belongs to.
    let keyId: String

    /// Identifier of the key ring of the email address or email alias the key is registered for.
    let keyRingId: String
}
