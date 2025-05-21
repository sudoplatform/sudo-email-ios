//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

enum ScheduledDraftMessageStateEntity: Equatable {
    case scheduled

    case failed

    case sent

    case cancelled
}

/// Core entity representing a draft message that has been scheduled to be sent
struct ScheduledDraftMessageEntity: Equatable {

    /// The identifier of the draft message to schedule
    var id: String

    /// The identifier of the email address to send the message from
    var emailAddressId: String

    /// The timestamp of when to send the message
    var sendAt: Date

    /// Unique identifier of the user that owns the email account.
    var owner: String

    /// The identifier and issuer of the owners of the email account.
    var owners: [OwnerEntity]

    /// The current state of the scheduled draft message
    var state: ScheduledDraftMessageStateEntity

    /// The timestamp of when the scheduled draft message was created
    var createdAt: Date

    /// The timestamp of when the scheduled draft message was last updated
    var updatedAt: Date
}
