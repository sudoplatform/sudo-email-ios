//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
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

    /// Whether or not email masks are enabled in this environment. The base level of
    /// mask functionality permits masking an internal (in-network) email address.
    var emailMasksEnabled: Bool

    /// Whether or not external email masks are enabled in this environment. The above
    /// emailMasksEnabled setting must be true in order for the additional functionality
    // of external masks to be available.
    var externalEmailMasksEnabled: Bool
}
