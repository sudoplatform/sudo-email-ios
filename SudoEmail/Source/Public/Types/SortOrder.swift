//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public enum SortOrder: Equatable {

    /// Sort the list of results in ascending order.
    case asc

    /// Sort the list of results in descending order.
    case desc

    // MARK: - Methods: Internal

    func toGraphQL() -> GraphQL.SortOrder {
        switch self {
        case .asc:
            return .asc
        case .desc:
            return .desc
        }
    }

}
