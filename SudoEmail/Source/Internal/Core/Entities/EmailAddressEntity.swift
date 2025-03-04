//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of an email address business rule. Depicts the address of an email address that a user may own or send mail to.
struct EmailAddressEntity: Equatable {

    // MARK: - Properties

    /// The fully structured email address (e.g. `example@sudoplatform.com`)
    var emailAddress: String

    /// The display name (or personal name) of the email address.
    var displayName: String?

    /// An alias for the email address.
    var alias: String?

    // MARK: - Lifecycle

    /// Initialize an instance of `EmailAddressEntity`.
    /// - Parameters:
    ///   - emailAddress: Fully qualified email address of the form localPart@domain, eg, `example@sudoplatform.com`.
    ///   - displayName: The display name (or personal name) of the email address.
    ///   - alias: An alias for the email address.
    init(emailAddress: String, displayName: String? = nil, alias: String? = nil) {
        self.emailAddress = emailAddress
        self.displayName = displayName
        self.alias = alias
    }
}
