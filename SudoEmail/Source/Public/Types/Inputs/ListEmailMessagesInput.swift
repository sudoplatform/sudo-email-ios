//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for listing email messages using `SudoEmailClient`
public struct ListEmailMessagesInput: Equatable {

    /// Email messages matching the specified date range inclusive will be fetched.
    public let dateRange: EmailMessageDateRange?

    /// Determines how the email address will be fetched. Default usage is `remoteOnly`.
    public let cachePolicy: CachePolicy?

    /// The direction in which the email messages are sorted. Defaults to descending.
    public let sortOrder: SortOrder?

    /// The number of items to return.  If omitted, the default of 10 will be used.
    public let limit: Int?

    /// A pagination token generated by a previous call.
    public let nextToken: String?

    /// Whether to include deleted messages or not. Defaults to false.
    public let includeDeletedMessages: Bool?

    public init(
        dateRange: EmailMessageDateRange? = nil,
        cachePolicy: CachePolicy? = .remoteOnly,
        sortOrder: SortOrder? = nil,
        limit: Int? = defaultEmailMessageLimit,
        nextToken: String? = nil,
        includeDeletedMessages: Bool? = false
    ) {
        self.dateRange = dateRange
        self.cachePolicy = cachePolicy
        self.sortOrder = sortOrder
        self.limit = limit
        self.nextToken = nextToken
        self.includeDeletedMessages = includeDeletedMessages
    }
}
