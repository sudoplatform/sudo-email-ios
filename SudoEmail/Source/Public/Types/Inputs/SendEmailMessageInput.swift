//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Represents the sender identification for an email message.
public enum SenderIdentification: Equatable {
    case emailAddressId(String)
    case maskId(String)
}

/// Input object containing information required to send an email message.
public struct SendEmailMessageInput: Equatable {

    /// The identification of the sender used to send the email.
    /// This can be either an email address ID or a mask ID, but not both.
    public let senderIdentification: SenderIdentification

    /// The identifier of the email address used to send the email.
    /// The identifier must match the identifier of the email address of the `from` field in the RFC 6854 data.
    public var senderEmailAddressId: String {
        switch senderIdentification {
        case .emailAddressId(let id):
            return id
        case .maskId:
            fatalError("Cannot access senderEmailAddressId when using maskId")
        }
    }

    /// The identifier of the email mask used to send the email.
    /// The identifier must match the identifier of the mask of the `from` field in the RFC 6854 data.
    public var senderMaskId: String {
        switch senderIdentification {
        case .maskId(let id):
            return id
        case .emailAddressId:
            fatalError("Cannot access senderMaskId when using emailAddressId")
        }
    }

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
        senderIdentification: SenderIdentification,
        emailMessageHeader: InternetMessageFormatHeader,
        body: String,
        attachments: [EmailAttachment] = [],
        inlineAttachments: [EmailAttachment] = [],
        replyingMessageId: String? = nil,
        forwardingMessageId: String? = nil
    ) {
        self.senderIdentification = senderIdentification
        self.emailMessageHeader = emailMessageHeader
        self.body = body
        self.attachments = attachments
        self.inlineAttachments = inlineAttachments
        self.replyingMessageId = replyingMessageId
        self.forwardingMessageId = forwardingMessageId
    }

    // Email address initializer
    public init(
        senderEmailAddressId: String,
        emailMessageHeader: InternetMessageFormatHeader,
        body: String,
        attachments: [EmailAttachment] = [],
        inlineAttachments: [EmailAttachment] = [],
        replyingMessageId: String? = nil,
        forwardingMessageId: String? = nil
    ) {
        self.init(
            senderIdentification: .emailAddressId(senderEmailAddressId),
            emailMessageHeader: emailMessageHeader,
            body: body,
            attachments: attachments,
            inlineAttachments: inlineAttachments,
            replyingMessageId: replyingMessageId,
            forwardingMessageId: forwardingMessageId
        )
    }

    // Initializer for mask IDs
    public init(
        senderMaskId: String,
        emailMessageHeader: InternetMessageFormatHeader,
        body: String,
        attachments: [EmailAttachment] = [],
        inlineAttachments: [EmailAttachment] = [],
        replyingMessageId: String? = nil,
        forwardingMessageId: String? = nil
    ) {
        self.init(
            senderIdentification: .maskId(senderMaskId),
            emailMessageHeader: emailMessageHeader,
            body: body,
            attachments: attachments,
            inlineAttachments: inlineAttachments,
            replyingMessageId: replyingMessageId,
            forwardingMessageId: forwardingMessageId
        )
    }
}
