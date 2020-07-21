//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Filter for a `EmailMessage`.
public indirect enum EmailMessageFilter {
    /// Filter rule for an `direction` property.
    case direction(EmailMessageDirectionFilter)
    /// Filter rule for an `seen` property.
    case seen(BoolFilter)
    /// Filter rule for an `state` property.
    case state(EmailMessageStateFilter)
    /// Filter rule for negating a `EmailMessage` filter rule.
    case not(EmailMessageFilter)
    /// Filter rule for logical AND compounding `EmailMessage` filter rules.
    case and([EmailMessageFilter])
    /// Filter rule for logical OR compounding `EmailMessage` filter rules.
    case or([EmailMessageFilter])
}
