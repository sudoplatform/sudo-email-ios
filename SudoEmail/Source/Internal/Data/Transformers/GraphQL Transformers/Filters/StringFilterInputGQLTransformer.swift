//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform string entity filter data to the GraphQL input filter data.
struct StringFilterInputGQLTransformer {

    /// Transform a `StringFilterEntity` filter rule into a GraphQL `StringFilterInput` filter rule.
    func transformToStringFilterInput(_ entity: StringFilterEntity) -> GraphQL.StringFilterInput {
        switch entity {
        case let .equals(string):
            return GraphQL.StringFilterInput(eq: string)
        case let .notEquals(string):
            return GraphQL.StringFilterInput(ne: string)
        case let .beginsWith(string):
            return GraphQL.StringFilterInput(beginsWith: string)
        }
    }

    /// Transform a `StringFilterEntity` filter rule into a GraphQL `IDFilterInput` filter rule.
    func transformToIdFilterInput(_ entity: StringFilterEntity) -> GraphQL.IDFilterInput {
        switch entity {
        case let .equals(string):
            return GraphQL.IDFilterInput(eq: string)
        case let .notEquals(string):
            return GraphQL.IDFilterInput(ne: string)
        case let .beginsWith(string):
            return GraphQL.IDFilterInput(beginsWith: string)
        }
    }

}
