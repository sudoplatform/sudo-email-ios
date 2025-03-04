//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
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

    /// Identifier of the message being replied to.
    /// If this property is set, `forwardingMessageId` must not be set.
    public let replyingMessageId: String?

    /// Identifier of the message being forwarded.
    /// If this property is set, `replyingMessageId` must not be set.
    public let forwardingMessageId: String?

    public init(
        senderEmailAddressId: String,
        emailMessageHeader: InternetMessageFormatHeader,
        body: String,
        attachments: [EmailAttachment] = [],
        inlineAttachments: [EmailAttachment] = [],
        replyingMessageId: String? = nil,
        forwardingMessageId: String? = nil
    ) {
        self.senderEmailAddressId = senderEmailAddressId
        self.emailMessageHeader = emailMessageHeader
        self.body = body
        self.attachments = attachments
        self.inlineAttachments = inlineAttachments
        self.replyingMessageId = replyingMessageId
        self.forwardingMessageId = forwardingMessageId
    }
}
