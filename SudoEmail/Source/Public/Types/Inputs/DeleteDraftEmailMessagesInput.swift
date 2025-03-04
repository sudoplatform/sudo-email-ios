//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for deleting draft email messages using `SudoEmailClient`

public struct DeleteDraftEmailMessagesInput {

    /// The list of unique identifiers of the draft email messages to delete.
    public var ids: [String]

    /// The identifier of the email address associated with the draft email message.
    public var emailAddressId: String

    public init(ids: [String], emailAddressId: String) {
        self.ids = ids
        self.emailAddressId = emailAddressId
    }
}
