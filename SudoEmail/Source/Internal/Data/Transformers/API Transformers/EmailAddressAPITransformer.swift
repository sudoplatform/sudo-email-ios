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
        let id = entity.id
        let userId = entity.userId
        let sudoId = entity.sudoId
        let identityId = entity.identityId
        let emailAddress = entity.emailAddress.address
        let owners = entity.owners.map(ownerTransformer.transform(_:))
        let created = entity.created
        let updated = entity.updated
        return EmailAddress(
            id: id,
            userId: userId,
            sudoId: sudoId,
            identityId: identityId,
            emailAddress: emailAddress,
            owners: owners,
            created: created,
            updated: updated
        )
    }
}
