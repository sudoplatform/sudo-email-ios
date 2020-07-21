//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core entity representation of a domain business rule. Depicts the rules for a filter of a string property.
enum StringFilterEntity: Equatable {
    /// Filter by equality of `String`.
    case equals(String)
    /// Filter by non-equality of `String`.
    case notEquals(String)
    /// Filter by searching for matches containing `String`.
    case contains(String)
    /// Filter by searching for matches that does **not** contain `String`.
    case notContains(String)
    /// Filter by searching for match that begins with `String`.
    case beginsWith(String)
}
