//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform entities from the Core level to output results of the SDK.
struct PublicKeyFormatAPITransformer {

    /// Transform the entity type`EmailAddressPublicInfo` to API type `EmailAddressPublicInfoEntity`.
    /// - Parameter data: Entity to be transformed.
    /// - Returns: The public entity representation a public key format.
    func transform(_ data: PublicKeyFormatEntity) -> PublicKeyFormat {
        switch data {
        case .rsaPublicKey:
            return .rsaPublicKey
        case .spki:
            return .spki
        }
    }
}
