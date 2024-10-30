//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct EmailFolder: Equatable {

    // MARK: - Properties

    /// Unique identifier of the email folder.
    public let id: String

    /// Identifier of the user that owns the email folder.
    public let owner: String

    /// List of owner identifiers and issuers associated with this email folder.
    public let owners: [Owner]

    /// Unique identifier of the email address associated with the email folder.
    public let emailAddressId: String

    /// Name assigned to the email folder, e.g. INBOX, SENT, TRASH, OUTBOX.
    public let folderName: String

    /// The total size, in bytes, of all email messages assigned to the email folder.
    public let size: Double

    /// The number of email messages in the folder that are yet to be seen by the user.
    public let unseenCount: Int

    /// An optional TTL signifying the number of seconds that email messages will remain before being deleted from the email folder.
    /// Currently unused.
    public let ttl: Double?

    /// Version of this entity, increments on update.
    public let version: Int

    /// Email service timestamp to when the email folder was created.
    public let createdAt: Date

    /// Email service timestamp to when the email folder was last updated.
    public let updatedAt: Date
    
    /// The custom name of the folder.
    var customFolderName: String?

    /// Initialize an instance of `EmailFolder`.
    public init(
        id: String,
        owner: String,
        owners: [Owner],
        emailAddressId: String,
        folderName: String,
        size: Double,
        unseenCount: Int,
        ttl: Double?,
        version: Int,
        createdAt: Date,
        updatedAt: Date,
        customFolderName: String?
    ) {
        self.id = id
        self.owner = owner
        self.owners = owners
        self.emailAddressId = emailAddressId
        self.folderName = folderName
        self.size = size
        self.unseenCount = unseenCount
        self.ttl = ttl
        self.version = version
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.customFolderName = customFolderName
    }
}
