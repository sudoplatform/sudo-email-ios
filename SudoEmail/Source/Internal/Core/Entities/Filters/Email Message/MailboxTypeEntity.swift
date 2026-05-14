//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core entity representation of a mailbox type.
enum MailboxTypeEntity: Equatable {
    /// An email address mailbox.
    case address
    /// A masked email mailbox.
    case mask
}
