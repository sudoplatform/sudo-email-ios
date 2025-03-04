//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoKeyManager

/// Utility class to transform data received from graphQL to the Core/Entity level of the SDK
struct BlockedEmailAddressTransformer {

    let deviceKeyWorker: DeviceKeyWorker!

    let blockedEmailAddressActionTransformer = BlockedEmailAddressActionTransformer()

    init(deviceKeyWorker: DeviceKeyWorker) {
        self.deviceKeyWorker = deviceKeyWorker
    }

    func transform(_ data: GraphQL.GetEmailAddressBlocklistQuery.Data.GetEmailAddressBlocklist.BlockedAddress) throws -> UnsealedBlockedAddress {
        if deviceKeyWorker.keyExists(keyId: data.sealedValue.keyId, keyType: KeyType.symmetricKey) {
            var address = ""
            do {
                address = try deviceKeyWorker.unsealString(
                    data.sealedValue.base64EncodedSealedData,
                    withKeyId: data.sealedValue.keyId,
                    algorithm: data.sealedValue.algorithm
                )
            } catch {
                return UnsealedBlockedAddress(
                    hashedBlockedValue: data.hashedBlockedValue,
                    address: "",
                    action: blockedEmailAddressActionTransformer.transform(data.action),
                    status: UnsealedBlockedAddress.UnsealedBlockedAddressStatus.failed(cause: SudoEmailError.decodingError),
                    emailAddressId: data.emailAddressId
                )
            }
            return UnsealedBlockedAddress(
                hashedBlockedValue: data.hashedBlockedValue,
                address: address,
                action: blockedEmailAddressActionTransformer.transform(data.action),
                status: UnsealedBlockedAddress.UnsealedBlockedAddressStatus.completed,
                emailAddressId: data.emailAddressId
            )
        } else {
            return UnsealedBlockedAddress(
                hashedBlockedValue: data.hashedBlockedValue,
                address: "",
                action: blockedEmailAddressActionTransformer.transform(data.action),
                status: UnsealedBlockedAddress.UnsealedBlockedAddressStatus.failed(cause: SudoEmailError.keyNotFound),
                emailAddressId: data.emailAddressId
            )
        }
    }
}
