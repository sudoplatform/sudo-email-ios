//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for getting a email addresses associated with a sudo using `SudoEmailClient`
public struct ListEmailAddressesForSudoIdInput: Equatable {
    /// The unique identifier of the sudo associated with the email addresses to be retrieved
    public let sudoId: String

    /// Determines how the email addresses will be fetched. Default usage is `remoteOnly`.
    public let cachePolicy: CachePolicy?

    /// The number of items to return.  Will be defaulted if omitted.
    public let limit: Int?

    /// A token generated by a previous call.
    public let nextToken: String?

    public init(
        sudoId: String,
        cachePolicy: CachePolicy? = .remoteOnly,
        limit: Int? = defaultEmailAddressesLimit,
        nextToken: String? = nil
    ) {
        self.sudoId = sudoId
        self.cachePolicy = cachePolicy
        self.limit = limit
        self.nextToken = nextToken
    }
}
