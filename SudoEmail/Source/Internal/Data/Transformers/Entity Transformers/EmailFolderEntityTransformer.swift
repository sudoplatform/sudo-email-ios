//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct EmailFolderEntityTransformer {
    
    let deviceKeyWorker: DeviceKeyWorker!
    
    init(deviceKeyWorker: DeviceKeyWorker) {
        self.deviceKeyWorker = deviceKeyWorker
    }

    func transform(_ folder: GraphQL.ProvisionEmailAddressMutation.Data.ProvisionEmailAddress.Folder) throws -> EmailFolderEntity {
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
        var unsealedCustomFolderName: String?
        if let customFolderName = folder.customFolderName {
            unsealedCustomFolderName = try deviceKeyWorker.unsealString(
                customFolderName.base64EncodedSealedData,
                withKeyId: customFolderName.keyId,
                algorithm: customFolderName.algorithm
            )
        }
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
            updatedAt: updatedAt,
            customFolderName: unsealedCustomFolderName
        )
    }

    func transform(_ folder: GraphQL.GetEmailAddressQuery.Data.GetEmailAddress.Folder) throws -> EmailFolderEntity {
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
        var unsealedCustomFolderName: String?
        if let customFolderName = folder.customFolderName {
            unsealedCustomFolderName = try deviceKeyWorker.unsealString(
                customFolderName.base64EncodedSealedData,
                withKeyId: customFolderName.keyId,
                algorithm: customFolderName.algorithm
            )
        }
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
            updatedAt: updatedAt,
            customFolderName: unsealedCustomFolderName
        )
    }

    func transform(_ folder: GraphQL.ListEmailAddressesQuery.Data.ListEmailAddress.Item.Folder) throws -> EmailFolderEntity {
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
        var unsealedCustomFolderName: String?
        if let customFolderName = folder.customFolderName {
            unsealedCustomFolderName = try deviceKeyWorker.unsealString(
                customFolderName.base64EncodedSealedData,
                withKeyId: customFolderName.keyId,
                algorithm: customFolderName.algorithm
            )
        }
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
            updatedAt: updatedAt,
            customFolderName: unsealedCustomFolderName
        )
    }

    func transform(
        _ folder: GraphQL.ListEmailAddressesForSudoIdQuery.Data.ListEmailAddressesForSudoId.Item.Folder
    ) throws -> EmailFolderEntity {
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
        var unsealedCustomFolderName: String?
        if let customFolderName = folder.customFolderName {
            unsealedCustomFolderName = try deviceKeyWorker.unsealString(
                customFolderName.base64EncodedSealedData,
                withKeyId: customFolderName.keyId,
                algorithm: customFolderName.algorithm
            )
        }
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
            updatedAt: updatedAt,
            customFolderName: unsealedCustomFolderName
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
        let customFolderName = folder.customFolderName
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

    func transform(
        _ folder: GraphQL.ListEmailFoldersForEmailAddressIdQuery.Data.ListEmailFoldersForEmailAddressId.Item
    ) throws -> EmailFolderEntity {
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
        var unsealedCustomFolderName: String?
        if let customFolderName = folder.customFolderName {
            unsealedCustomFolderName = try deviceKeyWorker.unsealString(
                customFolderName.base64EncodedSealedData,
                withKeyId: customFolderName.keyId,
                algorithm: customFolderName.algorithm
            )
        }
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
            updatedAt: updatedAt,
            customFolderName: unsealedCustomFolderName
        )
    }
    
    func transform(_ folder: GraphQL.CreateCustomEmailFolderMutation.Data.CreateCustomEmailFolder) throws -> EmailFolderEntity {
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
        var unsealedCustomFolderName: String?
        if let customFolderName = folder.customFolderName {
            unsealedCustomFolderName = try deviceKeyWorker.unsealString(
                customFolderName.base64EncodedSealedData,
                withKeyId: customFolderName.keyId,
                algorithm: customFolderName.algorithm
            )
        }
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
            updatedAt: updatedAt,
            customFolderName: unsealedCustomFolderName
        )
    }

}
