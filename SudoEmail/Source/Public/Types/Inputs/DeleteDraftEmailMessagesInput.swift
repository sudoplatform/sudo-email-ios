//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for deleting draft email messages using `SudoEmailClient`

public struct DeleteDraftEmailMessagesInput {

    /// The list of unique identifiers of the draft email messages to delete.
    public var ids: [String]

    /// The identifier of the email address associated with the draft email messages.
    public var emailAddressId: String

    /// The identifier of the email alias associated with the draft email messages.In order to
    /// delete draft email messages that are associated with an email alias, the `emailAliasId` must be provided and match the email alias
    /// associated with the draft email messages. If the draft email messages are not associated with an email alias, this property should be omitted.
    public var emailAliasId: String?

    public init(ids: [String], emailAddressId: String, emailAliasId: String? = nil) {
        self.ids = ids
        self.emailAddressId = emailAddressId
        self.emailAliasId = emailAliasId
    }
}
