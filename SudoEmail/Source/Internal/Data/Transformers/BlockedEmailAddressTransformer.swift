//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoKeyManager

/// Utility class to transform data received from graphQL to the Core/Entity level of the SDK
struct BlockedEmailAddressTransformer {
    
    let deviceKeyWorker: DeviceKeyWorker!
    
    init(deviceKeyWorker: DeviceKeyWorker) {
        self.deviceKeyWorker = deviceKeyWorker
    }
    
    func transform(_ data: GraphQL.GetEmailAddressBlocklistQuery.Data.GetEmailAddressBlocklist.BlockedAddress) throws -> UnsealedBlockedAddress {
        if (self.deviceKeyWorker.keyExists(keyId: data.sealedValue.keyId, keyType: KeyType.symmetricKey)){
            var address = ""
            do {
                address = try self.deviceKeyWorker.unsealString(
                    data.sealedValue.base64EncodedSealedData,
                    withKeyId: data.sealedValue.keyId,
                    algorithm: data.sealedValue.algorithm
                )
            } catch {
                return UnsealedBlockedAddress(
                    hashedBlockedValue: data.hashedBlockedValue,
                    address: "",
                    status: UnsealedBlockedAddress.UnsealedBlockedAddressStatus.failed(cause: SudoEmailError.decodingError)
                )
            }
            return UnsealedBlockedAddress(
                hashedBlockedValue: data.hashedBlockedValue,
                address: address,
                status: UnsealedBlockedAddress.UnsealedBlockedAddressStatus.completed
            )
        } else {
             return UnsealedBlockedAddress(
                hashedBlockedValue: data.hashedBlockedValue,
                address: "",
                status: UnsealedBlockedAddress.UnsealedBlockedAddressStatus.failed(cause: SudoEmailError.keyNotFound)
            )
        }
    }
}
