//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for listing email messages for an email folder using `SudoEmailClient`
public struct ListEmailMessagesForEmailFolderIdInput: Equatable {

    /// The unique identifier of email folder to retrieve messages for.
    public let emailFolderId: String
    
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
        emailFolderId: String,
        dateRange: EmailMessageDateRange? = nil,
        cachePolicy: CachePolicy? = .remoteOnly,
        sortOrder: SortOrder? = nil,
        limit: Int? = defaultEmailMessageLimit,
        nextToken: String? = nil,
        includeDeletedMessages: Bool? = false
    ) {
        self.emailFolderId = emailFolderId
        self.dateRange = dateRange
        self.cachePolicy = cachePolicy
        self.sortOrder = sortOrder
        self.limit = limit
        self.nextToken = nextToken
        self.includeDeletedMessages = includeDeletedMessages
    }
}
