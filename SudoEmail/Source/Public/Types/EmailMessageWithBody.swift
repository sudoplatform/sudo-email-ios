//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
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

    /// A list of email message attachments.
    public let attachments: [EmailAttachment]

    /// A list of email message inline attachments.
    public let inlineAttachments: [EmailAttachment]

    /// Initialize an instance of `EmailMessageWithBody`.
    public init(id: String, body: String, attachments: [EmailAttachment], inlineAttachments: [EmailAttachment]) {
        self.id = id
        self.body = body
        self.attachments = attachments
        self.inlineAttachments = inlineAttachments
    }
}
