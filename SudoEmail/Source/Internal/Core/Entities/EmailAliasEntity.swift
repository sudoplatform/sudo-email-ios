//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of an email alias business rule. Depicts the information of an email alias and related information.
struct EmailAliasEntity: Equatable {

    /// Unique identifier of the email alias.
    var id: String

    /// Unique identifier of the user that owns the email alias.
    var owner: String

    /// The identifier and issuer of the owners of the email alias.
    var owners: [OwnerEntity]

    /// Unique identifier of the identity of the email alias.
    var identityId: String

    /// Unique identifier of the key ring associated with the email alias.
    var keyRingId: String

    /// The publicly visible email address that serves as the alias.
    var aliasAddress: String

    /// The actual email address that receives forwarded messages.
    var realAddress: String

    /// The type of real address.
    var realAddressType: EmailAliasRealAddressTypeEntity

    /// The current status of the alias.
    var status: EmailAliasStatusEntity

    /// The total number of inbound messages received by this alias.
    var inboundReceived: Int

    /// The total number of inbound messages successfully delivered.
    var inboundDelivered: Int

    /// The total number of outbound messages received from this alias.
    var outboundReceived: Int

    /// The total number of outbound messages successfully delivered.
    var outboundDelivered: Int

    /// The number of messages identified as spam.
    var spamCount: Int

    /// The number of messages identified as containing viruses.
    var virusCount: Int

    /// Optional metadata associated with the email alias.
    var metadata: [String: String]?

    /// Optional expiration timestamp in seconds since epoch.
    var expiresAt: Date?

    /// Email service timestamp to when the email alias was created.
    var createdAt: Date

    /// Email service timestamp to when the email alias was last updated.
    var updatedAt: Date

    /// Version of this entity, increments on update.
    var version: Int
}

/// Core entity representation of email alias real address type.
enum EmailAliasRealAddressTypeEntity: String, Equatable {
    /// The real address is an internal Sudo Platform email address.
    case `internal` = "INTERNAL"

    /// The real address is an external email address.
    case external = "EXTERNAL"
}

/// Core entity representation of email alias status.
enum EmailAliasStatusEntity: String, Equatable {
    /// Alias is enabled and will be functional for forwarding emails.
    case enabled = "ENABLED"

    /// Alias is disabled and will not be functional for forwarding emails.
    case disabled = "DISABLED"

    /// Alias has been locked by admin or the system and cannot be used.
    case locked = "LOCKED"

    /// Alias is pending activation and not yet functional.
    case pending = "PENDING"
}
