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

    /// Whether or not email aliases are enabled in this environment. The base level of
    /// alias functionality permits aliasing an internal (in-network) email address.
    var emailAliasesEnabled: Bool

    /// Whether or not external email aliases are enabled in this environment. The above
    /// emailAliasesEnabled setting must be true in order for the additional functionality
    /// of external aliases to be available.
    var externalEmailAliasesEnabled: Bool

    /// Whether or not a user can provision an email address/alias that they have previously deprovisioned
    var allowOwnerEmailAddressReuse: Bool
}
