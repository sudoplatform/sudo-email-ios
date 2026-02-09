//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform input email mask filter rules to the entity level filter rule in the Core/Entity level of the SDK.
struct EmailMaskFilterEntityTransformer {

    /// Transform a public `EmailMaskFilter` to `EmailMaskFilterEntity`.
    func transform(_ filter: EmailMaskFilter) -> EmailMaskFilterEntity {
        var statusFilterEntity: EmailMaskStatusFilterEntity?
        var realAddressTypeFilterEntity: EmailMaskRealAddressTypeFilterEntity?

        if let statusFilter = filter.status {
            statusFilterEntity = transformStatusFilter(statusFilter)
        }

        if let addressTypeFilter = filter.realAddressType {
            realAddressTypeFilterEntity = transformAddressTypeFilter(addressTypeFilter)
        }

        return EmailMaskFilterEntity(
            status: statusFilterEntity,
            realAddressType: realAddressTypeFilterEntity
        )
    }

    /// Transform `EmailMaskStatusFilter` to `EmailMaskStatusFilterEntity`.
    private func transformStatusFilter(_ filter: EmailMaskStatusFilter) -> EmailMaskStatusFilterEntity {
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

    /// Transform `EmailMaskAddressTypeFilter` to `EmailMaskRealAddressTypeFilterEntity`.
    private func transformAddressTypeFilter(_ filter: EmailMaskAddressTypeFilter) -> EmailMaskRealAddressTypeFilterEntity {
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

    /// Transform `EmailMask.EmailMaskStatus` to `EmailMaskStatusEntity`.
    private func transformStatus(_ status: EmailMask.EmailMaskStatus) -> EmailMaskStatusEntity {
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

    /// Transform `EmailMask.RealAddressType` to `EmailMaskRealAddressTypeEntity`.
    private func transformAddressType(_ addressType: EmailMask.RealAddressType) -> EmailMaskRealAddressTypeEntity {
        switch addressType {
        case .internal:
            return .internal
        case .external:
            return .external
        }
    }
}
