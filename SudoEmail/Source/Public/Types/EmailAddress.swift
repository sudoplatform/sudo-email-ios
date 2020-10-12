//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct EmailAddress: Equatable {

    // MARK: - Properties

    public let id: String

    public let userId: String

    public let sudoId: String

    public let identityId: String

    public let emailAddress: String

    public let owners: [Owner]

    /// Email service timestamp to when the card entry was created.
    public let created: Date

    /// Email service timestamp to when the card entry was last updated.
    public let updated: Date

    /// Initialize an instance of `EmailAddress`.
    public init(
        id: String,
        userId: String,
        sudoId: String,
        identityId: String,
        emailAddress: String,
        owners: [Owner],
        created: Date,
        updated: Date
    ) {
        self.id = id
        self.userId = userId
        self.sudoId = sudoId
        self.identityId = identityId
        self.emailAddress = emailAddress
        self.owners = owners
        self.created = created
        self.updated = updated
    }
}
