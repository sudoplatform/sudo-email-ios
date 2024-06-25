//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of a email message object associated with a email message in Platform SDK.
public struct EmailMessage: Equatable {

    public struct EmailAddress: Equatable {
        public var address: String
        public var displayName: String?

        public init(address: String, displayName: String? = nil) {
            self.address = address
            self.displayName = displayName
        }
    }

    /// Direction of an email message.
    public enum Direction: Equatable {
        /// Message is inbound to the user - message has been received by the user.
        case inbound
        /// Message is outbound to the user - message has been sent by the user.
        case outbound
    }

    /// State of an email message.
    public enum State: Equatable {
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

    /// Unique identifier of the email message.
    public var id: String

    /// Unique client reference identifier.
    public var clientRefId: String?

    /// Unique identifier of the user of the email message.
    public var owner: String

    /// List of owner identifiers and issuers associated with this email message.
    public var owners: [Owner]

    /// Email address id that is associated with the account of the email message - which account sent/received this message.
    public var emailAddressId: String

    /// Unique identifier of the email folder which the message is assigned to.
    public var folderId: String

    /// Unique identifier of the previous email folder which the message resource was assigned to, if any.
    public var previousFolderId: String?

    /// Date timestamp when the email message was created on the service.
    public var createdAt: Date

    /// Date timestamp when the email message was last updated on the service.
    public var updatedAt: Date

    /// Date timestamp when the email message was processed by the service.
    public var sortDate: Date

    /// True if the user has seen the email message previously.
    public var seen: Bool

    /// Direction of the email message.
    public var direction: Direction

    /// State of the email message.
    public var state: State

    /// The size, in bytes, of the encrypted RFC822 data stored in the backend. This value is used to
    /// calculate the total storage used by an email address or user and used to enforce email storage related
    public var size: Double
    
    /// The encryption status of the message
    public var encryptionStatus: EncryptionStatus

    /// Version of this entity, increments on update.
    public var version: Int

    /// Array of from email addresses, eg the authors, of the email message.
    public var from: [EmailMessage.EmailAddress]

    public var replyTo: [EmailMessage.EmailAddress]

    /// Array of to recipients of the email message.
    public var to: [EmailMessage.EmailAddress]

    /// Array of carbon copy recipients of the email message.
    public var cc: [EmailMessage.EmailAddress]

    /// Array of blind carbon copy recipients of the email message.
    public var bcc: [EmailMessage.EmailAddress]

    /// Subject header of the email message.
    public var subject: String?

    /// True if the email message includes one or more attachments.
    public var hasAttachments: Bool
    
    /// Date timestamp of when the message was sent
    public var date: Date?

    /// Initialize an instance of `EmailMessage`.
    public init(
        id: String,
        clientRefId: String?,
        owner: String,
        owners: [Owner],
        emailAddressId: String,
        folderId: String,
        previousFolderId: String?,
        createdAt: Date,
        updatedAt: Date,
        sortDate: Date,
        seen: Bool,
        direction: Direction,
        state: State,
        version: Int,
        size: Double,
        from: [EmailMessage.EmailAddress],
        replyTo: [EmailMessage.EmailAddress],
        to: [EmailMessage.EmailAddress],
        cc: [EmailMessage.EmailAddress],
        bcc: [EmailMessage.EmailAddress],
        subject: String?,
        hasAttachments: Bool,
        encryptionStatus: EncryptionStatus,
        date: Date?
    ) {
        self.id = id
        self.clientRefId = clientRefId
        self.owner = owner
        self.owners = owners
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.sortDate = sortDate
        self.emailAddressId = emailAddressId
        self.folderId = folderId
        self.previousFolderId = previousFolderId
        self.seen = seen
        self.direction = direction
        self.state = state
        self.version = version
        self.size = size
        self.from = from
        self.replyTo = replyTo
        self.to = to
        self.cc = cc
        self.bcc = bcc
        self.subject = subject
        self.hasAttachments = hasAttachments
        self.encryptionStatus = encryptionStatus
        self.date = date
    }

}

/// Representation of an email message object without any unsealed attributes associated with a email message in Platform SDK.
public struct PartialEmailMessage: Equatable {

    /// Unique identifier of the email message.
    public var id: String

    /// Unique client reference identifier.
    public var clientRefId: String?

    /// Unique identifier of the user of the email message.
    public var owner: String

    /// List of owner identifiers and issuers associated with this email message.
    public var owners: [Owner]

    /// Email address id that is associated with the account of the email message - which account sent/received this message.
    public var emailAddressId: String

    /// Unique identifier of the email folder which the message is assigned to.
    public var folderId: String

    /// Unique identifier of the previous email folder which the message resource was assigned to, if any.
    public var previousFolderId: String?

    /// Date timestamp when the email message was created on the service.
    public var createdAt: Date

    /// Date timestamp when the email message was last updated on the service.
    public var updatedAt: Date

    /// Date timestamp when the email message was processed by the service.
    public var sortDate: Date

    /// True if the user has seen the email message previously.
    public var seen: Bool

    /// Direction of the email message.
    public var direction: EmailMessage.Direction

    /// State of the email message.
    public var state: EmailMessage.State

    /// The size, in bytes, of the encrypted RFC822 data stored in the backend. This value is used to
    /// calculate the total storage used by an email address or user and used to enforce email storage related
    public var size: Double
    
    /// The encryption status of the message
    var encryptionStatus: EncryptionStatus

    /// Version of this entity, increments on update.
    public var version: Int
    
    /// Date timestamp of when the message was sent
    public var date: Date?

    /// Initialize an instance of `EmailMessage`.
    public init(
        id: String,
        clientRefId: String?,
        owner: String,
        owners: [Owner],
        emailAddressId: String,
        folderId: String,
        previousFolderId: String?,
        createdAt: Date,
        updatedAt: Date,
        sortDate: Date,
        seen: Bool,
        direction: EmailMessage.Direction,
        state: EmailMessage.State,
        version: Int,
        size: Double,
        encryptionStatus: EncryptionStatus,
        date: Date?
    ) {
        self.id = id
        self.clientRefId = clientRefId
        self.owner = owner
        self.owners = owners
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.sortDate = sortDate
        self.emailAddressId = emailAddressId
        self.folderId = folderId
        self.previousFolderId = previousFolderId
        self.seen = seen
        self.direction = direction
        self.state = state
        self.version = version
        self.size = size
        self.encryptionStatus = encryptionStatus
        self.date = date
    }
}
