//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input for the `flushMessageBodyCache` operation.
public struct FlushMessageBodyCacheInput: Sendable {

    /// The sudo ID to scope the flush to. Mutually exclusive with `emailAddressId`.
    public let sudoId: String?

    /// The email address ID to scope the flush to. Mutually exclusive with `sudoId`.
    public let emailAddressId: String?

    public init(sudoId: String? = nil, emailAddressId: String? = nil) {
        self.sudoId = sudoId
        self.emailAddressId = emailAddressId
    }
}
