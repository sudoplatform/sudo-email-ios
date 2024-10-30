//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of an email folder business rule. Depicts the information of a user's email folder and related information.
public struct EmailFolderEntity: Equatable {

    /// Unique identifier of the email account.
    var id: String

    /// Unique identifier of the user that owns the email account.
    var owner: String

    /// The identifier and issuer of the owners of the email account.
    var owners: [OwnerEntity]

    /// Unique identifier of the email account that owns this folder.
    var emailAddressId: String

    /// Name of this folder
    var folderName: String

    /// The total size, in bytes, of all email messages assigned to the email folder.
    var size: Double

    /// The total count of unseen email messages assigned to the email folder.
    var unseenCount: Int

    /// An optional TTL signifying the number of seconds that email messages will remain before being deleted from the email folder.
    /// Currently unused.
    var ttl: Double?

    /// Version of this entity, increments on update.
    var version: Int

    /// Timestamp of when the folder was created on the service.
    var createdAt: Date

    /// Timestamp of when the folder was last updated on the service.
    var updatedAt: Date
    
    /// The custom name of the folder.
    var customFolderName: String?
}
