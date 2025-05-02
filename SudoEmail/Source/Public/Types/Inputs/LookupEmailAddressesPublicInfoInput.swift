//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for retrieving public info for email addresses using `SudoEmailClient`.
public struct LookupEmailAddressesPublicInfoInput: Equatable {

    /// A list of email address strings in format 'local-part@domain'.
    public let emailAddresses: [String]

    public init(emailAddresses: [String]) {
        self.emailAddresses = emailAddresses
    }
}
