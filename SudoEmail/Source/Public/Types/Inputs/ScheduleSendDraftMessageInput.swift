//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for scheduling a draft message to be sent at a specified poit in the future
public struct ScheduleSendDraftMessageInput {

    /// The identifier of the draft message to schedule
    public var id: String

    /// The identifier of the email address to send the message from
    public var emailAddressId: String

    /// The timestamp of when to send the message
    public var sendAt: Date

    public init(id: String, emailAddressId: String, sendAt: Date) {
        self.id = id
        self.emailAddressId = emailAddressId
        self.sendAt = sendAt
    }
}
