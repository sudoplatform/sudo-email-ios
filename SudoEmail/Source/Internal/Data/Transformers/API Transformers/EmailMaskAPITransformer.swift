//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform entities from the Core level to EmailMask output results of the SDK.
struct EmailMaskAPITransformer {

    /// Utility for transforming owner entities to `Owner`.
    let ownerTransformer = OwnerAPITransformer()

    /// Transform an optional entity from the core layer to the API layer.
    /// - Parameter entity: Core entity to transform.
    /// - Returns: Transformed EmailMask or nil if entity is nil.
    func transform(_ entity: EmailMaskEntity?) -> EmailMask? {
        guard let entity = entity else {
            return nil
        }
        return transform(entity)
    }

    /// Transform an entity from the core layer to the API layer.
    /// - Parameter entity: Core entity to transform.
    /// - Returns: Transformed EmailMask.
    func transform(_ entity: EmailMaskEntity) -> EmailMask {
        let id = entity.id
        let owner = entity.owner
        let owners = entity.owners.map(ownerTransformer.transform(_:))
        let identityId = entity.identityId
        let maskAddress = entity.maskAddress
        let realAddress = entity.realAddress
        let realAddressType = transformRealAddressType(entity.realAddressType)
        let status = transformStatus(entity.status)
        let inboundReceived = entity.inboundReceived
        let inboundDelivered = entity.inboundDelivered
        let outboundReceived = entity.outboundReceived
        let outboundDelivered = entity.outboundDelivered
        let spamCount = entity.spamCount
        let virusCount = entity.virusCount
        let version = entity.version

        let createdAt = entity.createdAt
        let updatedAt = entity.updatedAt
        let expiresAt = entity.expiresAt

        let metadata = entity.metadata

        return EmailMask(
            id: id,
            owner: owner,
            owners: owners,
            identityId: identityId,
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
            createdAt: createdAt,
            updatedAt: updatedAt,
            version: version,
            expiresAt: expiresAt,
            metadata: metadata
        )
    }

    /// Transform EmailMaskRealAddressTypeEntity to RealAddressType
    private func transformRealAddressType(_ entityType: EmailMaskRealAddressTypeEntity) -> EmailMask.RealAddressType {
        switch entityType {
        case .internal:
            return .internal
        case .external:
            return .external
        }
    }

    /// Transform EmailMaskStatusEntity to EmailMask.EmailMaskStatus
    private func transformStatus(_ entityStatus: EmailMaskStatusEntity) -> EmailMask.EmailMaskStatus {
        switch entityStatus {
        case .enabled:
            return .enabled
        case .disabled:
            return .disabled
        case .locked:
            return .locked
        case .pending:
            return .pending
        }
    }
}
