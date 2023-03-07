//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Filter for a `EmailMessage`.
public indirect enum EmailMessageFilter {
    /// Filter rule for an `id` property.
    case id(StringFilter)
    /// Filter rule for a `messageId` property.
    case messageId(StringFilter)
    /// Filter rule for an `algorithm` property.
    case algorithm(StringFilter)
    /// Filter rule for a `keyId` property
    case keyId(StringFilter)
    /// Filter rule for a `folderId` property
    case folderId(StringFilter)
    /// Filter rule for a `clientRefId` property.
    case clientRefId(StringFilter)
    /// Filter rule for a `direction` property.
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
