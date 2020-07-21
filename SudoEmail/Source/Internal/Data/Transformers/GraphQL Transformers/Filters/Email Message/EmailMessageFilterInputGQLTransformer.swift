//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform email message entity filter data to the GraphQL input filter data.
struct EmailMessageFilterInputGQLTransformer {

    // MARK: - Properties

    /// Utility class to transform `EmailMessageDirectionFilterEntity` to `EmailMessageDirectionFilterInput`.
    let directionFilterTransformer = EmailMessageDirectionFilterInputGQLTransformer()

    /// Utility class to transform `EmailMessageStateFilterEntity` to `EmailMessageStateFilterInput`.
    let stateFilterTransformer = EmailMessageStateFilterInputGQLTransformer()

    /// Utility class to transform `BoolFilterEntity` to `BooleanFilterInput`.
    let boolFilterTransformer = BooleanFilterInputGQLTransformer()

    /// Utility class to transform `StringFilterEntity` to `StringFilterInput`.
    let stringFilterTransformer = StringFilterInputGQLTransformer()

    // MARK: - Methods

    /// Transform a `EmailMessageFilterEntity` filter rule into a GraphQL `EmailMessageFilterInput` filter rule.
    func transform(_ entity: EmailMessageFilterEntity) -> EmailMessageFilterInput {
        switch entity {
        case let .direction(direction):
            let direction = directionFilterTransformer.transform(direction)
            return EmailMessageFilterInput(direction: direction)
        case let .state(state):
            let state = stateFilterTransformer.transform(state)
            return EmailMessageFilterInput(state: state)
        case let .seen(seen):
            let seen = boolFilterTransformer.transform(seen)
            return EmailMessageFilterInput(seen: seen)
        case let .not(emailMessageFilter):
            let emailMessageFilter = transform(emailMessageFilter)
            return EmailMessageFilterInput(not: emailMessageFilter)
        case let .and(emailMessageFilters):
            let emailMessageFilters = emailMessageFilters.map(transform(_:))
            return EmailMessageFilterInput(and: emailMessageFilters)
        case let .or(emailMessageFilters):
            let emailMessageFilters = emailMessageFilters.map(transform(_:))
            return EmailMessageFilterInput(or: emailMessageFilters)
        }
    }

}
