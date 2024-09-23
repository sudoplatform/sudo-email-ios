//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct SealedEmailMessageEntityTransformer {

    /// Utility for transforming email message directions to `DirectionEntity`.
    let directionTransformer = EmailMessageDirectionEntityTransformer()

    /// Utility for transforming email message state to `StateEntity`.
    let stateTransformer = EmailMessageStateEntityTransformer()

    /// Utility for transforming owners to `OwnerTransformer`.
    let ownerTransformer = OwnerEntityTransformer()
    
    /// Utility for transforming encryptionStatus
    let encryptionStatusTransformer = EmailMessageEncryptionStatusEntityTransformer()

    /// Transform the success result of `GetEmailMessageQuery` from the service to a `SealedEmailMessageEntity`.
    func transform(
        _ graphQLMessage: GraphQL.GetEmailMessageQuery.Data.GetEmailMessage
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let owner = graphQLMessage.owner
        let owners = graphQLMessage.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.rfc822Header.keyId
        let algorithm = graphQLMessage.rfc822Header.algorithm
        let folderId = graphQLMessage.folderId
        let previousFolderId = graphQLMessage.previousFolderId
        let clientRefId = graphQLMessage.clientRefId
        let createdAt = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let sortDate = Date(millisecondsSince1970: graphQLMessage.sortDateEpochMs)
        let seen = graphQLMessage.seen
        let repliedTo = graphQLMessage.repliedTo
        let forwarded = graphQLMessage.forwarded
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        let version = graphQLMessage.version
        let size = graphQLMessage.size
        let encryptionStatus = try encryptionStatusTransformer.transform(graphQLMessage.encryptionStatus)
        /// Sealed Attributes.
        let rfc822Header = graphQLMessage.rfc822Header.base64EncodedSealedData
        return SealedEmailMessageEntity(
            id: id,
            owner: owner,
            owners: owners,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            folderId: folderId,
            previousFolderId: previousFolderId,
            direction: direction,
            seen: seen,
            repliedTo: repliedTo,
            forwarded: forwarded,
            state: state,
            clientRefId: clientRefId,
            version: version,
            sortDate: sortDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            size: size,
            encryptionStatus: encryptionStatus,
            rfc822Header: rfc822Header
        )
    }
    
    /// Transform the success result of `ListEmailMessagesQuery` from the service to a `SealedEmailMessageEntity`.
    func transform(
        _ graphQLMessage: GraphQL.ListEmailMessagesQuery.Data.ListEmailMessage.Item
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let owner = graphQLMessage.owner
        let owners = graphQLMessage.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.rfc822Header.keyId
        let algorithm = graphQLMessage.rfc822Header.algorithm
        let folderId = graphQLMessage.folderId
        let previousFolderId = graphQLMessage.previousFolderId
        let clientRefId = graphQLMessage.clientRefId
        let createdAt = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let sortDate = Date(millisecondsSince1970: graphQLMessage.sortDateEpochMs)
        let seen = graphQLMessage.seen
        let repliedTo = graphQLMessage.repliedTo
        let forwarded = graphQLMessage.forwarded
        let version = graphQLMessage.version
        let size = graphQLMessage.size
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        let encryptionStatus = try encryptionStatusTransformer.transform(graphQLMessage.encryptionStatus)
        /// Sealed Attributes.
        let rfc822Header = graphQLMessage.rfc822Header.base64EncodedSealedData
        return SealedEmailMessageEntity(
            id: id,
            owner: owner,
            owners: owners,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            folderId: folderId,
            previousFolderId: previousFolderId,
            direction: direction,
            seen: seen,
            repliedTo: repliedTo,
            forwarded: forwarded,
            state: state,
            clientRefId: clientRefId,
            version: version,
            sortDate: sortDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            size: size,
            encryptionStatus: encryptionStatus,
            rfc822Header: rfc822Header
        )
    }

    /// Transform the success result of `ListEmailMessagesForEmailAddressIdQuery` from the service to a `SealedEmailMessageEntity`.
    func transform(
        _ graphQLMessage: GraphQL.ListEmailMessagesForEmailAddressIdQuery.Data.ListEmailMessagesForEmailAddressId.Item
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let owner = graphQLMessage.owner
        let owners = graphQLMessage.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.rfc822Header.keyId
        let algorithm = graphQLMessage.rfc822Header.algorithm
        let folderId = graphQLMessage.folderId
        let previousFolderId = graphQLMessage.previousFolderId
        let clientRefId = graphQLMessage.clientRefId
        let createdAt = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let sortDate = Date(millisecondsSince1970: graphQLMessage.sortDateEpochMs)
        let seen = graphQLMessage.seen
        let repliedTo = graphQLMessage.repliedTo
        let forwarded = graphQLMessage.forwarded
        let version = graphQLMessage.version
        let size = graphQLMessage.size
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        let encryptionStatus = try encryptionStatusTransformer.transform(graphQLMessage.encryptionStatus)
        /// Sealed Attributes.
        let rfc822Header = graphQLMessage.rfc822Header.base64EncodedSealedData
        return SealedEmailMessageEntity(
            id: id,
            owner: owner,
            owners: owners,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            folderId: folderId,
            previousFolderId: previousFolderId,
            direction: direction,
            seen: seen,
            repliedTo: repliedTo,
            forwarded: forwarded,
            state: state,
            clientRefId: clientRefId,
            version: version,
            sortDate: sortDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            size: size,
            encryptionStatus: encryptionStatus,
            rfc822Header: rfc822Header
        )
    }

    /// Transform the success result of `ListEmailMessagesForEmailFolderIdQuery` from the service to a `SealedEmailMessageEntity`.
    func transform(
        _ graphQLMessage: GraphQL.ListEmailMessagesForEmailFolderIdQuery.Data.ListEmailMessagesForEmailFolderId.Item
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let owner = graphQLMessage.owner
        let owners = graphQLMessage.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.rfc822Header.keyId
        let algorithm = graphQLMessage.rfc822Header.algorithm
        let folderId = graphQLMessage.folderId
        let previousFolderId = graphQLMessage.previousFolderId
        let clientRefId = graphQLMessage.clientRefId
        let createdAt = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let sortDate = Date(millisecondsSince1970: graphQLMessage.sortDateEpochMs)
        let seen = graphQLMessage.seen
        let repliedTo = graphQLMessage.repliedTo
        let forwarded = graphQLMessage.forwarded
        let version = graphQLMessage.version
        let size = graphQLMessage.size
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        let encryptionStatus = try encryptionStatusTransformer.transform(graphQLMessage.encryptionStatus)
        /// Sealed Attributes.
        let rfc822Header = graphQLMessage.rfc822Header.base64EncodedSealedData
        return SealedEmailMessageEntity(
            id: id,
            owner: owner,
            owners: owners,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            folderId: folderId,
            previousFolderId: previousFolderId,
            direction: direction,
            seen: seen,
            repliedTo: repliedTo,
            forwarded: forwarded,
            state: state,
            clientRefId: clientRefId,
            version: version,
            sortDate: sortDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            size: size,
            encryptionStatus: encryptionStatus,
            rfc822Header: rfc822Header
        )
    }

    /// Transform a `SealedEmailMessageEntity` to a partial `EmailMessageEntity` to be used when unsealing fails
    func transform(sealedEmailMessage: SealedEmailMessageEntity) -> PartialEmailMessageEntity {
        let id = sealedEmailMessage.id
        let owner = sealedEmailMessage.owner
        let owners = sealedEmailMessage.owners
        let emailAddressId = sealedEmailMessage.emailAddressId
        let keyId = sealedEmailMessage.keyId
        let folderId = sealedEmailMessage.folderId
        let previousFolderId = sealedEmailMessage.previousFolderId
        let clientRefId = sealedEmailMessage.clientRefId
        let createdAt = sealedEmailMessage.createdAt
        let updatedAt = sealedEmailMessage.updatedAt
        let sortDate = sealedEmailMessage.sortDate
        let seen = sealedEmailMessage.seen
        let repliedTo = sealedEmailMessage.repliedTo
        let forwarded = sealedEmailMessage.forwarded
        let version = sealedEmailMessage.version
        let size = sealedEmailMessage.size
        let direction = sealedEmailMessage.direction
        let state = sealedEmailMessage.state
        let encryptionStatus = sealedEmailMessage.encryptionStatus
        return PartialEmailMessageEntity(
            id: id,
            owner: owner,
            owners: owners,
            emailAddressId: emailAddressId,
            keyId: keyId,
            folderId: folderId,
            previousFolderId: previousFolderId,
            seen: seen,
            repliedTo: repliedTo,
            forwarded: forwarded,
            direction: direction,
            state: state,
            clientRefId: clientRefId,
            sortDate: sortDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            version: version,
            size: size,
            encryptionStatus: encryptionStatus
        )
    }

    /// Transform the success result of `OnEmailMessageCreatedSubscription` from the service to a `SealedEmailMessageEntity`.
    func transform(
        _ graphQLMessage: GraphQL.OnEmailMessageCreatedSubscription.Data.OnEmailMessageCreated
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let owner = graphQLMessage.owner
        let owners = graphQLMessage.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.rfc822Header.keyId
        let algorithm = graphQLMessage.rfc822Header.algorithm
        let folderId = graphQLMessage.folderId
        let previousFolderId = graphQLMessage.previousFolderId
        let clientRefId = graphQLMessage.clientRefId
        let createdAt = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let sortDate = Date(millisecondsSince1970: graphQLMessage.sortDateEpochMs)
        let seen = graphQLMessage.seen
        let repliedTo = graphQLMessage.repliedTo
        let forwarded = graphQLMessage.forwarded
        let version = graphQLMessage.version
        let size = graphQLMessage.size
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        let encryptionStatus = try encryptionStatusTransformer.transform(graphQLMessage.encryptionStatus)
        /// Sealed Attributes.
        let rfc822Header = graphQLMessage.rfc822Header.base64EncodedSealedData
        return SealedEmailMessageEntity(
            id: id,
            owner: owner,
            owners: owners,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            folderId: folderId,
            previousFolderId: previousFolderId,
            direction: direction,
            seen: seen,
            repliedTo: repliedTo,
            forwarded: forwarded,
            state: state,
            clientRefId: clientRefId,
            version: version,
            sortDate: sortDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            size: size,
            encryptionStatus: encryptionStatus,
            rfc822Header: rfc822Header
        )
    }

    /// Transform the success result of `OnEmailMessageCreatedWithDirectionSubscription` from the service to a `SealedEmailMessageEntity`.
    func transform(
        _ graphQLMessage: GraphQL.OnEmailMessageCreatedWithDirectionSubscription.Data.OnEmailMessageCreated
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let owner = graphQLMessage.owner
        let owners = graphQLMessage.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.rfc822Header.keyId
        let algorithm = graphQLMessage.rfc822Header.algorithm
        let folderId = graphQLMessage.folderId
        let previousFolderId = graphQLMessage.previousFolderId
        let clientRefId = graphQLMessage.clientRefId
        let createdAt = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let sortDate = Date(millisecondsSince1970: graphQLMessage.sortDateEpochMs)
        let seen = graphQLMessage.seen
        let repliedTo = graphQLMessage.repliedTo
        let forwarded = graphQLMessage.forwarded
        let version = graphQLMessage.version
        let size = graphQLMessage.size
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        let encryptionStatus = try encryptionStatusTransformer.transform(graphQLMessage.encryptionStatus)
        /// Sealed Attributes.
        let rfc822Header = graphQLMessage.rfc822Header.base64EncodedSealedData
        return SealedEmailMessageEntity(
            id: id,
            owner: owner,
            owners: owners,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            folderId: folderId,
            previousFolderId: previousFolderId,
            direction: direction,
            seen: seen,
            repliedTo: repliedTo,
            forwarded: forwarded,
            state: state,
            clientRefId: clientRefId,
            version: version,
            sortDate: sortDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            size: size,
            encryptionStatus: encryptionStatus,
            rfc822Header: rfc822Header
        )
    }

    /// Transform the success result of `OnEmailMessageDeletedSubscription` from the service to a `SealedEmailMessageEntity`.
    func transform(
        _ graphQLMessage: GraphQL.OnEmailMessageDeletedSubscription.Data.OnEmailMessageDeleted
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let owner = graphQLMessage.owner
        let owners = graphQLMessage.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.rfc822Header.keyId
        let algorithm = graphQLMessage.rfc822Header.algorithm
        let folderId = graphQLMessage.folderId
        let previousFolderId = graphQLMessage.previousFolderId
        let clientRefId = graphQLMessage.clientRefId
        let createdAt = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let sortDate = Date(millisecondsSince1970: graphQLMessage.sortDateEpochMs)
        let seen = graphQLMessage.seen
        let repliedTo = graphQLMessage.repliedTo
        let forwarded = graphQLMessage.forwarded
        let version = graphQLMessage.version
        let size = graphQLMessage.size
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        let encryptionStatus = try encryptionStatusTransformer.transform(graphQLMessage.encryptionStatus)
        /// Sealed Attributes.
        let rfc822Header = graphQLMessage.rfc822Header.base64EncodedSealedData
        return SealedEmailMessageEntity(
            id: id,
            owner: owner,
            owners: owners,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            folderId: folderId,
            previousFolderId: previousFolderId,
            direction: direction,
            seen: seen,
            repliedTo: repliedTo,
            forwarded: forwarded,
            state: state,
            clientRefId: clientRefId,
            version: version,
            sortDate: sortDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            size: size,
            encryptionStatus: encryptionStatus,
            rfc822Header: rfc822Header
        )
    }

    /// Transform the success result of `OnEmailMessageDeletedWithIdSubscription` from the service to a `SealedEmailMessageEntity`.
    func transform(
        _ graphQLMessage: GraphQL.OnEmailMessageDeletedWithIdSubscription.Data.OnEmailMessageDeleted
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let owner = graphQLMessage.owner
        let owners = graphQLMessage.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.rfc822Header.keyId
        let algorithm = graphQLMessage.rfc822Header.algorithm
        let folderId = graphQLMessage.folderId
        let previousFolderId = graphQLMessage.previousFolderId
        let clientRefId = graphQLMessage.clientRefId
        let createdAt = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let sortDate = Date(millisecondsSince1970: graphQLMessage.sortDateEpochMs)
        let seen = graphQLMessage.seen
        let repliedTo = graphQLMessage.repliedTo
        let forwarded = graphQLMessage.forwarded
        let version = graphQLMessage.version
        let size = graphQLMessage.size
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        let encryptionStatus = try encryptionStatusTransformer.transform(graphQLMessage.encryptionStatus)
        /// Sealed Attributes.
        let rfc822Header = graphQLMessage.rfc822Header.base64EncodedSealedData
        return SealedEmailMessageEntity(
            id: id,
            owner: owner,
            owners: owners,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            folderId: folderId,
            previousFolderId: previousFolderId,
            direction: direction,
            seen: seen,
            repliedTo: repliedTo,
            forwarded: forwarded,
            state: state,
            clientRefId: clientRefId,
            version: version,
            sortDate: sortDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            size: size,
            encryptionStatus: encryptionStatus,
            rfc822Header: rfc822Header
        )
    }
    
    /// Transform the success result of `OnEmailMessageUpdatedSubscription` from the service to a `SealedEmailMessageEntity`.
    func transform(
        _ graphQLMessage: GraphQL.OnEmailMessageUpdatedSubscription.Data.OnEmailMessageUpdated
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let owner = graphQLMessage.owner
        let owners = graphQLMessage.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.rfc822Header.keyId
        let algorithm = graphQLMessage.rfc822Header.algorithm
        let folderId = graphQLMessage.folderId
        let previousFolderId = graphQLMessage.previousFolderId
        let clientRefId = graphQLMessage.clientRefId
        let createdAt = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let sortDate = Date(millisecondsSince1970: graphQLMessage.sortDateEpochMs)
        let seen = graphQLMessage.seen
        let repliedTo = graphQLMessage.repliedTo
        let forwarded = graphQLMessage.forwarded
        let version = graphQLMessage.version
        let size = graphQLMessage.size
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        let encryptionStatus = try encryptionStatusTransformer.transform(graphQLMessage.encryptionStatus)
        /// Sealed Attributes.
        let rfc822Header = graphQLMessage.rfc822Header.base64EncodedSealedData
        return SealedEmailMessageEntity(
            id: id,
            owner: owner,
            owners: owners,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            folderId: folderId,
            previousFolderId: previousFolderId,
            direction: direction,
            seen: seen,
            repliedTo: repliedTo,
            forwarded: forwarded,
            state: state,
            clientRefId: clientRefId,
            version: version,
            sortDate: sortDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            size: size,
            encryptionStatus: encryptionStatus,
            rfc822Header: rfc822Header
        )
    }

    /// Transform the success result of `OnEmailMessageUpdatedWithIdSubscription` from the service to a `SealedEmailMessageEntity`.
    func transform(
        _ graphQLMessage: GraphQL.OnEmailMessageUpdatedWithIdSubscription.Data.OnEmailMessageUpdated
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let owner = graphQLMessage.owner
        let owners = graphQLMessage.owners.map(ownerTransformer.transform(_:))
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.rfc822Header.keyId
        let algorithm = graphQLMessage.rfc822Header.algorithm
        let folderId = graphQLMessage.folderId
        let previousFolderId = graphQLMessage.previousFolderId
        let clientRefId = graphQLMessage.clientRefId
        let createdAt = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let sortDate = Date(millisecondsSince1970: graphQLMessage.sortDateEpochMs)
        let seen = graphQLMessage.seen
        let repliedTo = graphQLMessage.repliedTo
        let forwarded = graphQLMessage.forwarded
        let version = graphQLMessage.version
        let size = graphQLMessage.size
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        let encryptionStatus = try encryptionStatusTransformer.transform(graphQLMessage.encryptionStatus)
        /// Sealed Attributes.
        let rfc822Header = graphQLMessage.rfc822Header.base64EncodedSealedData
        return SealedEmailMessageEntity(
            id: id,
            owner: owner,
            owners: owners,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            folderId: folderId,
            previousFolderId: previousFolderId,
            direction: direction,
            seen: seen,
            repliedTo: repliedTo,
            forwarded: forwarded,
            state: state,
            clientRefId: clientRefId,
            version: version,
            sortDate: sortDate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            size: size,
            encryptionStatus: encryptionStatus,
            rfc822Header: rfc822Header
        )
    }

}
