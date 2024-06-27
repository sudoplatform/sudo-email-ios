//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import XCTest
@testable import SudoEmailNotificationExtension

final class SudoEmailNotifiableClientTests: XCTestCase {

    // MARK: - decode

    let mockDeviceKeyWorker = MockExtensionDeviceKeyWorker()

    var iut: DefaultSudoEmailNotifiableClient!

    override func setUp() async throws {
        iut = DefaultSudoEmailNotifiableClient(
            deviceKeyWorker: mockDeviceKeyWorker,
            logger: .emailSDKLogger
        )
    }

    func testShouldReturnUnknownNotificationWithServiceTypeIfPayloadIsNotSealedNotification() throws {
        let decoded = iut.decode(data:"jibberish")

        guard let decoded = decoded as? EmailUnknownNotification else {
            return XCTFail("decoded notification is not an EmailUnknownNotification")
        }

        let expected = EmailUnknownNotification(type: Constants.serviceName)
        XCTAssertEqual(decoded, expected)
    }

    func testShouldReturnUnknownNotificationWithDecodedTypeIfUnsealingFails() throws {
        let type = "some-type"

        let sealedNotification = """
        {
          "keyId":"key-id",
          "algorithm":"algorithm",
          "type":"\(type)",
          "sealed":"sealed-data"
        }
        """

        mockDeviceKeyWorker.unsealStringError = AnyError("unseal failed")

        let decoded = iut.decode(data: sealedNotification)

        guard let decoded = decoded as? EmailUnknownNotification else {
            return XCTFail("decoded notification is not an EmailUnknownNotification")
        }

        let expected = EmailUnknownNotification(type: type)
        XCTAssertEqual(decoded, expected)
        XCTAssertEqual(1, mockDeviceKeyWorker.unsealStringCallCount)
    }

    func testShouldReturnUnknownNotificationWithDecodedTypeIfUnsealedDataDecodingFails() throws {
        let type = "some-type"

        let sealedNotification = """
        {
          "keyId":"key-id",
          "algorithm":"algorithm",
          "type":"\(type)",
          "sealed":"sealed-data"
        }
        """

        mockDeviceKeyWorker.unsealStringResult = "unsealed-data"

        let decoded = iut.decode(data: sealedNotification)

        guard let decoded = decoded as? EmailUnknownNotification else {
            return XCTFail("decoded notification is not an EmailUnknownNotification")
        }

        let expected = EmailUnknownNotification(type: type)
        XCTAssertEqual(decoded, expected)
        XCTAssertEqual(1, mockDeviceKeyWorker.unsealStringCallCount)
    }

    func testShouldReturnUnknownNotificationWithDecodedTypeIfUnsealedDataDecodesToUnknownNotification() throws {
        let type = "some-type"

        let sealedNotification = """
        {
          "keyId":"key-id",
          "algorithm":"algorithm",
          "type":"\(type)",
          "sealed":"sealed-data"
        }
        """

        mockDeviceKeyWorker.unsealStringResult = """
        {
          "type":"\(type)"
        }
        """

        let decoded = iut.decode(data: sealedNotification)

        guard let decoded = decoded as? EmailUnknownNotification else {
            return XCTFail("decoded notification is not an EmailUnknownNotification")
        }

        let expected = EmailUnknownNotification(type: type)
        XCTAssertEqual(decoded, expected)
        XCTAssertEqual(1, mockDeviceKeyWorker.unsealStringCallCount)
    }

    func testShouldReturnEmailMessageReceivedNotificationWithDecodedTypeIfUnsealedDataDecodesToMessageReceivedNotification() throws {
        let type = "messageReceived"

        let sealedNotification = """
        {
          "keyId":"key-id",
          "algorithm":"algorithm",
          "type":"\(type)",
          "sealed":"sealed-data"
        }
        """

        let internalMessage = MessageReceivedNotification(
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
            "type":"\(internalMessage.type)",
            "owner":"\(internalMessage.owner)",
            "emailAddressId":"\(internalMessage.emailAddressId)",
            "messageId":"\(internalMessage.messageId)",
            "folderId":"\(internalMessage.folderId)",
            "encryptionStatus":"\(internalMessage.encryptionStatus)",
            "subject":"\(internalMessage.subject!)",
            "from":{"displayName":"\(internalMessage.from.displayName!)","emailAddress":"\(internalMessage.from.emailAddress)"},
            "hasAttachments":\(internalMessage.hasAttachments),
            "sentAtEpochMs":\(internalMessage.sentAtEpochMs),
            "receivedAtEpochMs":\(internalMessage.receivedAtEpochMs),
            "sudoId":"\(internalMessage.sudoId)"
        }
        """

        mockDeviceKeyWorker.unsealStringResult = json
        let decoded = iut.decode(data: sealedNotification)

        guard let decoded = decoded as? EmailMessageReceivedNotification else {
            return XCTFail("decoded notification is not an EmailMessageReceivedNotification")
        }

        let expected = EmailServiceNotification.messageReceived(internalMessage).toSudoNotification() as! EmailMessageReceivedNotification

        XCTAssertEqual(decoded, expected)
        XCTAssertEqual(1, mockDeviceKeyWorker.unsealStringCallCount)
    }
}
