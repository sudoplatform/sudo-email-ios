//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core entity representation of a domain business rule. Depicts the filter traits for an email account.
indirect enum EmailAccountFilterEntity: Equatable {
    /// Filter rule for an id property.
    case id(StringFilterEntity)
    /// Filter rule for an sudoId property.
    case sudoId(StringFilterEntity)
    /// Filter rule for an identityId property.
    case identityId(StringFilterEntity)
    /// Filter rule for an keyRingId property.
    case keyRingId(StringFilterEntity)
    /// Filter rule for an emailAddress property.
    case emailAddress(StringFilterEntity)
    /// Filter rule for negating a email account filter rule.
    case not(EmailAccountFilterEntity)
    /// Filter rule for logical AND compounding email account filter rules.
    case and([EmailAccountFilterEntity])
    /// Filter rule for logical OR compounding email account filter rules.
    case or([EmailAccountFilterEntity])
}
