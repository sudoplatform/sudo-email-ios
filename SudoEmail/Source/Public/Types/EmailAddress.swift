//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct EmailAddress: Equatable {

    // MARK: - Properties

    public let address: String

    public let owner: String

    public let owners: [Owner]

    /// Email service timestamp to when the card entry was created.
    public let created: Date

    /// Email service timestamp to when the card entry was last updated.
    public let updated: Date

    /// Initialize an instance of `EmailAddress`.
    public init(address: String, owner: String, owners: [Owner], created: Date, updated: Date) {
        self.address = address
        self.owner = owner
        self.owners = owners
        self.created = created
        self.updated = updated
    }
}
