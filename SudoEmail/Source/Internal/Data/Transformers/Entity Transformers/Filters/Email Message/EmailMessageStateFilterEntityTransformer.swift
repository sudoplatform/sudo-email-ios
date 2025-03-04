//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform Input `EmailMessageStateFilters` to `EmailMessageStateFilterEntity`.
struct EmailMessageStateFilterEntityTransformer {

    // MARK: - Properties

    /// Utility to transform `EmailMessage.State` to `StateEntity`.
    let stateTransformer = EmailMessageStateEntityTransformer()

    // MARK: - Methods

    /// Transform a input `EmailMessageStateFilter` into a `EmailMessageStateFilterEntity`.
    func transform(_ filter: EmailMessageStateFilter) -> EmailMessageStateFilterEntity {
        switch filter {
        case .equals(let state):
            let state = stateTransformer.transform(state)
            return .equals(state)
        case .notEquals(let state):
            let state = stateTransformer.transform(state)
            return .notEquals(state)
        case .isIn(let states):
            let states = states.map(stateTransformer.transform(_:))
            return .isIn(states)
        case .isNotIn(let states):
            let states = states.map(stateTransformer.transform(_:))
            return .isNotIn(states)
        }
    }
}
