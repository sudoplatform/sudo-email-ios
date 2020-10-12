//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform string entity filter data to the GraphQL input filter data.
struct StringFilterInputGQLTransformer {

    /// Transform a `StringFilterEntity` filter rule into a GraphQL `StringFilterInput` filter rule.
    func transformToStringFilterInput(_ entity: StringFilterEntity) -> StringFilterInput {
        switch entity {
        case let .equals(string):
            return StringFilterInput(eq: string)
        case let .notEquals(string):
            return StringFilterInput(ne: string)
        case let .beginsWith(string):
            return StringFilterInput(beginsWith: string)
        }
    }

    /// Transform a `StringFilterEntity` filter rule into a GraphQL `IDFilterInput` filter rule.
    func transformToIdFilterInput(_ entity: StringFilterEntity) -> IDFilterInput {
        switch entity {
        case let .equals(string):
            return IDFilterInput(eq: string)
        case let .notEquals(string):
            return IDFilterInput(ne: string)
        case let .beginsWith(string):
            return IDFilterInput(beginsWith: string)
        }
    }

}
