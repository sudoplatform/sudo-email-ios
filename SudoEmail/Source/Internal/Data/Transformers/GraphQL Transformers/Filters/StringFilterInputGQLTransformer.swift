//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform string entity filter data to the GraphQL input filter data.
struct StringFilterInputGQLTransformer {

    /// Transform a `StringFilterEntity` filter rule into a GraphQL `StringFilterInput` filter rule.
    func transform(_ entity: StringFilterEntity) -> StringFilterInput {
        switch entity {
        case let .equals(string):
            return StringFilterInput(eq: string)
        case let .notEquals(string):
            return StringFilterInput(ne: string)
        case let .contains(string):
            return StringFilterInput(contains: string)
        case let .notContains(string):
            return StringFilterInput(notContains: string)
        case let .beginsWith(string):
            return StringFilterInput(beginsWith: string)
        }
    }

}
