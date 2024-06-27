//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoNotificationExtension

/// Representation of an Sudo Platform Email service messageReceived notification
public struct EmailMessageReceivedNotification: SudoNotification, Equatable {
    // MARK: - Conformance

    public let serviceName = Constants.serviceName
    public let type: String = EmailServiceNotificationType.messageReceived.rawValue
    
    // MARK: - messageReceived

    /// ID of the owner (subject) of the email address to which the notification pertains
    public let owner: String

    /// ID of the email address to which the notification pertains
    public let emailAddressId: String

    /// ID of the Sudo owner of the email address to which the notification pertains
    public let sudoId: String

    /// ID of the message to which the notification pertains
    public let messageId: String

    /// ID of the folder in which the message to which the notification pertains is stored
    public let folderId: String

    /// Encryption status of the message to which the notification pertains
    public let encryptionStatus: EncryptionStatus

    /// Subject, if any, of the message to which the notification pertains
    public let subject: String?

    /// Sender of the message to which the notification pertains
    public let from: EmailAddressAndName

    /// Reply-To address, if any, of the message to which the notification pertains
    public let replyTo: EmailAddressAndName?

    /// Whether or not the message to which the notification pertains has any attachments
    public let hasAttachments: Bool

    /// Date when the message to which the notification pertains was sent - the message's Date header
    public let sentAt: Date

    /// Date when the message to which the notification pertains was received
    public let receivedAt: Date
}
