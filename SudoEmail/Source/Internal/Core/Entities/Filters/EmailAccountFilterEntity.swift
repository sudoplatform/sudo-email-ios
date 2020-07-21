//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core entity representation of a domain business rule. Depicts the filter traits for an email account.
indirect enum EmailAccountFilterEntity: Equatable {
    /// Filter rule for an address property.
    case address(StringFilterEntity)
    /// Filter rule for negating a email account filter rule.
    case not(EmailAccountFilterEntity)
    /// Filter rule for logical AND compounding email account filter rules.
    case and([EmailAccountFilterEntity])
    /// Filter rule for logical OR compounding email account filter rules.
    case or([EmailAccountFilterEntity])
}
