//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform entities from the Core level to output results of the SDK.
struct EmailAddressPublicInfoAPITransformer {

    // MARK: - Properties

    /// Utility for transforming the core layer public key struct to the public equivalent.
    let publicKeyTransformer = PublicKeyAPITransformer()

    // MARK: - Methods

    /// Transform the entity type`EmailAddressPublicInfo` to API type `EmailAddressPublicInfoEntity`.
    /// - Parameter data: Entity to be transformed.
    /// - Returns: Email address public info object as an entity.
    func transform(_ data: EmailAddressPublicInfoEntity) -> EmailAddressPublicInfo {
        let publicKeyDetails = publicKeyTransformer.transform(data.publicKeyDetails)
        return EmailAddressPublicInfo(emailAddress: data.emailAddress, keyId: data.keyId, publicKeyDetails: publicKeyDetails)
    }

    /// Transform a list of entity type`EmailAddressPublicInfoEntity` to list of API type `EmailAddressPublicInfo`.
    /// - Parameter data: List of entities to be transformed.
    /// - Returns: List of email address public info API objects.
    func transform(_ data: [EmailAddressPublicInfoEntity]) -> [EmailAddressPublicInfo] {
        return data.map(transform(_:))
    }
}
