//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

// input object for getting a draft email message using `SudoEmailClient`

public struct GetDraftEmailMessageInput {

    /// The identifier of the draft email message to be retrieved.
    public var id: String

    /// The identifier of the email address associated with the draft email message.
    public var emailAddressId: String

    /// The identifier of the email mask associated with the draft email message.
    public var emailMaskId: String?

    public init(id: String, emailAddressId: String, emailMaskId: String? = nil) {
        self.id = id
        self.emailAddressId = emailAddressId
        self.emailMaskId = emailMaskId
    }
}
