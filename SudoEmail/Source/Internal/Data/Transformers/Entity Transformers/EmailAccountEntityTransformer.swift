//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct EmailAccountEntityTransformer {

    /// Utility for transforming addresses to `EmailAddressEntity`.
    let emailAddressTransformer = EmailAddressEntityTransformer()

    /// Utility for transforming owners to `OwnerTransformer`.
    let ownerTransformer = OwnerEntityTransformer()

    /// Utility for transforming folders to `EmailFolderEntity`
    let folderTransformer = EmailFolderEntityTransformer()

    let deviceKeyWorker: DeviceKeyWorker!

    init(deviceKeyWorker: DeviceKeyWorker) {
        self.deviceKeyWorker = deviceKeyWorker
    }

    /// Transform the success result of `ProvisionEmailAddressMutation` from the service to a `EmailAccountEntity`.
    func transform(_ data: GraphQL.ProvisionEmailAddressMutation.Data) throws -> EmailAccountEntity {
        let graphQLEmail = data.provisionEmailAddress
        let id = graphQLEmail.id
        let owner = graphQLEmail.owner
        let owners = graphQLEmail.owners.map(ownerTransformer.transform(_:))
        let identityId = graphQLEmail.identityId
        let keyRingId = graphQLEmail.keyRingId
        let keyIds = graphQLEmail.keyIds
        var unsealedAlias: String?
        if let alias = graphQLEmail.alias {
            unsealedAlias = try deviceKeyWorker.unsealString(
                alias.base64EncodedSealedData,
                withKeyId: alias.keyId,
                algorithm: alias.algorithm
            )
        }
        let emailAddress: EmailAddressEntity = try emailAddressTransformer.transform(
            graphQLEmail.emailAddress,
            alias: unsealedAlias
        )
        let size = graphQLEmail.size
        let numberOfEmailMessages = graphQLEmail.numberOfEmailMessages
        let version = graphQLEmail.version
        let folders = graphQLEmail.folders.map(folderTransformer.transform(_:))
        let createdAt = Date(millisecondsSince1970: graphQLEmail.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLEmail.updatedAtEpochMs)
        let lastReceivedAt = (graphQLEmail.lastReceivedAtEpochMs != nil)
                            ? Date(millisecondsSince1970: graphQLEmail.lastReceivedAtEpochMs!)
                            : nil
        return EmailAccountEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            keyIds: keyIds,
            emailAddress: emailAddress,
            size: size,
            numberOfEmailMessages: numberOfEmailMessages,
            version: version,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastReceivedAt: lastReceivedAt,
            folders: folders
        )
    }

    /// Transform the success result of `DeprovisionEmailAddressMutation` from the service to a `EmailAccountEntity`.
    func transform(_ data: GraphQL.DeprovisionEmailAddressMutation.Data) throws -> EmailAccountEntity {
        let graphQLEmail = data.deprovisionEmailAddress
        let id = graphQLEmail.id
        let owner = graphQLEmail.owner
        let owners = graphQLEmail.owners.map(ownerTransformer.transform(_:))
        let identityId = graphQLEmail.identityId
        let keyRingId = graphQLEmail.keyRingId
        let keyIds = graphQLEmail.keyIds
        var unsealedAlias: String?
        if let alias = graphQLEmail.alias {
            unsealedAlias = try deviceKeyWorker.unsealString(
                alias.base64EncodedSealedData,
                withKeyId: alias.keyId,
                algorithm: alias.algorithm
            )
        }
        let emailAddress = try emailAddressTransformer.transform(
            graphQLEmail.emailAddress,
            alias: unsealedAlias
        )
        let size = graphQLEmail.size
        let numberOfEmailMessages = graphQLEmail.numberOfEmailMessages
        let version = graphQLEmail.version
        let createdAt = Date(millisecondsSince1970: graphQLEmail.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLEmail.updatedAtEpochMs)
        let lastReceivedAt = (graphQLEmail.lastReceivedAtEpochMs != nil)
                            ? Date(millisecondsSince1970: graphQLEmail.lastReceivedAtEpochMs!)
                            : nil
        return EmailAccountEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            keyIds: keyIds,
            emailAddress: emailAddress,
            size: size,
            numberOfEmailMessages: numberOfEmailMessages,
            version: version,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastReceivedAt: lastReceivedAt,
            folders: []
        )
    }

    /// Transform the success result of `GetEmailAddressQuery` from the service to a `EmailAccountEntity`.
    func transform(_ graphQLEmail: GraphQL.GetEmailAddressQuery.Data.GetEmailAddress) throws -> EmailAccountEntity {
        let id = graphQLEmail.id
        let owner = graphQLEmail.owner
        let owners = graphQLEmail.owners.map(ownerTransformer.transform(_:))
        let identityId = graphQLEmail.identityId
        let keyRingId = graphQLEmail.keyRingId
        let keyIds = graphQLEmail.keyIds
        var unsealedAlias: String?
        if let alias = graphQLEmail.alias {
            unsealedAlias = try deviceKeyWorker.unsealString(
                alias.base64EncodedSealedData,
                withKeyId: alias.keyId,
                algorithm: alias.algorithm
            )
        }
        let emailAddress = try emailAddressTransformer.transform(
            graphQLEmail.emailAddress,
            alias: unsealedAlias
        )
        let size = graphQLEmail.size
        let numberOfEmailMessages = graphQLEmail.numberOfEmailMessages
        let version = graphQLEmail.version
        let folders = graphQLEmail.folders.map(folderTransformer.transform(_:))
        let createdAt = Date(millisecondsSince1970: graphQLEmail.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLEmail.updatedAtEpochMs)
        let lastReceivedAt = (graphQLEmail.lastReceivedAtEpochMs != nil)
                            ? Date(millisecondsSince1970: graphQLEmail.lastReceivedAtEpochMs!)
                            : nil
        return EmailAccountEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            keyIds: keyIds,
            emailAddress: emailAddress,
            size: size,
            numberOfEmailMessages: numberOfEmailMessages,
            version: version,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastReceivedAt: lastReceivedAt,
            folders: folders
        )
    }

    /// Transform the success result of `ListEmailAddressesQuery` from the service to a `EmailAccountEntity`.
    func transform(_ graphQLEmail: GraphQL.ListEmailAddressesQuery.Data.ListEmailAddress.Item) throws -> EmailAccountEntity {
        let id = graphQLEmail.id
        let owner = graphQLEmail.owner
        let owners = graphQLEmail.owners.map(ownerTransformer.transform(_:))
        let identityId = graphQLEmail.identityId
        let keyRingId = graphQLEmail.keyRingId
        let keyIds = graphQLEmail.keyIds
        var unsealedAlias: String?
        if let alias = graphQLEmail.alias {
            unsealedAlias = try deviceKeyWorker.unsealString(
                alias.base64EncodedSealedData,
                withKeyId: alias.keyId,
                algorithm: alias.algorithm
            )
        }
        let emailAddress = try emailAddressTransformer.transform(
            graphQLEmail.emailAddress,
            alias: unsealedAlias
        )
        let size = graphQLEmail.size
        let numberOfEmailMessages = graphQLEmail.numberOfEmailMessages
        let version = graphQLEmail.version
        let folders = graphQLEmail.folders.map(folderTransformer.transform(_:))
        let createdAt = Date(millisecondsSince1970: graphQLEmail.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLEmail.updatedAtEpochMs)
        let lastReceivedAt = graphQLEmail.lastReceivedAtEpochMs.map { Date(millisecondsSince1970: $0) }
        return EmailAccountEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            keyIds: keyIds,
            emailAddress: emailAddress,
            size: size,
            numberOfEmailMessages: numberOfEmailMessages,
            version: version,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastReceivedAt: lastReceivedAt,
            folders: folders
        )
    }

    /// Transform the success result of `ListEmailAddressesForSudoIdQuery` from the service to a `EmailAccountEntity`.
    func transform(
        _ graphQLEmail: GraphQL.ListEmailAddressesForSudoIdQuery.Data.ListEmailAddressesForSudoId.Item
    ) throws -> EmailAccountEntity {
        let id = graphQLEmail.id
        let owner = graphQLEmail.owner
        let owners = graphQLEmail.owners.map(ownerTransformer.transform(_:))
        let identityId = graphQLEmail.identityId
        let keyRingId = graphQLEmail.keyRingId
        let keyIds = graphQLEmail.keyIds
        var unsealedAlias: String?
        if let alias = graphQLEmail.alias {
            unsealedAlias = try deviceKeyWorker.unsealString(
                alias.base64EncodedSealedData,
                withKeyId: alias.keyId,
                algorithm: alias.algorithm
            )
        }
        let emailAddress = try emailAddressTransformer.transform(
            graphQLEmail.emailAddress,
            alias: unsealedAlias
        )
        let size = graphQLEmail.size
        let numberOfEmailMessages = graphQLEmail.numberOfEmailMessages
        let version = graphQLEmail.version
        let folders = graphQLEmail.folders.map(folderTransformer.transform(_:))
        let createdAt = Date(millisecondsSince1970: graphQLEmail.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLEmail.updatedAtEpochMs)
        let lastReceivedAt = graphQLEmail.lastReceivedAtEpochMs.map { Date(millisecondsSince1970: $0) }
        return EmailAccountEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            keyIds: keyIds,
            emailAddress: emailAddress,
            size: size,
            numberOfEmailMessages: numberOfEmailMessages,
            version: version,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastReceivedAt: lastReceivedAt,
            folders: folders
        )
    }

    // Transform an `EmailAccountEntity` to an `EmailAddress`
    func transform(_ emailAccountEntity: EmailAccountEntity) throws -> EmailAddress {
        let id = emailAccountEntity.id
        let owner = emailAccountEntity.owner
        let owners = emailAccountEntity.owners.map(ownerTransformer.transform(_:))
        let identityId = emailAccountEntity.identityId
        let keyRingId = emailAccountEntity.keyRingId
        let keyIds = emailAccountEntity.keyIds
        let emailAddress = emailAccountEntity.emailAddress.emailAddress
        let folders = emailAccountEntity.folders.map(folderTransformer.transform(_:))
        let size = emailAccountEntity.size
        let numberOfEmailMessages = emailAccountEntity.numberOfEmailMessages
        let version = emailAccountEntity.version
        let createdAt = emailAccountEntity.createdAt
        let updatedAt = emailAccountEntity.updatedAt
        let lastReceivedAt = emailAccountEntity.lastReceivedAt
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
            numberOfEmailMessages: numberOfEmailMessages,
            version: version,
            createdAt: createdAt,
            updatedAt: updatedAt,
            lastReceivedAt: lastReceivedAt,
            alias: emailAccountEntity.emailAddress.alias
        )
    }

}
