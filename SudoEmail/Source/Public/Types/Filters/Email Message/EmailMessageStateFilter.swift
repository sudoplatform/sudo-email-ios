//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Filter for a `EmailMessage.State`.
public enum EmailMessageStateFilter: Equatable {
    /// Filter by equality of `EmailMessage.State`.
    case equals(EmailMessage.State)
    /// Filter by non-equality of `EmailMessage.State`.
    case notEquals(EmailMessage.State)
    /// Filter by `EmailMessage.State` equaling any of the values of the input.
    case isIn([EmailMessage.State])
    /// Filter by `EmailMessage.State` not equaling any of the values of the input.
    case isNotIn([EmailMessage.State])
}
