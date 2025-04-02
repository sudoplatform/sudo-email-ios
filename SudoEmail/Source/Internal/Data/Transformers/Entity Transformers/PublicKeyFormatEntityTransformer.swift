//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct PublicKeyFormatEntityTransformer {

    /// Transform the GraphQL public key format representation to internal entity type `EmailAddressPublicInfoEntity`.
    /// - Parameter data: Optional GraphQL key format to be transformed.
    /// - Returns: Internal key format entity.
    func transform(_ data: GraphQL.KeyFormat?) -> PublicKeyFormatEntity {
        switch data {
        case .rsaPublicKey:
            return .rsaPublicKey
        case .spki:
            return .spki
        case .unknown, .none:
            return .rsaPublicKey
        }
    }
}
