//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Filter for a `EmailMessage.Direction`.
public enum EmailMessageDirectionFilter: Equatable {
    /// Filter by equality of `EmailMessage.Direction`.
    case equals(EmailMessage.Direction)
    /// Filter by non-equality of `EmailMessage.Direction`.
    case notEquals(EmailMessage.Direction)
}
