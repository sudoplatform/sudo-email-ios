//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform bool entity filter data to the GraphQL input filter data.
struct BooleanFilterInputGQLTransformer {

    /// Transform a `BoolFilterEntity` filter rule into a GraphQL `BooleanFilterInput` filter rule.
    func transform(_ entity: BoolFilterEntity) -> GraphQL.BooleanFilterInput {
        switch entity {
        case .equals(let bool):
            return GraphQL.BooleanFilterInput(eq: bool)
        case .notEquals(let bool):
            return GraphQL.BooleanFilterInput(ne: bool)
        }
    }
}
