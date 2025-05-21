//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a domain business rule. Depicts the rules for a filter of the `state` property of a `ScheduledDraftMessageEntity`.
enum ScheduledDraftMessageStateFilterEntity: Equatable {
    /// Return only results that match the given state.
    case equal(ScheduledDraftMessageStateEntity)
    /// Return only results that match one of the given states.
    case oneOf([ScheduledDraftMessageStateEntity])
    /// Return only results that do not match the given state.
    case notEqual(ScheduledDraftMessageStateEntity)
    /// Return only results that do not match any of the given states.
    case notOneOf([ScheduledDraftMessageStateEntity])
}

/// Core entity representation of a domain business rule. Depicts the rules for ffiltering properties of a `ScheduledDraftMessageEntity`.
struct ScheduledDraftMessageFilterEntity {
    /// Filter by `state` property
    var state: ScheduledDraftMessageStateFilterEntity?
}
