//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform blocked email address action entity to GraphQL data.
struct BlockedAddressActionGQLTransformer {

    /// Transform a `UnsealedBlockedAddress.BlockedAddressAction` into a `GraphQL.BlockedAddressAction`
    func transform(_ entity: UnsealedBlockedAddress.BlockedAddressAction) -> GraphQL.BlockedAddressAction {
        switch entity {
        case .drop:
            return .drop
        case .spam:
            return .spam
        }
    }
}
