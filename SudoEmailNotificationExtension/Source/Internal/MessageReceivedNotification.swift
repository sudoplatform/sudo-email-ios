//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of decrypted raw JSON payload of a messageReceived notification
struct MessageReceivedNotification: Decodable, Equatable {
    /// Notification type (will always be "messageReceived")
    let type: String

    /// ID of the owner (subject) of the email address to which the notification pertains
    let owner: String

    /// ID of the email address to which the notification pertains
    let emailAddressId: String

    /// ID of the Sudo owner of the email address to which the notification pertains
    let sudoId: String

    /// ID of the message to which the notification pertains
    let messageId: String

    /// ID of the folder in which the message to which the notification pertains is stored
    let folderId: String

    /// Encryption status of the message to which the notification pertains
    let encryptionStatus: EncryptionStatus

    /// Subject, if any, of the message to which the notification pertains
    let subject: String?

    /// Sender of the message to which the notification pertains
    let from: NotificationEmailAddressAndName

    /// Reply-To address, if any, of the message to which the notification pertains
    let replyTo: NotificationEmailAddressAndName?

    /// Whether or not the message to which the notification pertains has any attachments
    let hasAttachments: Bool

    /// Millseconds since epoch when the message to which the notification pertains was sent - the message's Date header
    let sentAtEpochMs: Int

    /// Millseconds since epoch when the message to which the notification pertains was received
    let receivedAtEpochMs: Int
}
