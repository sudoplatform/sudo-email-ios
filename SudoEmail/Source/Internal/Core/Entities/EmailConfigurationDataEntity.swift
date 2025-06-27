//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of configuration data.
struct EmailConfigurationDataEntity {

    /// The number of email messages that can be deleted at a time.
    var deleteEmailMessagesLimit: Int

    /// The number of email messages that can be updated at a time.
    var updateEmailMessagesLimit: Int

    /// The maximum allowed size of an inbound email message.
    var emailMessageMaxInboundMessageSize: Int

    /// The maximum allowed size of an outbound email message.
    var emailMessageMaxOutboundMessageSize: Int

    /// The maximum number of recipients for an out-of-network email message.
    var emailMessageRecipientsLimit: Int

    /// The maximum number of recipients for an in-network encrypted email message.
    var encryptedEmailMessageRecipientsLimit: Int

    /// The set of file extensions which are prohibited from being sent as attachments
    var prohibitedFileExtensions: [String]
}
