//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of an email message with body attachments used in the Sudo Platform Email SDK.
public struct EmailMessageWithBody {

    /// Unique identifier of the email message.
    public let id: String

    /// The email message body.
    public let body: String

    /// Flag indicating whether the body is formatted as HTML.
    public let isHtml: Bool

    /// A list of email message attachments.
    public let attachments: [EmailAttachment]

    /// A list of email message inline attachments.
    public let inlineAttachments: [EmailAttachment]

    /// Initialize an instance of `EmailMessageWithBody`.
    public init(id: String, body: String, isHtml: Bool, attachments: [EmailAttachment], inlineAttachments: [EmailAttachment]) {
        self.id = id
        self.body = body
        self.isHtml = isHtml
        self.attachments = attachments
        self.inlineAttachments = inlineAttachments
    }
}
