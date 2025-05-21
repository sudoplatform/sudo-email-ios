//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for cancelling a scheduled draft message
public struct CancelScheduledDraftMessageInput {

    /// The identifier of the draft message to cancel
    public var id: String

    /// The identifier of the email address that owns the message.
    public var emailAddressId: String

    public init(id: String, emailAddressId: String) {
        self.id = id
        self.emailAddressId = emailAddressId
    }
}
