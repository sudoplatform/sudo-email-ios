//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of email configuration data in Platform SDK.
public struct ConfigurationData: Equatable {

    /// The number of email messages that can be deleted at a time.
    public var deleteEmailMessagesLimit: Int

    /// The number of email messages that can be updated at a time.
    public var updateEmailMessagesLimit: Int

    /// The maximum allowed size of an inbound email message.
    public var emailMessageMaxInboundMessageSize: Int

    /// The maximum allowed size of an outbound email message.
    public var emailMessageMaxOutboundMessageSize: Int

    /// The maximum number of recipients for an out-of-network email message.
    public var emailMessageRecipientsLimit: Int

    /// The maximum number of recipients for an in-network encrypted email message.
    public var encryptedEmailMessageRecipientsLimit: Int

    /// The set of file extensions not permitted to be sent as attachments
    public var prohibitedFileExtensions: [String]

    /// Whether or not email masks are enabled in this environment. The basic level of support
    /// for masked emails allows masking internal (in-network) addresses only.
    public var emailMasksEnabled: Bool

    /// Whether or not external email masks are enabled in this environment. The above emailMasksEnabled
    /// value must be true in order to permit the additional functionality of using external
    /// addresses as masked destinations.
    public var externalEmailMasksEnabled: Bool

    public init(
        deleteEmailMessagesLimit: Int,
        updateEmailMessagesLimit: Int,
        emailMessageMaxInboundMessageSize: Int,
        emailMessageMaxOutboundMessageSize: Int,
        emailMessageRecipientsLimit: Int,
        encryptedEmailMessageRecipientsLimit: Int,
        prohibitedFileExtensions: [String] = [],
        emailMasksEnabled: Bool,
        externalEmailMasksEnabled: Bool
    ) {
        self.deleteEmailMessagesLimit = deleteEmailMessagesLimit
        self.updateEmailMessagesLimit = updateEmailMessagesLimit
        self.emailMessageMaxInboundMessageSize = emailMessageMaxInboundMessageSize
        self.emailMessageMaxOutboundMessageSize = emailMessageMaxOutboundMessageSize
        self.emailMessageRecipientsLimit = emailMessageRecipientsLimit
        self.encryptedEmailMessageRecipientsLimit = encryptedEmailMessageRecipientsLimit
        self.prohibitedFileExtensions = prohibitedFileExtensions
        self.emailMasksEnabled = emailMasksEnabled
        self.externalEmailMasksEnabled = externalEmailMasksEnabled
    }
}
