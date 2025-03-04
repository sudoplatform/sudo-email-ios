//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform entities from the Core level to output results of the SDK.
struct EmailFolderAPITransformer {

    /// Utility for transforming addresses to `Owner`.
    let ownerTransformer = OwnerAPITransformer()

    func transform(_ entity: EmailFolderEntity?) -> EmailFolder? {
        guard let entity = entity else {
            return nil
        }
        return transform(entity)
    }

    /// Transform an `EmailFolderEntity` to an `EmailFolder`.
    /// - Parameter entity: Entity to be transformed.
    /// - Returns: The EmailFolderEntity transformed to an EmailFolder.
    func transform(_ entity: EmailFolderEntity) -> EmailFolder {
        let id = entity.id
        let owner = entity.owner
        let owners = entity.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = entity.emailAddressId
        let folderName = entity.folderName
        let size = entity.size
        let unseenCount = entity.unseenCount
        let ttl = entity.ttl
        let version = entity.version
        let createdAt = entity.createdAt
        let updatedAt = entity.updatedAt
        let customFolderName = entity.customFolderName
        return EmailFolder(
            id: id,
            owner: owner,
            owners: owners,
            emailAddressId: emailAddressId,
            folderName: folderName,
            size: size,
            unseenCount: unseenCount,
            ttl: ttl,
            version: version,
            createdAt: createdAt,
            updatedAt: updatedAt,
            customFolderName: customFolderName
        )
    }
}
