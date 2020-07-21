//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
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
        case let .address(stringFilter):
            let filterEntity = stringFilterTransformer.transform(stringFilter)
            return .address(filterEntity)
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
