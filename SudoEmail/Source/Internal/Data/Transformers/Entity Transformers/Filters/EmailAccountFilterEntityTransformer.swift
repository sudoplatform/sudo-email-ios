//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
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
        case let .id(stringFilter):
            let filterEntity = stringFilterTransformer.transform(stringFilter)
            return .id(filterEntity)
        case let .identityId(stringFilter):
            let filterEntity = stringFilterTransformer.transform(stringFilter)
            return .identityId(filterEntity)
        case let .keyRingId(stringFilter):
            let filterEntity = stringFilterTransformer.transform(stringFilter)
            return .keyRingId(filterEntity)
        case let .emailAddress(stringFilter):
            let filterEntity = stringFilterTransformer.transform(stringFilter)
            return .emailAddress(filterEntity)
        case let .not(emailAddressFilter):
            let filterEntity = transform(emailAddressFilter)
            return .not(filterEntity)
        case let .and(emailAddressFilters):
            let filterEntities = emailAddressFilters.map(transform(_:))
            return .and(filterEntities)
        case let .or(emailAddressFilters):
            let filterEntities = emailAddressFilters.map(transform(_:))
            return .or(filterEntities)
        }
    }

}
