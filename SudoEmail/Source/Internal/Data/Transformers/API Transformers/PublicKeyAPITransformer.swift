//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform entities from the Core level to output results of the SDK.
struct PublicKeyAPITransformer {

    // MARK: - Properties

    /// Utility for transforming the core layer public key format enum to the public equivalent.
    let keyFormatTransformer = PublicKeyFormatAPITransformer()

    // MARK: - Methods

    /// Transform the entity type`EmailAddressPublicKeyEntity` to API type `EmailAddressPublicKey`.
    /// - Parameter data: Entity to be transformed.
    /// - Returns: Email address public key object as an entity.
    func transform(_ data: EmailAddressPublicKeyEntity) -> EmailAddressPublicKey {
        let keyFormat = keyFormatTransformer.transform(data.keyFormat)
        return EmailAddressPublicKey(publicKey: data.publicKey, keyFormat: keyFormat, algorithm: data.algorithm)
    }
}
