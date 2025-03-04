//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for creating a draft email message using `SudoEmailClient`

public struct CreateDraftEmailMessageInput {

    /// Draft email message data formatted under the RFC 6854, which supercedes RFC822.
    public var rfc822Data: Data

    /// The identifier of the email address used to send the email. The identifier must match the
    /// identifier of the email address of the `from` field in the RFC 6854 data.
    public var senderEmailAddressId: String

    public init(rfc822Data: Data, senderEmailAddressId: String) {
        self.rfc822Data = rfc822Data
        self.senderEmailAddressId = senderEmailAddressId
    }
}
