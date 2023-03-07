//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for getting an email address using `SudoEmailClient`
public struct GetEmailAddressInput: Equatable {

    /// The unique identifier of email address to retrieve,.
    public let id: String

    /// Determines how the email address will be fetched. Default usage is `remoteOnly`.
    public let cachePolicy: CachePolicy?

    public init(id: String, cachePolicy: CachePolicy? = .remoteOnly) {
        self.id = id
        self.cachePolicy = cachePolicy
    }
}
