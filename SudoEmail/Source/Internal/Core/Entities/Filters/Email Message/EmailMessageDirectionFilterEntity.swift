//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core entity representation of a email message direction filter business rule. Depicts the rules for filtering email message directions.
enum EmailMessageDirectionFilterEntity: Equatable {
    /// Filter by equality of `DirectionEntity`.
    case equals(DirectionEntity)
    /// Filter by non-equality of `DirectionEntity`.
    case notEquals(DirectionEntity)
}
