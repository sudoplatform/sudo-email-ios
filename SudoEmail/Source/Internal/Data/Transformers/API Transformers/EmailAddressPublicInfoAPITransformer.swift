//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform entities from the Core level to output results of the SDK.
struct EmailAddressPublicInfoAPITransformer {

    /// Transform the entity type`EmailAddressPublicInfo` to API type `EmailAddressPublicInfoEntity`.
    /// - Parameter data: Entity to be transformed.
    /// - Returns: Email address public info object as an entity.
    func transform(_ data: EmailAddressPublicInfoEntity) -> EmailAddressPublicInfo {
        return EmailAddressPublicInfo(emailAddress: data.emailAddress, keyId: data.keyId, publicKey: data.publicKey)
    }

    /// Transform a list of entity type`EmailAddressPublicInfoEntit` to list of API type `EmailAddressPublicInfo`.
    /// - Parameter data: List of entities to be transformed.
    /// - Returns: List of email address public info API objects.
    func transform(_ data: [EmailAddressPublicInfoEntity]) -> [EmailAddressPublicInfo] {
        return data.map(transform(_:))
    }
}
