//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core entity representation of a mailbox IDs filter business rule.
struct MailboxIdsFilterEntity: Equatable {
    /// The type of mailbox to filter by.
    let type: MailboxTypeEntity
    /// The string filter to apply to the mailbox ID.
    let id: StringFilterEntity
}
