//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of a draft email message metadata object associated with a draft email message in Platform SDK.
public struct DraftEmailMessageMetadata {

    /// Unique identifier of the draft email message.
    public var id: String

    /// Time at which the draft was last updated
    public var updatedAt: Date

    public init(id: String, updatedAt: Date) {
        self.id = id
        self.updatedAt = updatedAt
    }
}
