//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

struct BlockedEmailAddressActionTransformer {

    /// Transform a `GraphQL.BlockedAddressAction` into a `UnsealedBlockedAddress.BlockedAddressAction`

    func transform(_ data: GraphQL.BlockedAddressAction?) -> UnsealedBlockedAddress.BlockedAddressAction {
        switch data {
        case .spam:
            return .spam
        case .drop, .none, .unknown:
            return .drop
        }
    }
}
