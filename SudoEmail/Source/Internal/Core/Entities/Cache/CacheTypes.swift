//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Result returned from a successful cache lookup.
struct CacheItem: Sendable {

    /// Identifier of the email message.
    let messageId: String

    /// Identifier of the owning sudo, if available.
    let sudoId: String?

    /// Identifier of the owning email address.
    let emailAddressId: String

    /// The sealed (encrypted) message body data.
    let sealedBlob: Data

    /// The content-encoding value from S3 (e.g. "sudoplatform-crypto,sudoplatform-compression").
    let contentEncoding: String?
}

/// Input for flushing cache entries by scope.
struct CacheFlushInput: Sendable {

    /// The sudo ID to scope the flush to. Mutually exclusive with `emailAddressId`.
    let sudoId: String?

    /// The email address ID to scope the flush to. Mutually exclusive with `sudoId`.
    let emailAddressId: String?
}
