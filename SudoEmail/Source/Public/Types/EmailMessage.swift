//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of a email message object associated with a email message in Platform SDK.
public struct EmailMessage: Equatable {

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

    public struct EmailAddress: Equatable {
        public var address: String
        public var displayName: String?

        public init(address: String, displayName: String? = nil) {
            self.address = address
            self.displayName = displayName
        }
    }

    /// Unique identifier of the email message.
    public var id: String

    /// Unique client reference identifier.
    public var clientRefId: String?

    /// Unique identifier of the user of the email message.
    public var userId: String

    /// Unique identifier of the sudo of the email message.
    public var sudoId: String

    /// Email address id that is associated with the account of the email message - which account sent/received this message.
    public var emailAddressId: String

    /// Date timestamp when the email message was created on the service.
    public var created: Date

    /// Date timestamp when the email message was last updated on the service.
    public var updated: Date

    /// True if the user has seen the email message previously.
    public var seen: Bool

    /// Direction of the email message.
    public var direction: Direction

    /// State of the email message.
    public var state: State

    /// Array of from recipients of the email message.
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

    /// Initialize an instance of `EmailMessage`.
    public init(
        id: String,
        clientRefId: String?,
        userId: String,
        sudoId: String,
        emailAddressId: String,
        created: Date,
        updated: Date,
        seen: Bool,
        direction: Direction,
        state: State,
        from: [EmailMessage.EmailAddress],
        replyTo: [EmailMessage.EmailAddress],
        to: [EmailMessage.EmailAddress],
        cc: [EmailMessage.EmailAddress],
        bcc: [EmailMessage.EmailAddress],
        subject: String?
    ) {
        self.id = id
        self.clientRefId = clientRefId
        self.userId = userId
        self.sudoId = sudoId
        self.created = created
        self.updated = updated
        self.emailAddressId = emailAddressId
        self.seen = seen
        self.direction = direction
        self.state = state
        self.from = from
        self.replyTo = replyTo
        self.to = to
        self.cc = cc
        self.bcc = bcc
        self.subject = subject
    }

}
