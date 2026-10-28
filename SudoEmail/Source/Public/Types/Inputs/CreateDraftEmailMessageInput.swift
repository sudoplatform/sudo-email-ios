//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

// input object for creating a draft email message using `SudoEmailClient`
// The email address in the `From` field of the RFC6854 data must match either the `aliasAddress` of the Email Alias associated with the
// `emailAliasId` property, if provided, otherwise the `emailAddress` of the Email Address associated with the `senderEmailAddressId` property.

public struct CreateDraftEmailMessageInput {

    /// Draft email message data formatted under the RFC 6854, which supercedes RFC822.
    public var rfc822Data: Data

    /// The identifier of the email address used to send the email.
    public var senderEmailAddressId: String

    /// Optional identifier of the email alias associated with the draft email message.
    public var emailAliasId: String?

    public init(rfc822Data: Data, senderEmailAddressId: String, emailAliasId: String? = nil) {
        self.rfc822Data = rfc822Data
        self.senderEmailAddressId = senderEmailAddressId
        self.emailAliasId = emailAliasId
    }
}
