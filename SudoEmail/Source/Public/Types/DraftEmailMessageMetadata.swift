//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of a draft email message metadata object associated with a draft email message in Platform SDK.
public struct DraftEmailMessageMetadata: Sendable {

    /// Unique identifier of the draft email message.
    public var id: String

    /// Unique identifier of the email address associated with the draft email message.
    public var emailAddressId: String

    /// Time at which the draft was last updated
    public var updatedAt: Date

    /// Unique identifier of the email alias associated with the draft email message.
    public var emailAliasId: String?

    public init(id: String, emailAddressId: String, updatedAt: Date, emailAliasId: String? = nil) {
        self.id = id
        self.emailAddressId = emailAddressId
        self.updatedAt = updatedAt
        self.emailAliasId = emailAliasId
    }
}
