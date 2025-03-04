//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of an email account business rule. Depicts the information of the user's account and related information.
struct EmailAccountEntity: Equatable {

    /// Unique identifier of the email account.
    var id: String

    /// Unique identifier of the user that owns the email account.
    var owner: String

    /// The identifier and issuer of the owners of the email account.
    var owners: [OwnerEntity]

    /// Unique identifier of the identity of the email account.
    var identityId: String

    /// Unique identifier of the key ring associated with the email account.
    var keyRingId: String

    /// Unique identifiers of the keys associated with the email account.
    var keyIds: [String]

    /// Email address associated with the account.
    var emailAddress: EmailAddressEntity

    /// The total size in bytes of all email messages assigned to the email account.
    var size: Double

    /// The total number of email messages assigned to the email account
    var numberOfEmailMessages: Int

    /// Version of this entity, increments on update.
    var version: Int

    /// Timestamp of when the account was created on the service.
    var createdAt: Date

    /// Timestamp of when the account was last updated on the service.
    var updatedAt: Date

    /// Date when the email account received its last email message. `nil` if no messages received.
    var lastReceivedAt: Date?

    /// The email folders associated with the email account.
    var folders: [EmailFolderEntity]
}
