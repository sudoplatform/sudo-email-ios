//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
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

    public init(
        deleteEmailMessagesLimit: Int,
        updateEmailMessagesLimit: Int,
        emailMessageMaxInboundMessageSize: Int,
        emailMessageMaxOutboundMessageSize: Int
    ) {
        self.deleteEmailMessagesLimit = deleteEmailMessagesLimit
        self.updateEmailMessagesLimit = updateEmailMessagesLimit
        self.emailMessageMaxInboundMessageSize = emailMessageMaxInboundMessageSize
        self.emailMessageMaxOutboundMessageSize = emailMessageMaxOutboundMessageSize
    }
}
