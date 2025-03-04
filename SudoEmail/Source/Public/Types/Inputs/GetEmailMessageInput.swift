//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for getting an email message using `SudoEmailClient`
public struct GetEmailMessageInput: Equatable {

    /// The unique identifier of email message to retrieve.
    public let id: String

    /// Determines how the email address will be fetched. Default usage is `remoteOnly`.
    public let cachePolicy: CachePolicy?

    public init(id: String, cachePolicy: CachePolicy? = nil) {
        self.id = id
        self.cachePolicy = cachePolicy
    }
}
