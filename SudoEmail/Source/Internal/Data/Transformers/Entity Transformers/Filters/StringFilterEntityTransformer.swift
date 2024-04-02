//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform Input String Filters to `StringFilterEntity`.
struct StringFilterEntityTransformer {

    /// Transform a input string filter to an entity.
    func transform(_ filter: StringFilter) -> StringFilterEntity {
        switch filter {
        case let .equals(string):
            return StringFilterEntity.equals(string)
        case let .notEquals(string):
            return StringFilterEntity.notEquals(string)
        case let .beginsWith(string):
            return StringFilterEntity.beginsWith(string)
        }
    }
}
