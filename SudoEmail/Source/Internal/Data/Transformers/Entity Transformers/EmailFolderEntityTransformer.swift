//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct EmailFolderEntityTransformer {

    func transform(_ folder: GraphQL.ProvisionEmailAddressMutation.Data.ProvisionEmailAddress.Folder) -> EmailFolderEntity {
        let ownerTransformer = OwnerEntityTransformer()

        let id = folder.id
        let owner = folder.owner
        let owners = folder.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = folder.emailAddressId
        let folderName = folder.folderName
        let size = folder.size
        let unseenCount = Int(folder.unseenCount)
        let ttl = folder.ttl
        let version = folder.version
        let createdAt = Date(millisecondsSince1970: folder.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: folder.updatedAtEpochMs)
        return EmailFolderEntity(
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
            updatedAt: updatedAt
        )
    }

    func transform(_ folder: GraphQL.GetEmailAddressQuery.Data.GetEmailAddress.Folder) -> EmailFolderEntity {
        let ownerTransformer = OwnerEntityTransformer()

        let id = folder.id
        let owner = folder.owner
        let owners = folder.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = folder.emailAddressId
        let folderName = folder.folderName
        let size = folder.size
        let unseenCount = Int(folder.unseenCount)
        let ttl = folder.ttl
        let version = folder.version
        let createdAt = Date(millisecondsSince1970: folder.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: folder.updatedAtEpochMs)
        return EmailFolderEntity(
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
            updatedAt: updatedAt
        )
    }

    func transform(_ folder: GraphQL.ListEmailAddressesQuery.Data.ListEmailAddress.Item.Folder) -> EmailFolderEntity {
        let ownerTransformer = OwnerEntityTransformer()

        let id = folder.id
        let owner = folder.owner
        let owners = folder.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = folder.emailAddressId
        let folderName = folder.folderName
        let size = folder.size
        let unseenCount = Int(folder.unseenCount)
        let ttl = folder.ttl
        let version = folder.version
        let createdAt = Date(millisecondsSince1970: folder.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: folder.updatedAtEpochMs)
        return EmailFolderEntity(
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
            updatedAt: updatedAt
        )
    }

    func transform(
        _ folder: GraphQL.ListEmailAddressesForSudoIdQuery.Data.ListEmailAddressesForSudoId.Item.Folder
    ) -> EmailFolderEntity {
        let ownerTransformer = OwnerEntityTransformer()

        let id = folder.id
        let owner = folder.owner
        let owners = folder.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = folder.emailAddressId
        let folderName = folder.folderName
        let size = folder.size
        let unseenCount = Int(folder.unseenCount)
        let ttl = folder.ttl
        let version = folder.version
        let createdAt = Date(millisecondsSince1970: folder.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: folder.updatedAtEpochMs)
        return EmailFolderEntity(
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
            updatedAt: updatedAt
        )
    }

    func transform(_ folder: EmailFolderEntity) -> EmailFolder {
        let ownerTransformer = OwnerEntityTransformer()

        let id = folder.id
        let owner = folder.owner
        let owners = folder.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = folder.emailAddressId
        let folderName = folder.folderName
        let size = folder.size
        let unseenCount = folder.unseenCount
        let ttl = folder.ttl
        let version = folder.version
        let createdAt = folder.createdAt
        let updatedAt = folder.updatedAt
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
            updatedAt: updatedAt
        )
    }

    func transform(
        _ folder: GraphQL.ListEmailFoldersForEmailAddressIdQuery.Data.ListEmailFoldersForEmailAddressId.Item
    ) -> EmailFolderEntity {
        let ownerTransformer = OwnerEntityTransformer()

        let id = folder.id
        let owner = folder.owner
        let owners = folder.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = folder.emailAddressId
        let folderName = folder.folderName
        let size = folder.size
        let unseenCount = Int(folder.unseenCount)
        let ttl = folder.ttl
        let version = folder.version
        let createdAt = Date(millisecondsSince1970: folder.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: folder.updatedAtEpochMs)
        return EmailFolderEntity(
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
            updatedAt: updatedAt
        )
    }

}
