//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct PublicKeyEntityTransformer {

    // MARK: - Properties

    /// Utility for transforming the GraphQL key format enum to the core layer equivalent.
    let keyFormatTransformer = PublicKeyFormatEntityTransformer()

    // MARK: - Methods

    /// Transform the GraphQL public key entity to internal entity type `EmailAddressPublicInfoEntity`.
    /// - Parameter data: GraphQL entity to be transformed.
    /// - Returns: Internal email address public key entity.
    func transform(
        _ data: GraphQL.LookupEmailAddressesPublicInfoQuery.Data.LookupEmailAddressesPublicInfo.Item.PublicKeyDetail
    ) -> EmailAddressPublicKeyEntity {
        let keyFormat = keyFormatTransformer.transform(data.keyFormat)
        return EmailAddressPublicKeyEntity(publicKey: data.publicKey, keyFormat: keyFormat, algorithm: data.algorithm)
    }
}
