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
            let from = try message.from.map { try unsealEmailAddress($0, withKeyId: keyId, algorithm: algorithm) }
            let to = try message.to.map { try unsealEmailAddress($0, withKeyId: message.keyId, algorithm: message.algorithm) }
            let cc = try message.cc.map { try unsealEmailAddress($0, withKeyId: message.keyId, algorithm: message.algorithm) }
            let bcc = try message.bcc.map { try unsealEmailAddress($0, withKeyId: message.keyId, algorithm: message.algorithm) }
            let subject = try message.subject.map { try deviceKeyWorker.unsealString($0, withKeyId: keyId, algorithm: algorithm)}
            return EmailMessageEntity(
                id: message.id,
                keyId: keyId,
                algorithm: algorithm,
                sealedId: message.sealedId,
                clientRefId: message.clientRefId,
                owner: message.owner,
                created: message.created,
                updated: message.updated,
                accountAddress: message.accountAddress,
                seen: message.seen,
                direction: message.direction,
                state: message.state,
                from: from,
                to: to,
                cc: cc,
                bcc: bcc,
                subject: subject
            )
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
        let address = try transformer.transform(addressString)
        return address
    }
}
