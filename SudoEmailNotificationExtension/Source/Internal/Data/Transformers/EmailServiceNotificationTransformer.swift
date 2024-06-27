//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoNotificationExtension

extension EmailServiceNotification {

    /// Convert the raw representation of an email service notification to its public form
    func toSudoNotification() -> any SudoNotification {
        switch self {
        case .messageReceived(let decoded):
            return EmailMessageReceivedNotification(
                owner: decoded.owner,
                emailAddressId: decoded.emailAddressId,
                sudoId: decoded.sudoId,
                messageId: decoded.messageId,
                folderId: decoded.folderId,
                encryptionStatus: decoded.encryptionStatus,
                subject: decoded.subject,
                from: EmailAddressAndName(
                    address: decoded.from.emailAddress,
                    displayName: decoded.from.displayName
                ),
                replyTo: decoded.replyTo == nil ? nil : EmailAddressAndName(
                    address: decoded.replyTo!.emailAddress,
                    displayName: decoded.replyTo!.displayName
                ),
                hasAttachments: decoded.hasAttachments,
                sentAt: Date(timeIntervalSince1970: TimeInterval(decoded.sentAtEpochMs / 1000)),
                receivedAt: Date(timeIntervalSince1970: TimeInterval(decoded.receivedAtEpochMs / 1000)))

        case .unknown(let type):
            return EmailUnknownNotification(type: type)
        }
    }
}
