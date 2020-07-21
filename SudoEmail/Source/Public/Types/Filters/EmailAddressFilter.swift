//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Filter for a `EmailAddress`.
public indirect enum EmailAddressFilter: Equatable {
    /// Filter rule for an `address` property.
    case address(StringFilter)
    /// Filter rule for negating a `EmailAddress` filter rule.
    case not(EmailAddressFilter)
    /// Filter rule for logical AND compounding `EmailAddress` filter rules.
    case and([EmailAddressFilter])
    /// Filter rule for logical OR compounding `EmailAddress` filter rules.
    case or([EmailAddressFilter])
}
