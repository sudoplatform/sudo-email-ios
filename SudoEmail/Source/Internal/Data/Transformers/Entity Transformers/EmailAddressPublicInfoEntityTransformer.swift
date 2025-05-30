//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct EmailAddressPublicInfoEntityTransformer {

    // MARK: - Properties

    /// Utility for transforming the public key struct to the core layer equivalent.
    let publicKeyTransformer = PublicKeyEntityTransformer()

    // MARK: - Methods

    /// Transforms the success result of `LookupEmailAddressesPublicInfoQuery` from the service to a list of `EmailAddressPublicInfoEntity`.
    /// - Parameter data: Data returned from the success result of `LookupEmailAddressesPublicInfoQuery`.
    /// - Returns: A list of email address public info objects as entities.
    func transform(_ data: GraphQL.LookupEmailAddressesPublicInfoQuery.Data) -> [EmailAddressPublicInfoEntity] {
        return data.lookupEmailAddressesPublicInfo.items.map { item in
            let publicKeyDetails = publicKeyTransformer.transform(item.publicKeyDetails)
            return EmailAddressPublicInfoEntity(emailAddress: item.emailAddress, keyId: item.keyId, publicKeyDetails: publicKeyDetails)
        }
    }
}
