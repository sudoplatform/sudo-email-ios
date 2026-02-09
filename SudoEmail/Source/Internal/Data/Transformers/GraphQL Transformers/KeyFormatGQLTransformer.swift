//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform key format entity data to the GraphQL data.
struct KeyFormatGQLTransformer {

    /// Transform a `PublicKeyFormatEntity` into a GraphQL `KeyFormat`.
    func transform(_ entity: PublicKeyFormatEntity) -> GraphQL.KeyFormat {
        switch entity {
        case .rsaPublicKey:
            return .rsaPublicKey
        case .spki:
            return .spki
        }
    }
}
