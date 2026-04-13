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

    /// The identifier of the email mask used to send the message, if applicable
    public var emailMaskId: String?

    /// The timestamp of when to send the message
    public var sendAt: Date

    public init(id: String, emailAddressId: String, emailMaskId: String? = nil, sendAt: Date) {
        self.id = id
        self.emailAddressId = emailAddressId
        self.emailMaskId = emailMaskId
        self.sendAt = sendAt
    }
}
