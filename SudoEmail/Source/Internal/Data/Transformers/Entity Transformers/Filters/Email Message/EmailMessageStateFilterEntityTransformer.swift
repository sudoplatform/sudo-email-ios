//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
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
        case let .equals(state):
            let state = stateTransformer.transform(state)
            return .equals(state)
        case let .notEquals(state):
            let state = stateTransformer.transform(state)
            return .notEquals(state)
        case let .isIn(states):
            let states = states.map(stateTransformer.transform(_:))
            return .isIn(states)
        case let .isNotIn(states):
            let states = states.map(stateTransformer.transform(_:))
            return .isNotIn(states)
        }
    }

}
