//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core entity representation of a email message state filter business rule. Depicts the rules for filtering email message states.
enum EmailMessageStateFilterEntity: Equatable {
    /// Filter by equality of `StateEntity`.
    case equals(StateEntity)
    /// Filter by non-equality of `StateEntity`.
    case notEquals(StateEntity)
    /// Filter by `StateEntity` equaling any of the values of the input.
    case isIn([StateEntity])
    /// Filter by `StateEntity` not equaling any of the values of the input.
    case isNotIn([StateEntity])
}
