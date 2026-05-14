//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Filter for matching email messages by mailbox ID.
public struct MailboxIdsFilter: Equatable {
    /// The type of mailbox to filter by.
    public let type: EmailMessageMailboxType
    /// The string filter to apply to the mailbox ID.
    public let id: StringFilter

    public init(type: EmailMessageMailboxType, id: StringFilter) {
        self.type = type
        self.id = id
    }
}
