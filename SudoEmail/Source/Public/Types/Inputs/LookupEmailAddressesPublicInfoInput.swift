//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for retrieving public info for email addresses using `SudoEmailClient`.
public struct LookupEmailAddressesPublicInfoInput: Equatable {

    /// A list of email address strings in format 'local-part@domain'.
    public let emailAddresses: [String]

    /// Determines how the data will be fetched. Default usage is `remoteOnly`.
    public let cachePolicy: CachePolicy

    public init(
        emailAddresses: [String],
        cachePolicy: CachePolicy = .remoteOnly
    ) {
        self.emailAddresses = emailAddresses
        self.cachePolicy = cachePolicy
    }
}
