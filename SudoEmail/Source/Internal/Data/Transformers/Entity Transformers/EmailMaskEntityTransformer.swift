//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct EmailMaskEntityTransformer {

    /// Utility for transforming owners to `OwnerTransformer`.
    let ownerTransformer = OwnerEntityTransformer()

    let deviceKeyWorker: DeviceKeyWorker!

    init(deviceKeyWorker: DeviceKeyWorker) {
        self.deviceKeyWorker = deviceKeyWorker
    }

    /// Transform the success result of `ProvisionEmailMaskMutation` from the service to a `EmailMaskEntity`.
    func transform(_ data: GraphQL.ProvisionEmailMaskMutation.Data) throws -> EmailMaskEntity {
        let graphQLEmailMask = data.provisionEmailMask
        let id = String(graphQLEmailMask.id)
        let owner = String(graphQLEmailMask.owner)
        let owners = graphQLEmailMask.owners.map(ownerTransformer.transform(_:))
        let identityId = String(graphQLEmailMask.identityId)
        let keyRingId = graphQLEmailMask.keyRingId
        let maskAddress = graphQLEmailMask.maskAddress
        let realAddress = graphQLEmailMask.realAddress
        let realAddressType = transformRealAddressType(graphQLEmailMask.getEmailMaskRealAddressType())
        let status = transformStatus(graphQLEmailMask.getEmailMaskStatus())
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

        return EmailMaskEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            maskAddress: maskAddress,
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

    /// Transform the success result of `DeprovisionEmailMaskMutation` from the service to a `EmailMaskEntity`.
    func transform(_ data: GraphQL.DeprovisionEmailMaskMutation.Data) throws -> EmailMaskEntity {
        let graphQLEmailMask = data.deprovisionEmailMask
        let id = String(graphQLEmailMask.id)
        let owner = String(graphQLEmailMask.owner)
        let owners = graphQLEmailMask.owners.map(ownerTransformer.transform(_:))
        let identityId = String(graphQLEmailMask.identityId)
        let keyRingId = graphQLEmailMask.keyRingId
        let maskAddress = graphQLEmailMask.maskAddress
        let realAddress = graphQLEmailMask.realAddress
        let realAddressType = transformRealAddressType(graphQLEmailMask.getEmailMaskRealAddressType())
        let status = transformStatus(graphQLEmailMask.getEmailMaskStatus())
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

        return EmailMaskEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            maskAddress: maskAddress,
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

    /// Transform the success result of `UpdateEmailMaskMutation` from the service to a `EmailMaskEntity`.
    func transform(_ data: GraphQL.UpdateEmailMaskMutation.Data) throws -> EmailMaskEntity {
        let graphQLEmailMask = data.updateEmailMask
        let id = String(graphQLEmailMask.id)
        let owner = String(graphQLEmailMask.owner)
        let owners = graphQLEmailMask.owners.map(ownerTransformer.transform(_:))
        let identityId = String(graphQLEmailMask.identityId)
        let keyRingId = graphQLEmailMask.keyRingId
        let maskAddress = graphQLEmailMask.maskAddress
        let realAddress = graphQLEmailMask.realAddress
        let realAddressType = transformRealAddressType(graphQLEmailMask.getEmailMaskRealAddressType())
        let status = transformStatus(graphQLEmailMask.getEmailMaskStatus())
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

        return EmailMaskEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            maskAddress: maskAddress,
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

    /// Transform the success result of `EnableEmailMaskMutation` from the service to a `EmailMaskEntity`.
    func transform(_ data: GraphQL.EnableEmailMaskMutation.Data) throws -> EmailMaskEntity {
        let graphQLEmailMask = data.enableEmailMask
        let id = String(graphQLEmailMask.id)
        let owner = String(graphQLEmailMask.owner)
        let owners = graphQLEmailMask.owners.map(ownerTransformer.transform(_:))
        let identityId = String(graphQLEmailMask.identityId)
        let keyRingId = graphQLEmailMask.keyRingId
        let maskAddress = graphQLEmailMask.maskAddress
        let realAddress = graphQLEmailMask.realAddress
        let realAddressType = transformRealAddressType(graphQLEmailMask.getEmailMaskRealAddressType())
        let status = transformStatus(graphQLEmailMask.getEmailMaskStatus())
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

        return EmailMaskEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            maskAddress: maskAddress,
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

    /// Transform the success result of `DisableEmailMaskMutation` from the service to a `EmailMaskEntity`.
    func transform(_ data: GraphQL.DisableEmailMaskMutation.Data) throws -> EmailMaskEntity {
        let graphQLEmailMask = data.disableEmailMask
        let id = String(graphQLEmailMask.id)
        let owner = String(graphQLEmailMask.owner)
        let owners = graphQLEmailMask.owners.map(ownerTransformer.transform(_:))
        let identityId = String(graphQLEmailMask.identityId)
        let keyRingId = graphQLEmailMask.keyRingId
        let maskAddress = graphQLEmailMask.maskAddress
        let realAddress = graphQLEmailMask.realAddress
        let realAddressType = transformRealAddressType(graphQLEmailMask.getEmailMaskRealAddressType())
        let status = transformStatus(graphQLEmailMask.getEmailMaskStatus())
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

        return EmailMaskEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            maskAddress: maskAddress,
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

    /// Transform `ListEmailMasksForOwnerQuery.Data.ListEmailMasksForOwner.Item` from the service to a `EmailMaskEntity`.
    func transform(_ graphQLEmailMask: GraphQL.ListEmailMasksForOwnerQuery.Data.ListEmailMasksForOwner.Item) throws -> EmailMaskEntity {
        let id = String(graphQLEmailMask.id)
        let owner = String(graphQLEmailMask.owner)
        let owners = graphQLEmailMask.owners.map(ownerTransformer.transform(_:))
        let identityId = String(graphQLEmailMask.identityId)
        let keyRingId = graphQLEmailMask.keyRingId
        let maskAddress = graphQLEmailMask.maskAddress
        let realAddress = graphQLEmailMask.realAddress
        let realAddressType = transformRealAddressType(graphQLEmailMask.getEmailMaskRealAddressType())
        let status = transformStatus(graphQLEmailMask.getEmailMaskStatus())
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

        return EmailMaskEntity(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
            keyRingId: keyRingId,
            maskAddress: maskAddress,
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

    /// Transform GraphQL EmailMaskRealAddressType to EmailMaskRealAddressTypeEntity
    private func transformRealAddressType(_ rawValue: GraphQL.EmailMaskRealAddressType) -> EmailMaskRealAddressTypeEntity {
        switch rawValue {
        case .internal:
            return .internal
        case .external:
            return .external
        case .unknown:
            return .external
        }
    }

    /// Transform GraphQL EmailMaskStatus to EmailMaskStatusEntity
    private func transformStatus(_ rawValue: GraphQL.EmailMaskStatus) -> EmailMaskStatusEntity {
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
