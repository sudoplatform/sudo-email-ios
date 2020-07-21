//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core entity representation of a email message filter business rule. Depicts the rules for filtering email messages.
indirect enum EmailMessageFilterEntity: Equatable {
    /// Filter rule for an `direction` property.
    case direction(EmailMessageDirectionFilterEntity)
    /// Filter rule for an `seen` property.
    case seen(BoolFilterEntity)
    /// Filter rule for an `state` property.
    case state(EmailMessageStateFilterEntity)
    /// Filter rule for negating a `EmailMessageEntity` filter rule.
    case not(EmailMessageFilterEntity)
    /// Filter rule for logical AND compounding `EmailMessageEntity` filter rules.
    case and([EmailMessageFilterEntity])
    /// Filter rule for logical OR compounding `EmailMessageEntity` filter rules.
    case or([EmailMessageFilterEntity])
}
