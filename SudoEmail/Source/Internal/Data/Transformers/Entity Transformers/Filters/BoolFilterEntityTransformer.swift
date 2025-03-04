//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform Input `BoolFilters` to `BoolFilterEntity`.
struct BoolFilterEntityTransformer {

    /// Transform a input `BoolFilter` into a `BoolFilterEntity`.
    func transform(_ filter: BoolFilter) -> BoolFilterEntity {
        switch filter {
        case .equals(let bool):
            return .equals(bool)
        case .notEquals(let bool):
            return .notEquals(bool)
        }
    }
}
