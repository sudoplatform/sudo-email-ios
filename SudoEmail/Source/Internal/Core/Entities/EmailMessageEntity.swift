//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
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

/// Core entity representation of an email message business rule. Depicts the meta data of an email message.
struct EmailMessageEntity: Equatable {

    /// Unique identifier of the email message. Combination of the `messageId` and the `keyId`.
    ///
    /// E.g. `\(messageId)-\(keyId)`
    var id: String

    /// Unique identifier of the user of the email message.
    var owner: String

    /// List of identifiers of user/accounts associated with this email message.
    var owners: [OwnerEntity]

    /// Email address identifier that is associated with the account of the email message.
    ///
    /// This is the id of the account that sent/received this message.
    var emailAddressId: String

    /// Unique identifier associated with this entity for its key encryption/decryption.
    var keyId: String

    /// Unique identifier of the email folder which the message resource is assigned to.
    var folderId: String

    /// Unique identifier of the previous email folder which the message resource is assigned to, if any.
    var previousFolderId: String?

    /// True if the user has seen the email message previously.
    var seen: Bool

    /// Direction of the email message.
    var direction: DirectionEntity

    /// State of the email message.
    var state: StateEntity

    /// Unique client reference identifier.
    var clientRefId: String?

    /// Date timestamp when the email message was processed by the service.
    var sortDate: Date

    /// Date timestamp when the email message was created on the service.
    var createdAt: Date

    /// Date timestamp when the email message was last updated on the service.
    var updatedAt: Date

    /// Array of from email addresses, eg the authors, of the email message.
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

    /// True if the email message includes one or more attachments.
    var hasAttachments: Bool

    /// Version of this entity, increments on update.
    var version: Int

    /// The total size in bytes of this email message.
    var size: Double

}

/// Core entity representation of an email message without unsealed attributes business rule. Depicts the meta data of an email message.
struct PartialEmailMessageEntity: Equatable {

    /// Unique identifier of the email message. Combination of the `messageId` and the `keyId`.
    ///
    /// E.g. `\(messageId)-\(keyId)`
    var id: String

    /// Unique identifier of the user of the email message.
    var owner: String

    /// List of identifiers of user/accounts associated with this email message.
    var owners: [OwnerEntity]

    /// Email address identifier that is associated with the account of the email message.
    ///
    /// This is the id of the account that sent/received this message.
    var emailAddressId: String

    /// Unique identifier associated with this entity for its key encryption/decryption.
    var keyId: String

    /// Unique identifier of the email folder which the message resource is assigned to.
    var folderId: String

    /// Unique identifier of the previous email folder which the message resource is assigned to, if any.
    var previousFolderId: String?

    /// True if the user has seen the email message previously.
    var seen: Bool

    /// Direction of the email message.
    var direction: DirectionEntity

    /// State of the email message.
    var state: StateEntity

    /// Unique client reference identifier.
    var clientRefId: String?

    /// Date timestamp when the email message was processed by the service.
    var sortDate: Date

    /// Date timestamp when the email message was created on the service.
    var createdAt: Date

    /// Date timestamp when the email message was last updated on the service.
    var updatedAt: Date

    /// Version of this entity, increments on update.
    var version: Int

    /// The total size in bytes of this email message.
    var size: Double

}
