//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform input email alias filter rules to the entity level filter rule in the Core/Entity level of the SDK.
struct EmailAliasFilterEntityTransformer {

    /// Transform a public `EmailAliasFilter` to `EmailAliasFilterEntity`.
    func transform(_ filter: EmailAliasFilter) -> EmailAliasFilterEntity {
        var statusFilterEntity: EmailAliasStatusFilterEntity?
        var realAddressTypeFilterEntity: EmailAliasRealAddressTypeFilterEntity?

        if let statusFilter = filter.status {
            statusFilterEntity = transformStatusFilter(statusFilter)
        }

        if let addressTypeFilter = filter.realAddressType {
            realAddressTypeFilterEntity = transformAddressTypeFilter(addressTypeFilter)
        }

        return EmailAliasFilterEntity(
            status: statusFilterEntity,
            realAddressType: realAddressTypeFilterEntity
        )
    }

    /// Transform `EmailAliasStatusFilter` to `EmailAliasStatusFilterEntity`.
    private func transformStatusFilter(_ filter: EmailAliasStatusFilter) -> EmailAliasStatusFilterEntity {
        switch filter {
        case .equal(let status):
            let statusEntity = transformStatus(status)
            return .equal(statusEntity)
        case .oneOf(let statuses):
            let statusEntities = statuses.map { transformStatus($0) }
            return .oneOf(statusEntities)
        case .notEqual(let status):
            let statusEntity = transformStatus(status)
            return .notEqual(statusEntity)
        case .notOneOf(let statuses):
            let statusEntities = statuses.map { transformStatus($0) }
            return .notOneOf(statusEntities)
        }
    }

    /// Transform `EmailAliasAddressTypeFilter` to `EmailAliasRealAddressTypeFilterEntity`.
    private func transformAddressTypeFilter(_ filter: EmailAliasAddressTypeFilter) -> EmailAliasRealAddressTypeFilterEntity {
        switch filter {
        case .equal(let addressType):
            let addressTypeEntity = transformAddressType(addressType)
            return .equal(addressTypeEntity)
        case .oneOf(let addressTypes):
            let addressTypeEntities = addressTypes.map { transformAddressType($0) }
            return .oneOf(addressTypeEntities)
        case .notEqual(let addressType):
            let addressTypeEntity = transformAddressType(addressType)
            return .notEqual(addressTypeEntity)
        case .notOneOf(let addressTypes):
            let addressTypeEntities = addressTypes.map { transformAddressType($0) }
            return .notOneOf(addressTypeEntities)
        }
    }

    /// Transform `EmailAlias.EmailAliasStatus` to `EmailAliasStatusEntity`.
    private func transformStatus(_ status: EmailAlias.EmailAliasStatus) -> EmailAliasStatusEntity {
        switch status {
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

    /// Transform `EmailAlias.RealAddressType` to `EmailAliasRealAddressTypeEntity`.
    private func transformAddressType(_ addressType: EmailAlias.RealAddressType) -> EmailAliasRealAddressTypeEntity {
        switch addressType {
        case .internal:
            return .internal
        case .external:
            return .external
        }
    }
}
