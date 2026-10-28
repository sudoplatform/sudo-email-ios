//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for listing email aliases for owner using `SudoEmailClient`
public struct ListEmailAliasesForOwnerInput: Equatable {
    /// Any filters to apply to the list operation.
    public let filter: EmailAliasFilter?
    /// Limit of the results to return. If nil, the limit is 10.
    public let limit: Int?

    /// Next token to be used when accessing the next page of information.
    public let nextToken: String?

    public init(filter: EmailAliasFilter? = nil, limit: Int? = nil, nextToken: String? = nil) {
        self.filter = filter
        self.limit = limit
        self.nextToken = nextToken
    }
}
