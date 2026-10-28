//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct EmailAliasEntityTransformer {

    /// Utility for transforming owners to `OwnerTransformer`.
    let ownerTransformer = OwnerEntityTransformer()

    let deviceKeyWorker: DeviceKeyWorker!

    init(deviceKeyWorker: DeviceKeyWorker) {
        self.deviceKeyWorker = deviceKeyWorker
    }

    /// Transform the success result of `ProvisionEmailMaskMutation` from the service to a `EmailAliasEntity`.
    func transform(_ data: GraphQL.ProvisionEmailMaskMutation.Data) throws -> EmailAliasEntity {
        let graphQLEmailMask = data.provisionEmailMask
        let id = String(graphQLEmailMask.id)
        let owner = String(graphQLEmailMask.owner)
        let owners = graphQLEmailMask.owners.map(ownerTransformer.transform(_:))
        let identityId = String(graphQLEmailMask.identityId)
        let keyRingId = graphQLEmailMask.keyRingId
        let aliasAddress = graphQLEmailMask.maskAddress
        let realAddress = graphQLEmailMask.realAddress
        let realAddressType = transformRealAddressType(graphQLEmailMask.getEmailAliasRealAddressType())
        let status = transformStatus(graphQLEmailMask.getEmailAliasStatus())
        let inboundReceived = graphQLEmailMask.inboundReceived
        let inboundDelivered = graphQLEmailMask.inboundDelivered
        let outboundReceived = graphQLEmailMask.outboundReceived
        let outboundDelivered = graphQLEmailMask.outboundDelivered
        let spamCount = graphQLEmailMask.spamCount
        let virusCount = graphQLEmailMask.virusCount
        let version = graphQLEmailMask.version

        // Handle metadata unsealing
        var unsealedMetadata: [String: String]?
        if let metadata = graphQLEmailMask.metadata {
            let unsealedJsonString = try deviceKeyWorker.unsealString(
                metadata.base64EncodedSealedData,
                withKeyId: metadata.keyId,
                algorithm: metadata.algorithm
            )

            // Parse JSON string back to dictionary
            if let jsonData = unsealedJsonString.data(using: .utf8),
               let metadataDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: String] {
                unsealedMetadata = metadataDict
            }
        }

        // Handle timestamps
        let createdAt = Date(millisecondsSince1970: graphQLEmailMask.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLEmailMask.updatedAtEpochMs)
        let expiresAt = graphQLEmailMask.expiresAtEpochSec.map { Date(timeIntervalSince1970: TimeInterval($0)) }

        return EmailAliasEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            aliasAddress: aliasAddress,
            realAddress: realAddress,
            realAddressType: realAddressType,
            status: status,
            inboundReceived: inboundReceived,
            inboundDelivered: inboundDelivered,
            outboundReceived: outboundReceived,
            outboundDelivered: outboundDelivered,
            spamCount: spamCount,
            virusCount: virusCount,
            metadata: unsealedMetadata,
            expiresAt: expiresAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            version: version
        )
    }

    /// Transform the success result of `DeprovisionEmailMaskMutation` from the service to a `EmailAliasEntity`.
    func transform(_ data: GraphQL.DeprovisionEmailMaskMutation.Data) throws -> EmailAliasEntity {
        let graphQLEmailMask = data.deprovisionEmailMask
        let id = String(graphQLEmailMask.id)
        let owner = String(graphQLEmailMask.owner)
        let owners = graphQLEmailMask.owners.map(ownerTransformer.transform(_:))
        let identityId = String(graphQLEmailMask.identityId)
        let keyRingId = graphQLEmailMask.keyRingId
        let aliasAddress = graphQLEmailMask.maskAddress
        let realAddress = graphQLEmailMask.realAddress
        let realAddressType = transformRealAddressType(graphQLEmailMask.getEmailAliasRealAddressType())
        let status = transformStatus(graphQLEmailMask.getEmailAliasStatus())
        let inboundReceived = graphQLEmailMask.inboundReceived
        let inboundDelivered = graphQLEmailMask.inboundDelivered
        let outboundReceived = graphQLEmailMask.outboundReceived
        let outboundDelivered = graphQLEmailMask.outboundDelivered
        let spamCount = graphQLEmailMask.spamCount
        let virusCount = graphQLEmailMask.virusCount
        let version = graphQLEmailMask.version

        // Handle metadata unsealing
        var unsealedMetadata: [String: String]?
        if let metadata = graphQLEmailMask.metadata {
            let unsealedJsonString = try deviceKeyWorker.unsealString(
                metadata.base64EncodedSealedData,
                withKeyId: metadata.keyId,
                algorithm: metadata.algorithm
            )

            // Parse JSON string back to dictionary
            if let jsonData = unsealedJsonString.data(using: .utf8),
               let metadataDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: String] {
                unsealedMetadata = metadataDict
            }
        }

        // Handle timestamps
        let createdAt = Date(millisecondsSince1970: graphQLEmailMask.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLEmailMask.updatedAtEpochMs)
        let expiresAt = graphQLEmailMask.expiresAtEpochSec.map { Date(timeIntervalSince1970: TimeInterval($0)) }

        return EmailAliasEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            aliasAddress: aliasAddress,
            realAddress: realAddress,
            realAddressType: realAddressType,
            status: status,
            inboundReceived: inboundReceived,
            inboundDelivered: inboundDelivered,
            outboundReceived: outboundReceived,
            outboundDelivered: outboundDelivered,
            spamCount: spamCount,
            virusCount: virusCount,
            metadata: unsealedMetadata,
            expiresAt: expiresAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            version: version
        )
    }

    /// Transform the success result of `UpdateEmailMaskMutation` from the service to a `EmailAliasEntity`.
    func transform(_ data: GraphQL.UpdateEmailMaskMutation.Data) throws -> EmailAliasEntity {
        let graphQLEmailMask = data.updateEmailMask
        let id = String(graphQLEmailMask.id)
        let owner = String(graphQLEmailMask.owner)
        let owners = graphQLEmailMask.owners.map(ownerTransformer.transform(_:))
        let identityId = String(graphQLEmailMask.identityId)
        let keyRingId = graphQLEmailMask.keyRingId
        let aliasAddress = graphQLEmailMask.maskAddress
        let realAddress = graphQLEmailMask.realAddress
        let realAddressType = transformRealAddressType(graphQLEmailMask.getEmailAliasRealAddressType())
        let status = transformStatus(graphQLEmailMask.getEmailAliasStatus())
        let inboundReceived = graphQLEmailMask.inboundReceived
        let inboundDelivered = graphQLEmailMask.inboundDelivered
        let outboundReceived = graphQLEmailMask.outboundReceived
        let outboundDelivered = graphQLEmailMask.outboundDelivered
        let spamCount = graphQLEmailMask.spamCount
        let virusCount = graphQLEmailMask.virusCount
        let version = graphQLEmailMask.version

        // Handle metadata unsealing
        var unsealedMetadata: [String: String]?
        if let metadata = graphQLEmailMask.metadata {
            let unsealedJsonString = try deviceKeyWorker.unsealString(
                metadata.base64EncodedSealedData,
                withKeyId: metadata.keyId,
                algorithm: metadata.algorithm
            )

            // Parse JSON string back to dictionary
            if let jsonData = unsealedJsonString.data(using: .utf8),
               let metadataDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: String] {
                unsealedMetadata = metadataDict
            }
        }

        // Handle timestamps
        let createdAt = Date(millisecondsSince1970: graphQLEmailMask.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLEmailMask.updatedAtEpochMs)
        let expiresAt = graphQLEmailMask.expiresAtEpochSec.map { Date(timeIntervalSince1970: TimeInterval($0)) }

        return EmailAliasEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            aliasAddress: aliasAddress,
            realAddress: realAddress,
            realAddressType: realAddressType,
            status: status,
            inboundReceived: inboundReceived,
            inboundDelivered: inboundDelivered,
            outboundReceived: outboundReceived,
            outboundDelivered: outboundDelivered,
            spamCount: spamCount,
            virusCount: virusCount,
            metadata: unsealedMetadata,
            expiresAt: expiresAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            version: version
        )
    }

    /// Transform the success result of `EnableEmailMaskMutation` from the service to a `EmailAliasEntity`.
    func transform(_ data: GraphQL.EnableEmailMaskMutation.Data) throws -> EmailAliasEntity {
        let graphQLEmailMask = data.enableEmailMask
        let id = String(graphQLEmailMask.id)
        let owner = String(graphQLEmailMask.owner)
        let owners = graphQLEmailMask.owners.map(ownerTransformer.transform(_:))
        let identityId = String(graphQLEmailMask.identityId)
        let keyRingId = graphQLEmailMask.keyRingId
        let aliasAddress = graphQLEmailMask.maskAddress
        let realAddress = graphQLEmailMask.realAddress
        let realAddressType = transformRealAddressType(graphQLEmailMask.getEmailAliasRealAddressType())
        let status = transformStatus(graphQLEmailMask.getEmailAliasStatus())
        let inboundReceived = graphQLEmailMask.inboundReceived
        let inboundDelivered = graphQLEmailMask.inboundDelivered
        let outboundReceived = graphQLEmailMask.outboundReceived
        let outboundDelivered = graphQLEmailMask.outboundDelivered
        let spamCount = graphQLEmailMask.spamCount
        let virusCount = graphQLEmailMask.virusCount
        let version = graphQLEmailMask.version

        // Handle metadata unsealing
        var unsealedMetadata: [String: String]?
        if let metadata = graphQLEmailMask.metadata {
            let unsealedJsonString = try deviceKeyWorker.unsealString(
                metadata.base64EncodedSealedData,
                withKeyId: metadata.keyId,
                algorithm: metadata.algorithm
            )

            // Parse JSON string back to dictionary
            if let jsonData = unsealedJsonString.data(using: .utf8),
               let metadataDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: String] {
                unsealedMetadata = metadataDict
            }
        }

        // Handle timestamps
        let createdAt = Date(millisecondsSince1970: graphQLEmailMask.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLEmailMask.updatedAtEpochMs)
        let expiresAt = graphQLEmailMask.expiresAtEpochSec.map { Date(timeIntervalSince1970: TimeInterval($0)) }

        return EmailAliasEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            aliasAddress: aliasAddress,
            realAddress: realAddress,
            realAddressType: realAddressType,
            status: status,
            inboundReceived: inboundReceived,
            inboundDelivered: inboundDelivered,
            outboundReceived: outboundReceived,
            outboundDelivered: outboundDelivered,
            spamCount: spamCount,
            virusCount: virusCount,
            metadata: unsealedMetadata,
            expiresAt: expiresAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            version: version
        )
    }

    /// Transform the success result of `DisableEmailMaskMutation` from the service to a `EmailAliasEntity`.
    func transform(_ data: GraphQL.DisableEmailMaskMutation.Data) throws -> EmailAliasEntity {
        let graphQLEmailMask = data.disableEmailMask
        let id = String(graphQLEmailMask.id)
        let owner = String(graphQLEmailMask.owner)
        let owners = graphQLEmailMask.owners.map(ownerTransformer.transform(_:))
        let identityId = String(graphQLEmailMask.identityId)
        let keyRingId = graphQLEmailMask.keyRingId
        let aliasAddress = graphQLEmailMask.maskAddress
        let realAddress = graphQLEmailMask.realAddress
        let realAddressType = transformRealAddressType(graphQLEmailMask.getEmailAliasRealAddressType())
        let status = transformStatus(graphQLEmailMask.getEmailAliasStatus())
        let inboundReceived = graphQLEmailMask.inboundReceived
        let inboundDelivered = graphQLEmailMask.inboundDelivered
        let outboundReceived = graphQLEmailMask.outboundReceived
        let outboundDelivered = graphQLEmailMask.outboundDelivered
        let spamCount = graphQLEmailMask.spamCount
        let virusCount = graphQLEmailMask.virusCount
        let version = graphQLEmailMask.version

        // Handle metadata unsealing
        var unsealedMetadata: [String: String]?
        if let metadata = graphQLEmailMask.metadata {
            let unsealedJsonString = try deviceKeyWorker.unsealString(
                metadata.base64EncodedSealedData,
                withKeyId: metadata.keyId,
                algorithm: metadata.algorithm
            )

            // Parse JSON string back to dictionary
            if let jsonData = unsealedJsonString.data(using: .utf8),
               let metadataDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: String] {
                unsealedMetadata = metadataDict
            }
        }

        // Handle timestamps
        let createdAt = Date(millisecondsSince1970: graphQLEmailMask.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLEmailMask.updatedAtEpochMs)
        let expiresAt = graphQLEmailMask.expiresAtEpochSec.map { Date(timeIntervalSince1970: TimeInterval($0)) }

        return EmailAliasEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            aliasAddress: aliasAddress,
            realAddress: realAddress,
            realAddressType: realAddressType,
            status: status,
            inboundReceived: inboundReceived,
            inboundDelivered: inboundDelivered,
            outboundReceived: outboundReceived,
            outboundDelivered: outboundDelivered,
            spamCount: spamCount,
            virusCount: virusCount,
            metadata: unsealedMetadata,
            expiresAt: expiresAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            version: version
        )
    }

    /// Transform `ListEmailMasksForOwnerQuery.Data.ListEmailMasksForOwner.Item` from the service to a `EmailAliasEntity`.
    func transform(_ graphQLEmailMask: GraphQL.ListEmailMasksForOwnerQuery.Data.ListEmailMasksForOwner.Item) throws -> EmailAliasEntity {
        let id = String(graphQLEmailMask.id)
        let owner = String(graphQLEmailMask.owner)
        let owners = graphQLEmailMask.owners.map(ownerTransformer.transform(_:))
        let identityId = String(graphQLEmailMask.identityId)
        let keyRingId = graphQLEmailMask.keyRingId
        let aliasAddress = graphQLEmailMask.maskAddress
        let realAddress = graphQLEmailMask.realAddress
        let realAddressType = transformRealAddressType(graphQLEmailMask.getEmailAliasRealAddressType())
        let status = transformStatus(graphQLEmailMask.getEmailAliasStatus())
        let inboundReceived = graphQLEmailMask.inboundReceived
        let inboundDelivered = graphQLEmailMask.inboundDelivered
        let outboundReceived = graphQLEmailMask.outboundReceived
        let outboundDelivered = graphQLEmailMask.outboundDelivered
        let spamCount = graphQLEmailMask.spamCount
        let virusCount = graphQLEmailMask.virusCount
        let version = graphQLEmailMask.version

        // Handle metadata unsealing
        var unsealedMetadata: [String: String]?
        if let metadata = graphQLEmailMask.metadata {
            let unsealedJsonString = try deviceKeyWorker.unsealString(
                metadata.base64EncodedSealedData,
                withKeyId: metadata.keyId,
                algorithm: metadata.algorithm
            )

            // Parse JSON string back to dictionary
            if let jsonData = unsealedJsonString.data(using: .utf8),
               let metadataDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: String] {
                unsealedMetadata = metadataDict
            }
        }

        // Handle timestamps
        let createdAt = Date(millisecondsSince1970: graphQLEmailMask.createdAtEpochMs)
        let updatedAt = Date(millisecondsSince1970: graphQLEmailMask.updatedAtEpochMs)
        let expiresAt = graphQLEmailMask.expiresAtEpochSec.map { Date(timeIntervalSince1970: TimeInterval($0)) }

        return EmailAliasEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            aliasAddress: aliasAddress,
            realAddress: realAddress,
            realAddressType: realAddressType,
            status: status,
            inboundReceived: inboundReceived,
            inboundDelivered: inboundDelivered,
            outboundReceived: outboundReceived,
            outboundDelivered: outboundDelivered,
            spamCount: spamCount,
            virusCount: virusCount,
            metadata: unsealedMetadata,
            expiresAt: expiresAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            version: version
        )
    }

    // MARK: - Helper Methods

    /// Transform GraphQL EmailMaskRealAddressType to EmailAliasRealAddressTypeEntity
    private func transformRealAddressType(_ rawValue: GraphQL.EmailMaskRealAddressType) -> EmailAliasRealAddressTypeEntity {
        switch rawValue {
        case .internal:
            return .internal
        case .external:
            return .external
        case .unknown:
            return .external
        }
    }

    /// Transform GraphQL EmailMaskStatus to EmailAliasStatusEntity
    private func transformStatus(_ rawValue: GraphQL.EmailMaskStatus) -> EmailAliasStatusEntity {
        switch rawValue {
        case .enabled:
            return .enabled
        case .disabled:
            return .disabled
        case .locked:
            return .locked
        case .pending:
            return .pending
        case .unknown:
            return .disabled
        }
    }
}
