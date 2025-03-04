//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform input email address filter rules to the entity level filter rule in the Core/Entity level of the SDK.
struct EmailAccountFilterEntityTransformer {

    /// Utility for transforming API string filters to entity string filters.
    let stringFilterTransformer = StringFilterEntityTransformer()

    /// Transform an API `EmailAddressFilter` to `EmailAccountFilterEntity`.
    func transform(_ filter: EmailAddressFilter) -> EmailAccountFilterEntity {
        switch filter {
        case .id(let stringFilter):
            let filterEntity = stringFilterTransformer.transform(stringFilter)
            return .id(filterEntity)
        case .identityId(let stringFilter):
            let filterEntity = stringFilterTransformer.transform(stringFilter)
            return .identityId(filterEntity)
        case .keyRingId(let stringFilter):
            let filterEntity = stringFilterTransformer.transform(stringFilter)
            return .keyRingId(filterEntity)
        case .emailAddress(let stringFilter):
            let filterEntity = stringFilterTransformer.transform(stringFilter)
            return .emailAddress(filterEntity)
        case .not(let emailAddressFilter):
            let filterEntity = transform(emailAddressFilter)
            return .not(filterEntity)
        case .and(let emailAddressFilters):
            let filterEntities = emailAddressFilters.map(transform(_:))
            return .and(filterEntities)
        case .or(let emailAddressFilters):
            let filterEntities = emailAddressFilters.map(transform(_:))
            return .or(filterEntities)
        }
    }
}
