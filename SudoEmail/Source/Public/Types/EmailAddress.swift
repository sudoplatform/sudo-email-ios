//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct EmailAddress: Equatable {

    // MARK: - Properties

    /// Unique identifier of the email address.
    public let id: String

    /// Identifier of the user that owns the email address.
    public let owner: String

    /// List of owner identifiers and issuers associated with this email address.
    public let owners: [Owner]

    /// Unique identifier of the identity associated with the email address.
    public let identityId: String

    /// Unique identifier of the key ring associated with the email address.
    public let keyRingId: String

    /// List of unique identifiers of the key ring associated with the email address.
    public let keyIds: [String]

    /// Address in format 'local-part@domain' of the email address.
    public let emailAddress: String

    /// List of email folders associated with this email address.
    public let folders: [EmailFolder]

    /// The total size, in bytes, of all email messages assigned to the email address.
    public let size: Double

    /// The total number of email messages assigned to the email address.
    public let numberOfEmailMessages: Int

    /// Version of this entity, increments on update.
    public let version: Int

    /// Email service timestamp to when the email address was created.
    public let createdAt: Date

    /// Email service timestamp to when the email address was last updated.
    public let updatedAt: Date

    /// Date when the email account received its last email message. `nil` if no messages received.
    public let lastReceivedAt: Date?

    /// An optional user defined alias name for the the email address.
    public let alias: String?

    /// Initialize an instance of `EmailAddress`.
    public init(
        id: String,
        owner: String,
        owners: [Owner],
        identityId: String,
        keyRingId: String,
        keyIds: [String],
        emailAddress: String,
        folders: [EmailFolder],
        size: Double,
        numberOfEmailMessages: Int,
        version: Int,
        createdAt: Date,
        updatedAt: Date,
        lastReceivedAt: Date?,
        alias: String?
    ) {
        self.id = id
        self.owner = owner
        self.owners = owners
        self.identityId = identityId
        self.keyRingId = keyRingId
        self.keyIds = keyIds
        self.emailAddress = emailAddress
        self.folders = folders
        self.size = size
        self.numberOfEmailMessages = numberOfEmailMessages
        self.version = version
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.lastReceivedAt = lastReceivedAt
        self.alias = alias
    }
}
