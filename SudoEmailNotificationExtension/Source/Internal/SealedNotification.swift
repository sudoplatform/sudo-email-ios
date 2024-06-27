//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of sealed email service notification
struct SealedNotification: Decodable {
    /// ID of public key used to seal the notification
    let keyId: String

    /// Encryption algorithm used to seal the notification
    let algorithm: String

    /// Type of email service notification
    let type: String

    /// Base64 encoded sealed payload
    let sealed: String
}
