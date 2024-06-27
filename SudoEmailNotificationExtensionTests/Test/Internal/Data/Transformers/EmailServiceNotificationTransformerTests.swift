//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

import Foundation
import XCTest
@testable import SudoEmailNotificationExtension

final class EmailServiceNotificationTransformerTests: XCTestCase {
    // MARK: - toSudoNotification: messageReceived

    func testTransformsMessageReceivedNotificationWithNilOptionals() {
        let expected = EmailMessageReceivedNotification(
            owner: "owner",
            emailAddressId: "email-address-id",
            sudoId: "sudo-id",
            messageId: "message-id",
            folderId: "folder-id",
            encryptionStatus: EncryptionStatus.ENCRYPTED,
            subject: nil,
            from: EmailAddressAndName(address: "email@address.com"),
            replyTo: nil,
            hasAttachments: true,
            sentAt: Date.init(timeIntervalSince1970: TimeInterval(1000)),
            receivedAt: Date.init(timeIntervalSince1970: TimeInterval(2000))
        )

        let messageReceived = MessageReceivedNotification(
            type: "messageReceived",
            owner: expected.owner,
            emailAddressId: expected.emailAddressId,
            sudoId: expected.sudoId,
            messageId: expected.messageId,
            folderId: expected.folderId,
            encryptionStatus: EncryptionStatus.ENCRYPTED,
            subject: nil,
            from: NotificationEmailAddressAndName(emailAddress: expected.from.address),
            replyTo: nil,
            hasAttachments: expected.hasAttachments,
            sentAtEpochMs: Int(expected.sentAt.timeIntervalSince1970) * 1000,
            receivedAtEpochMs: Int(expected.receivedAt.timeIntervalSince1970) * 1000
        )

        let input = EmailServiceNotification.messageReceived(messageReceived)
        let actual = input.toSudoNotification()
        guard let actual = actual as? EmailMessageReceivedNotification else {
            return XCTFail("Transformed notification is not an EmailMessageReceivedNotification")
        }

        XCTAssertEqual(actual, expected)
    }

    func testTransformsMessageReceivedNotificationWithNonNilOptionals() {
        let expected = EmailMessageReceivedNotification(
            owner: "owner",
            emailAddressId: "email-address-id",
            sudoId: "sudo-id",
            messageId: "message-id",
            folderId: "folder-id",
            encryptionStatus: EncryptionStatus.ENCRYPTED,
            subject: "subject",
            from: EmailAddressAndName(address: "email@address.com", displayName: "Email At Address.Com"),
            replyTo: EmailAddressAndName(address: "reply-to@address.com", displayName: "Reply-To At Address.Com"),
            hasAttachments: true,
            sentAt: Date.init(timeIntervalSince1970: TimeInterval(1000)),
            receivedAt: Date.init(timeIntervalSince1970: TimeInterval(2000))
        )

        let messageReceived = MessageReceivedNotification(
            type: "messageReceived",
            owner: expected.owner,
            emailAddressId: expected.emailAddressId,
            sudoId: expected.sudoId,
            messageId: expected.messageId,
            folderId: expected.folderId,
            encryptionStatus: EncryptionStatus.ENCRYPTED,
            subject: expected.subject,
            from: NotificationEmailAddressAndName(
                emailAddress: expected.from.address,
                displayName: expected.from.displayName
            ),
            replyTo: NotificationEmailAddressAndName(
                emailAddress: expected.replyTo!.address,
                displayName: expected.replyTo!.displayName
            ),
            hasAttachments: expected.hasAttachments,
            sentAtEpochMs: Int(expected.sentAt.timeIntervalSince1970) * 1000,
            receivedAtEpochMs: Int(expected.receivedAt.timeIntervalSince1970) * 1000
        )

        let input = EmailServiceNotification.messageReceived(messageReceived)
        let actual = input.toSudoNotification()
        guard let actual = actual as? EmailMessageReceivedNotification else {
            return XCTFail("Transformed notification is not an EmailMessageReceivedNotification")
        }

        XCTAssertEqual(actual, expected)
    }

    // MARK: - toSudoNotification: unknown

    func testTransformsUnknownNotification() {
        let expected = EmailUnknownNotification(type: "unknown")

        let input = EmailServiceNotification.unknown(expected.type)

        let actual = input.toSudoNotification()
        guard let actual = actual as? EmailUnknownNotification else {
            return XCTFail("Transformed notification is not an EmailUnknownNotification")
        }

        XCTAssertEqual(actual, expected)
    }
}
