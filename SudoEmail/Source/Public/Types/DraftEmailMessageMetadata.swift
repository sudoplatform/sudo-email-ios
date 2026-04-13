//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of a draft email message metadata object associated with a draft email message in Platform SDK.
public struct DraftEmailMessageMetadata {

    /// Unique identifier of the draft email message.
    public var id: String

    /// Unique identifier of the email address associated with the draft email message.
    public var emailAddressId: String

    /// Time at which the draft was last updated
    public var updatedAt: Date

    /// Unique identifier of the email mask associated with the draft email message.
    public var emailMaskId: String?

    public init(id: String, emailAddressId: String, updatedAt: Date, emailMaskId: String? = nil) {
        self.id = id
        self.emailAddressId = emailAddressId
        self.updatedAt = updatedAt
        self.emailMaskId = emailMaskId
    }
}
