//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for getting a draft email message using `SudoEmailClient`

public struct GetDraftEmailMessageInput {

    /// The identifier of the draft email message to be retrieved.
    public var id: String

    /// The identifier of the email address associated with the draft email message.
    public var emailAddressId: String

    /// The identifier of the email alias associated with the draft email message.
    public var emailAliasId: String?

    public init(id: String, emailAddressId: String, emailAliasId: String? = nil) {
        self.id = id
        self.emailAddressId = emailAddressId
        self.emailAliasId = emailAliasId
    }
}
