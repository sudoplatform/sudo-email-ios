//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform entities from the Core level to output results of the SDK.
struct EmailAddressAPITransformer {

    /// Utility for transforming addresses to `Owner`.
    let ownerTransformer = OwnerAPITransformer()

    func transform(_ entity: EmailAccountEntity?) -> EmailAddress? {
        guard let entity = entity else {
            return nil
        }
        return transform(entity)
    }

    /// Transform a `EmailAccountEntity` to a `EmailAddress`.
    /// - Parameter entity: Entity to be transformed.
    /// - Returns: Output result.
    func transform(_ entity: EmailAccountEntity) -> EmailAddress {
        let owner = entity.owner
        let owners = entity.owners.map(ownerTransformer.transform(_:))
        let address = entity.emailAddress.address
        let created = entity.created
        let updated = entity.updated
        return EmailAddress(
            address: address,
            owner: owner,
            owners: owners,
            created: created,
            updated: updated
        )
    }
}
