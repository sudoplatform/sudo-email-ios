//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public enum ScheduledDraftMessageStateFilter: Equatable {
    /// Return only results that match the given state.
    case equal(ScheduledDraftMessageState)
    /// Return only results that match one of the given states.
    case oneOf([ScheduledDraftMessageState])
    /// Return only results that do not match the given state.
    case notEqual(ScheduledDraftMessageState)
    /// Return only results that do not match any of the given states.
    case notOneOf([ScheduledDraftMessageState])
}

public struct ScheduledDraftMessageFilter {

    /// Filter by `state` property
    var state: ScheduledDraftMessageStateFilter?

    public init(
        state: ScheduledDraftMessageStateFilter?
    ) {
        self.state = state
    }
}
