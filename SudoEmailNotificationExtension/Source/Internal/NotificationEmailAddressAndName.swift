//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of email address and display name as used in the raw notification payload
struct NotificationEmailAddressAndName: Equatable, Decodable {
    var emailAddress: String
    var displayName: String?

    init(emailAddress: String, displayName: String? = nil) {
        self.emailAddress = emailAddress
        self.displayName = displayName
    }
}
