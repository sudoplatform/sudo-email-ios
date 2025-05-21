//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public enum ScheduledDraftMessageState: Equatable {
    /// Message has been scheduled, but no attempts to send have been made.
    case scheduled

    /// Message has failed to be sent, but may be retried.
    case failed

    /// Message has successfully been sent.
    case sent

    /// Sending has been cancelled and will not be attempted.
    case cancelled
}

public struct ScheduledDraftMessage: Equatable {

    // MARK: - Properties

    /// The identifier of the draft message to schedule
    public let id: String

    /// The identifier of the email address to send the message from
    public let emailAddressId: String

    /// The timestamp of when to send the message
    public let sendAt: Date

    /// Unique identifier of the user that owns the email account.
    public let owner: String

    /// The identifier and issuer of the owners of the email account.
    public let owners: [Owner]

    /// The current state of the scheduled draft message
    public let state: ScheduledDraftMessageState

    /// The timestamp of when the scheduled draft message was created
    public let createdAt: Date

    /// The timestamp of when the scheduled draft message was last updated
    public let updatedAt: Date
}
