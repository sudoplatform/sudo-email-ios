//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Type of mailbox used in mailbox ID filtering.
public enum EmailMessageMailboxType: Equatable {
    /// An email address mailbox.
    case address
    /// A masked email mailbox.
    case mask
}
