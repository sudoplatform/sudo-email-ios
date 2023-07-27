//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform entities from the Core level to output results of the SDK.
struct EmailAddressAPITransformer {

    /// Utility for transforming addresses to `Owner`.
    let ownerTransformer = OwnerAPITransformer()

    /// Utility for transforming folders to/from `EmailFolderEntity`
    let folderTransformer = EmailFolderEntityTransformer()

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
        let owner = entity.owner
        let owners = entity.owners.map(ownerTransformer.transform(_:))
        let keyRingId = entity.keyRingId
        let keyIds = entity.keyIds
        let identityId = entity.identityId
        let emailAddress = entity.emailAddress.emailAddress
        let folders = entity.folders.map(folderTransformer.transform(_:))
        let size = entity.size
        let version = entity.version
        let createdAt = entity.createdAt
        let updatedAt = entity.updatedAt
        let lastReceivedAt = entity.lastReceivedAt
        return EmailAddress(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            keyIds: keyIds,
            emailAddress: emailAddress,
            folders: folders,
            size: size,
            version: version,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastReceivedAt: lastReceivedAt,
            alias: entity.emailAddress.alias
        )
    }
}
