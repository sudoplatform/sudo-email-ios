//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
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

    public init(
        deleteEmailMessagesLimit: Int,
        updateEmailMessagesLimit: Int,
        emailMessageMaxInboundMessageSize: Int,
        emailMessageMaxOutboundMessageSize: Int,
        emailMessageRecipientsLimit: Int,
        encryptedEmailMessageRecipientsLimit: Int
    ) {
        self.deleteEmailMessagesLimit = deleteEmailMessagesLimit
        self.updateEmailMessagesLimit = updateEmailMessagesLimit
        self.emailMessageMaxInboundMessageSize = emailMessageMaxInboundMessageSize
        self.emailMessageMaxOutboundMessageSize = emailMessageMaxOutboundMessageSize
        self.emailMessageRecipientsLimit = emailMessageRecipientsLimit
        self.encryptedEmailMessageRecipientsLimit = encryptedEmailMessageRecipientsLimit
    }
}
