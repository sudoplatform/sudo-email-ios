//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform email message state entity filter data to the GraphQL input filter data.
struct EmailMessageStateFilterInputGQLTransformer {

    // MARK: - Properties

    /// Utility class to transform `EmailMessageStateEntity` to `EmailMessageState`.
    let stateTransformer = EmailMessageStateGQLTransformer()

    // MARK: - Methods

    /// Transform a `EmailMessageStateFilterEntity` filter rule into a GraphQL `EmailMessageStateFilterInput` filter rule.
    func transform(_ entity: EmailMessageStateFilterEntity) -> GraphQL.EmailMessageStateFilterInput {
        switch entity {
        case .equals(let state):
            let state = stateTransformer.transform(state)
            return GraphQL.EmailMessageStateFilterInput(eq: state)
        case .notEquals(let state):
            let state = stateTransformer.transform(state)
            return GraphQL.EmailMessageStateFilterInput(ne: state)
        case .isIn(let states):
            let states = states.map(stateTransformer.transform(_:))
            return GraphQL.EmailMessageStateFilterInput(in: states)
        case .isNotIn(let states):
            let states = states.map(stateTransformer.transform(_:))
            return GraphQL.EmailMessageStateFilterInput(notIn: states)
        }
    }
}
