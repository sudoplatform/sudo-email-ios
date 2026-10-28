//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of a draft email message object associated with a draft email message in Platform SDK.
public struct DraftEmailMessage: Equatable, Sendable {

    /// Unique identifier of the draft email message.
    public var id: String

    /// Unique identifier of the email address associated with the draft email message.
    public var emailAddressId: String

    /// Date timestamp when the draft email message was last updated on the service.
    public var updatedAt: Date

    /// The RFC 822 formatted draft email message content.
    public var rfc822Data: Data

    /// Unique identifier of the email alias associated with the draft email message, if any.
    public var emailAliasId: String?

    public init(
        id: String,
        emailAddressId: String,
        updatedAt: Date,
        rfc822Data: Data,
        emailAliasId: String? = nil
    ) {
        self.id = id
        self.emailAddressId = emailAddressId
        self.updatedAt = updatedAt
        self.rfc822Data = rfc822Data
        self.emailAliasId = emailAliasId
    }
}
