//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Filter for a `Bool` type.
public enum BoolFilter: Equatable {
    /// Filter by equality of `Bool`.
    case equals(Bool)
    /// Filter by non-equality of `Bool`.
    case notEquals(Bool)
}
