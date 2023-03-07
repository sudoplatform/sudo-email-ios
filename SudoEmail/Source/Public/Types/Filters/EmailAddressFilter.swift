//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Filter for a `EmailAddress`.
public indirect enum EmailAddressFilter: Equatable {
    /// Filter rule for an `id` property.
    case id(StringFilter)
    /// Filter rule for an `identityId` property.
    case identityId(StringFilter)
    /// Filter rule for an `keyRingId` property.
    case keyRingId(StringFilter)
    /// Filter rule for an `emailAddress` property.
    case emailAddress(StringFilter)
    /// Filter rule for negating a `EmailAddress` filter rule.
    case not(EmailAddressFilter)
    /// Filter rule for logical AND compounding `EmailAddress` filter rules.
    case and([EmailAddressFilter])
    /// Filter rule for logical OR compounding `EmailAddress` filter rules.
    case or([EmailAddressFilter])
}
