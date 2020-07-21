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

    /// Unique identifier of the email message.
    public var id: String

    /// Unique client reference identifier.
    public var clientRefId: String?

    /// Unique identifier of the owner of the email message.
    public var owner: String

    /// Date timestamp when the email message was created on the service.
    public var created: Date

    /// Date timestamp when the email message was last updated on the service.
    public var updated: Date

    /// Email address that is associated with the account of the email message - which account sent/received this message.
    public var address: String

    /// True if the user has seen the email message previously.
    public var seen: Bool

    /// Direction of the email message.
    public var direction: Direction

    /// State of the email message.
    public var state: State

    /// Array of from recipients of the email message.
    public var from: [String]

    /// Array of to recipients of the email message.
    public var to: [String]

    /// Array of carbon copy recipients of the email message.
    public var cc: [String]

    /// Array of blind carbon copy recipients of the email message.
    public var bcc: [String]

    /// Subject header of the email message.
    public var subject: String?

    /// Initialize an instance of `EmailMessage`.
    public init(
        id: String,
        clientRefId: String?,
        owner: String,
        created: Date,
        updated: Date,
        address: String,
        seen: Bool,
        direction: Direction,
        state: State,
        from: [String],
        to: [String],
        cc: [String],
        bcc: [String],
        subject: String?
    ) {
        self.id = id
        self.clientRefId = clientRefId
        self.owner = owner
        self.created = created
        self.updated = updated
        self.address = address
        self.seen = seen
        self.direction = direction
        self.state = state
        self.from = from
        self.to = to
        self.cc = cc
        self.bcc = bcc
        self.subject = subject
    }

}
