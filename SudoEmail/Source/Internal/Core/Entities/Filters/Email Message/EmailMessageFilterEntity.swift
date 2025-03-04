//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core entity representation of a email message filter business rule. Depicts the rules for filtering email messages.
indirect enum EmailMessageFilterEntity: Equatable {
    /// Filter rule for an `id` property.
    case id(StringFilterEntity)
    /// Filter rule for an `messageId` property.
    case messageId(StringFilterEntity)
    /// Filter rule for an `folderId` property.
    case folderId(StringFilterEntity)
    /// Filter rule for an `algorithm` property.
    case algorithm(StringFilterEntity)
    /// Filter rule for an `keyId` property.
    case keyId(StringFilterEntity)
    /// Filter rule for an `clientRefId` property.
    case clientRefId(StringFilterEntity)
    /// Filter rule for an `direction` property.
    case direction(EmailMessageDirectionFilterEntity)
    /// Filter rule for an `seen` property.
    case seen(BoolFilterEntity)
    /// Filter rule for a `repliedTo` property.
    case repliedTo(BoolFilterEntity)
    /// Filter rule for a `forwarded` property.
    case forwarded(BoolFilterEntity)
    /// Filter rule for an `state` property.
    case state(EmailMessageStateFilterEntity)
    /// Filter rule for negating a `EmailMessageEntity` filter rule.
    case not(EmailMessageFilterEntity)
    /// Filter rule for logical AND compounding `EmailMessageEntity` filter rules.
    case and([EmailMessageFilterEntity])
    /// Filter rule for logical OR compounding `EmailMessageEntity` filter rules.
    case or([EmailMessageFilterEntity])
}
