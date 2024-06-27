//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import XCTest
@testable import SudoEmailNotificationExtension

final class EmailServiceNotificationTests: XCTestCase {

    // MARK: - EmailServiceNotification

    func testCorrectlyDeserialisesMessageReceivedNotification() throws {
        let expected = MessageReceivedNotification(
            type: "messageReceived",
            owner: "d4bc1a13-688c-4408-9103-d84880bcdd7a",
            emailAddressId: "em-add-015693d2-1631-4361-9e5e-10496a80c053",
            sudoId: "200c5580-1867-4116-a7f0-458fe9b3c6ea",
            messageId: "em-msg-d55835d9-be6c-4dc4-b02a-209cd9a04dfa",
            folderId: "em-add-015693d2-1631-4361-9e5e-10496a80c053-INBOX",
            encryptionStatus: EncryptionStatus.UNENCRYPTED,
            subject: "WTF?",
            from: NotificationEmailAddressAndName(emailAddress: "tbartley@anonyome.com", displayName: "Tim Bartley"),
            replyTo: nil,
            hasAttachments: false,
            sentAtEpochMs: 1718330537000,
            receivedAtEpochMs: 1718330541336
        )
        let json = """
        {
            "type":"\(expected.type)",
            "owner":"\(expected.owner)",
            "emailAddressId":"\(expected.emailAddressId)",
            "messageId":"\(expected.messageId)",
            "folderId":"\(expected.folderId)",
            "encryptionStatus":"\(expected.encryptionStatus)",
            "subject":"\(expected.subject!)",
            "from":{"displayName":"\(expected.from.displayName!)","emailAddress":"\(expected.from.emailAddress)"},
            "hasAttachments":\(expected.hasAttachments),
            "sentAtEpochMs":\(expected.sentAtEpochMs),
            "receivedAtEpochMs":\(expected.receivedAtEpochMs),
            "sudoId":"\(expected.sudoId)"
        }
        """

        let decoder = JSONDecoder()

        let decoded = try decoder.decode(EmailServiceNotification.self, from: json.data(using: .utf8)!)
        guard case .messageReceived(let decoded) = decoded else {
            return XCTFail("decoded notification is not a MessageReceivedNotification")
        }
        XCTAssertEqual(decoded, expected)
    }

    func testCorrectlyDeserialisesMessageReceivedNotificationWithDifferentOptionalProperties() throws {
        let expected = MessageReceivedNotification(
            type: "messageReceived",
            owner: "d4bc1a13-688c-4408-9103-d84880bcdd7a",
            emailAddressId: "em-add-015693d2-1631-4361-9e5e-10496a80c053",
            sudoId: "200c5580-1867-4116-a7f0-458fe9b3c6ea",
            messageId: "em-msg-d55835d9-be6c-4dc4-b02a-209cd9a04dfa",
            folderId: "em-add-015693d2-1631-4361-9e5e-10496a80c053-INBOX",
            encryptionStatus: EncryptionStatus.UNENCRYPTED,
            subject: nil,
            from: NotificationEmailAddressAndName(emailAddress: "tbartley@anonyome.com", displayName: nil),
            replyTo: NotificationEmailAddressAndName(emailAddress: "tbartley@sudomail.biz", displayName: "Tim Bartley (Work)"),
            hasAttachments: false,
            sentAtEpochMs: 1718330537000,
            receivedAtEpochMs: 1718330541336
        )
        let json = """
    {
        "type":"\(expected.type)",
        "owner":"\(expected.owner)",
        "emailAddressId":"\(expected.emailAddressId)",
        "messageId":"\(expected.messageId)",
        "folderId":"\(expected.folderId)",
        "encryptionStatus":"\(expected.encryptionStatus)",
        "from":{"emailAddress":"\(expected.from.emailAddress)"},
        "replyTo":{"displayName":"\(expected.replyTo!.displayName!)","emailAddress":"\(expected.replyTo!.emailAddress)"},
        "hasAttachments":\(expected.hasAttachments),
        "sentAtEpochMs":\(expected.sentAtEpochMs),
        "receivedAtEpochMs":\(expected.receivedAtEpochMs),
        "sudoId":"\(expected.sudoId)"
    }
    """

        let decoder = JSONDecoder()

        let decoded = try decoder.decode(EmailServiceNotification.self, from: json.data(using: .utf8)!)
        guard case .messageReceived(let decoded) = decoded else {
            return XCTFail("decoded notification is not a MessageReceivedNotification")
        }
        XCTAssertEqual(decoded, expected)
    }

    func testDeserialisesUnknownNotification() throws {
        let expected = "unknown"

        let json = """
        {
            "type":"\(expected)",
            "owner":"some-ownr",
            "some":"property"
        }
        """

        let decoder = JSONDecoder()

        let decoded = try decoder.decode(EmailServiceNotification.self, from: json.data(using: .utf8)!)
        guard case .unknown(let decoded) = decoded else {
            return XCTFail("decoded notification is not an EmailUnknownNotification")
        }

        XCTAssertEqual(decoded, expected)
    }
}
