//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

class DefaultEmailMessageUnsealerService: EmailMessageUnsealerService {

    // MARK: - Properties

    var deviceKeyWorker: DeviceKeyWorker

    // MARK: - Lifecycle

    init(deviceKeyWorker: DeviceKeyWorker) {
        self.deviceKeyWorker = deviceKeyWorker
    }

    // MARK: - EmailMessageUnsealer

    func unsealEmailMessage(_ message: SealedEmailMessageEntity) throws -> EmailMessageEntity {
        let keyId = message.keyId
        let algorithm = message.algorithm

        do {
            let unsealedRFC822Header = try deviceKeyWorker.unsealString(message.rfc822Header, withKeyId: keyId, algorithm: algorithm)
            let headers = try EmailRFC822HeaderCodec().decode(header: unsealedRFC822Header)
            let emailMessageEntity = EmailMessageEntity(
                id: message.id,
                owner: message.owner,
                owners: message.owners,
                emailAddressId: message.emailAddressId,
                keyId: message.keyId,
                folderId: message.folderId,
                previousFolderId: message.previousFolderId,
                seen: message.seen,
                direction: message.direction,
                state: message.state,
                clientRefId: message.clientRefId,
                sortDate: message.sortDate,
                createdAt: message.createdAt,
                updatedAt: message.updatedAt,
                from: headers.from.map { EmailAddressEntity(emailAddress: $0.emailAddress, displayName: $0.displayName) },
                replyTo: headers.replyTo.map { EmailAddressEntity(emailAddress: $0.emailAddress, displayName: $0.displayName) },
                to: headers.to.map { EmailAddressEntity(emailAddress: $0.emailAddress, displayName: $0.displayName) },
                cc: headers.cc.map { EmailAddressEntity(emailAddress: $0.emailAddress, displayName: $0.displayName) },
                bcc: headers.bcc.map { EmailAddressEntity(emailAddress: $0.emailAddress, displayName: $0.displayName) },
                subject: headers.subject,
                hasAttachments: headers.hasAttachments ?? false,
                version: message.version,
                size: message.size
            )
            return emailMessageEntity
        } catch {
            throw SudoEmailError.internalError("Failed to unseal email message (ID: \(message.id), Key ID: \(keyId)")
        }
    }

    func unsealEmailMessageRFC822Data(_ data: Data, withKeyId keyId: String, algorithm: String) throws -> Data {
        guard let stringData = String(data: data, encoding: .utf8) else {
            throw SudoEmailError.internalError("Unable to decode received sealed RFC822 email message data")
        }
        let unsealedString = try deviceKeyWorker.unsealString(stringData, withKeyId: keyId, algorithm: algorithm)
        guard let unsealedData = unsealedString.data(using: .utf8) else {
            throw SudoEmailError.internalError("Unable to encode unsealed RFC822 email message data")
        }
        return unsealedData
    }

    // MARK: - Helpers

    func unsealEmailAddress(_ sealedEmailAddress: String, withKeyId keyId: String, algorithm: String) throws -> EmailAddressEntity {
        let addressString = try deviceKeyWorker.unsealString(sealedEmailAddress, withKeyId: keyId, algorithm: algorithm)
        let transformer = EmailAddressEntityTransformer()
        let address = try transformer.transform(addressString, alias: nil)
        return address
    }
}
