//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for cancelling a scheduled draft message
public struct CancelScheduledDraftMessageInput {

    /// The identifier of the draft message to cancel
    public var id: String

    /// The identifier of the email address that owns the message.
    public var emailAddressId: String

    /// The identifier of the email alias used to send the message, if applicable
    public var emailAliasId: String?

    public init(id: String, emailAddressId: String, emailAliasId: String? = nil) {
        self.id = id
        self.emailAddressId = emailAddressId
        self.emailAliasId = emailAliasId
    }
}
