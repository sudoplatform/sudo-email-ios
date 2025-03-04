//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform email message direction entity filter data to the GraphQL input filter data.
struct EmailMessageDirectionFilterInputGQLTransformer {

    // MARK: - Properties

    /// Utility class to transform `EmailMessageDirectionEntity` to `EmailMessageDirection`.
    let directionTransformer = EmailMessageDirectionGQLTransformer()

    // MARK: - Methods

    /// Transform a `EmailMessageDirectionFilterEntity` filter rule into a GraphQL `EmailMessageDirectionFilterInput` filter rule.
    func transform(_ entity: EmailMessageDirectionFilterEntity) -> GraphQL.EmailMessageDirectionFilterInput {
        switch entity {
        case .equals(let direction):
            let direction = directionTransformer.transform(direction)
            return GraphQL.EmailMessageDirectionFilterInput(eq: direction)
        case .notEquals(let direction):
            let direction = directionTransformer.transform(direction)
            return GraphQL.EmailMessageDirectionFilterInput(ne: direction)
        }
    }
}
