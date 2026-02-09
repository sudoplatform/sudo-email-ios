//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform email mask entity filter data to the GraphQL input filter data.
struct EmailMaskFilterInputGQLTransformer {

    /// Transform a `EmailMaskFilterEntity` filter rule into a GraphQL `EmailMaskFilterInput` filter rule.
    func transform(_ entity: EmailMaskFilterEntity) -> GraphQL.EmailMaskFilterInput {
        // Conditionally add filters only if they are provided - this ensures we do not send explicit nulls
        var filterInput = GraphQL.EmailMaskFilterInput()

        if let statusFilter = entity.status {
            filterInput.status = transformStatusFilter(statusFilter)
        }
        if let addressTypeFilter = entity.realAddressType {
            filterInput.realAddressType = transformAddressTypeFilter(addressTypeFilter)
        }

        return filterInput
    }

    /// Transform a `EmailMaskStatusFilterEntity` to a GraphQL `EmailMaskStatusFilterInput`.
    private func transformStatusFilter(_ entity: EmailMaskStatusFilterEntity) -> GraphQL.EmailMaskStatusFilterInput {
        switch entity {
        case .equal(let status):
            let graphQLStatus = transformStatusEntity(status)
            return GraphQL.EmailMaskStatusFilterInput(eq: graphQLStatus)
        case .oneOf(let statuses):
            let graphQLStatuses = statuses.map(transformStatusEntity(_:))
            return GraphQL.EmailMaskStatusFilterInput(in: graphQLStatuses)
        case .notEqual(let status):
            let graphQLStatus = transformStatusEntity(status)
            return GraphQL.EmailMaskStatusFilterInput(ne: graphQLStatus)
        case .notOneOf(let statuses):
            let graphQLStatuses = statuses.map(transformStatusEntity(_:))
            return GraphQL.EmailMaskStatusFilterInput(notIn: graphQLStatuses)
        }
    }

    /// Transform a `EmailMaskRealAddressTypeFilterEntity` to a GraphQL `EmailMaskRealAddressTypeFilterInput`.
    private func transformAddressTypeFilter(_ entity: EmailMaskRealAddressTypeFilterEntity) -> GraphQL.EmailMaskRealAddressTypeFilterInput {
        switch entity {
        case .equal(let addressType):
            let graphQLAddressType = transformAddressTypeEntity(addressType)
            return GraphQL.EmailMaskRealAddressTypeFilterInput(eq: graphQLAddressType)
        case .oneOf(let addressTypes):
            let graphQLAddressTypes = addressTypes.map(transformAddressTypeEntity(_:))
            return GraphQL.EmailMaskRealAddressTypeFilterInput(in: graphQLAddressTypes)
        case .notEqual(let addressType):
            let graphQLAddressType = transformAddressTypeEntity(addressType)
            return GraphQL.EmailMaskRealAddressTypeFilterInput(ne: graphQLAddressType)
        case .notOneOf(let addressTypes):
            let graphQLAddressTypes = addressTypes.map(transformAddressTypeEntity(_:))
            return GraphQL.EmailMaskRealAddressTypeFilterInput(notIn: graphQLAddressTypes)
        }
    }

    /// Transform `EmailMaskStatusEntity` to GraphQL `EmailMaskStatus`.
    private func transformStatusEntity(_ entity: EmailMaskStatusEntity) -> GraphQL.EmailMaskStatus {
        switch entity {
        case .enabled:
            return GraphQL.EmailMaskStatus.enabled
        case .disabled:
            return GraphQL.EmailMaskStatus.disabled
        case .locked:
            return GraphQL.EmailMaskStatus.locked
        case .pending:
            return GraphQL.EmailMaskStatus.pending
        }
    }

    /// Transform `EmailMaskRealAddressTypeEntity` to GraphQL `EmailMaskRealAddressType`.
    private func transformAddressTypeEntity(_ entity: EmailMaskRealAddressTypeEntity) -> GraphQL.EmailMaskRealAddressType {
        switch entity {
        case .internal:
            return GraphQL.EmailMaskRealAddressType.internal
        case .external:
            return GraphQL.EmailMaskRealAddressType.external
        }
    }
}
