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

    /// Unique identifier of the email message. Combination of the `messageId` and the `keyId`.
    ///
    /// E.g. `\(messageId)-\(keyId)`
    var id: String

    /// Unique identitfier of the message itself. All sealed copies of the message share this id.
    var messageId: String

    /// Unique identifier of the user of the email message.
    var userId: String

    /// Unique identifier of the sudo of the email message.
    var sudoId: String

    /// Email address identifier that is associated with the account of the email message.
    ///
    /// This is the id of the account that sent/received this message.
    var emailAddressId: String

    /// Unique identifier associated with this entity for its key encryption/decryption.
    var keyId: String

    /// Algorithm used to encrypt/decrypt this entity.
    var algorithm: String

    /// Unique client reference identifier.
    var clientRefId: String?

    /// Date timestamp when the email message was created on the service.
    var created: Date

    /// Date timestamp when the email message was last updated on the service.
    var updated: Date

    /// True if the user has seen the email message previously.
    var seen: Bool

    /// Direction of the email message.
    var direction: DirectionEntity

    /// State of the email message.
    var state: StateEntity

    /// Array of from recipients of the email message.
    var from: [EmailAddressEntity]

    /// Array of replyTo recipients of the email message.
    var replyTo: [EmailAddressEntity]

    /// Array of to recipients of the email message.
    var to: [EmailAddressEntity]

    /// Array of carbon copy recipients of the email message.
    var cc: [EmailAddressEntity]

    /// Array of blind carbon copy recipients of the email message.
    var bcc: [EmailAddressEntity]

    /// Subject header of the email message.
    var subject: String?

}
