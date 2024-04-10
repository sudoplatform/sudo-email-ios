//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object containing information required to send an email message.
public struct SendEmailMessageInput: Equatable {

    /// The identifier of the email address used to send the email.
    /// The identifier must match the identifier of the email address of the `from` field in the RFC 6854 data.
    public let senderEmailAddressId: String

    /// The email message headers.
    public let emailMessageHeader: InternetMessageFormatHeader

    /// The text body of the email message.
    public let body: String

    /// List of attached files to be sent with the message.
    /// Default is an empty list.
    public let attachments: [EmailAttachment]

    /// List of inline attachments to be sent with the message.
    /// Default is an empty list.
    public let inlineAttachments: [EmailAttachment]

    public init(senderEmailAddressId: String, emailMessageHeader: InternetMessageFormatHeader, body: String, attachments: [EmailAttachment] = [], inlineAttachments: [EmailAttachment] = []) {
        self.senderEmailAddressId = senderEmailAddressId
        self.emailMessageHeader = emailMessageHeader
        self.body = body
        self.attachments = attachments
        self.inlineAttachments = inlineAttachments
    }
}
