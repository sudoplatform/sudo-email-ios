//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a email message direction business rule. Depicts the direction of an email message.
enum DirectionEntity: Equatable {
    /// Message is inbound to the user - message has been received by the user.
    case inbound
    /// Message is outbound to the user - message has been sent by the user.
    case outbound
}

/// Core entity representation of a email message state business rule. Depicts the state of the email message.
enum StateEntity: Equatable {
    /// Outbound message is queued to be sent.
    case queued
    /// Outbound message has been sent.
    case sent
    /// Outbound message has been acknowledged as delivered upstream.
    case delivered
    /// Outbound message has been acknowledged as undelivered upstream.
    case undelivered
    /// Outbound message has been acknowledged as failed upstream.
    case failed
    /// Inbound message has been received.
    case received
}

/// Core entity representation of a email message business rule. Depicts the meta data of an email message.
struct EmailMessageEntity: Equatable {

    /// Unique identifier of the email message.
    var id: String

    /// Unique identifier associated with this entity for its key encryption/decryption.
    var keyId: String

    /// Algorithm used to encrypt/decrypt this entity.
    var algorithm: String

    /// Unique identifier used for identifying where the message RFC822 is stored.
    var sealedId: String

    /// Unique client reference identifier.
    var clientRefId: String?

    /// Unique identifier of the owner of the email message.
    var owner: String

    /// Date timestamp when the email message was created on the service.
    var created: Date

    /// Date timestamp when the email message was last updated on the service.
    var updated: Date

    // TODO: We should consider doing a lookup for the account
    /// Email address that is associated with the account of the email message - which account sent/received this message.
    var accountAddress: EmailAddressEntity

    /// True if the user has seen the email message previously.
    var seen: Bool

    /// Direction of the email message.
    var direction: DirectionEntity

    /// State of the email message.
    var state: StateEntity

    /// Array of from recipients of the email message.
    var from: [EmailAddressEntity]

    /// Array of to recipients of the email message.
    var to: [EmailAddressEntity]

    /// Array of carbon copy recipients of the email message.
    var cc: [EmailAddressEntity]

    /// Array of blind carbon copy recipients of the email message.
    var bcc: [EmailAddressEntity]

    /// Subject header of the email message.
    var subject: String?

}
