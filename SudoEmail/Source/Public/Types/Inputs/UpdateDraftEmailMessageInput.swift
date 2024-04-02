//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for updating a draft email message using `SudoEmailClient`

public struct UpdateDraftEmailMessageInput {

    /// The identifier of the draft email message to update.
    public var id: String

    /// Draft email message data formatted under the RFC 6854, which supercedes RFC822.
    /// This will completely replace the existing data.
    public var rfc822Data: Data

    /// The identifier of the email address used to send the email. The identifier must match the
    /// identifier of the email address of the `from` field in the RFC 6854 data.
    public var senderEmailAddressId: String

    public init(id: String, rfc822Data: Data, senderEmailAddressId: String) {
        self.id = id
        self.rfc822Data = rfc822Data
        self.senderEmailAddressId = senderEmailAddressId
    }
}
