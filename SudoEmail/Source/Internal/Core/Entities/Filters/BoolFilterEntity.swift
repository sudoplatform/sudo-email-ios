//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core entity representation of a boolean filter business rule. Depicts the rules for filtering by bool values.
enum BoolFilterEntity: Equatable {
    /// Filter by equality of `Bool`.
    case equals(Bool)
    /// Filter by non-equality of `Bool`.
    case notEquals(Bool)
}
