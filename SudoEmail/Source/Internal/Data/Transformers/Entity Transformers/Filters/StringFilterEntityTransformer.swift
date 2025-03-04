//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform Input String Filters to `StringFilterEntity`.
struct StringFilterEntityTransformer {

    /// Transform a input string filter to an entity.
    func transform(_ filter: StringFilter) -> StringFilterEntity {
        switch filter {
        case .equals(let string):
            return StringFilterEntity.equals(string)
        case .notEquals(let string):
            return StringFilterEntity.notEquals(string)
        case .beginsWith(let string):
            return StringFilterEntity.beginsWith(string)
        }
    }
}
