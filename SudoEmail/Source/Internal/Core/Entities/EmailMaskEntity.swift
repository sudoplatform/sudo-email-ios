//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of an email mask business rule. Depicts the information of an email mask and related information.
struct EmailMaskEntity: Equatable {

    /// Unique identifier of the email mask.
    var id: String

    /// Unique identifier of the user that owns the email mask.
    var owner: String

    /// The identifier and issuer of the owners of the email mask.
    var owners: [OwnerEntity]

    /// Unique identifier of the identity of the email mask.
    var identityId: String

    /// The publicly visible email address that serves as the mask.
    var maskAddress: String

    /// The actual email address that receives forwarded messages.
    var realAddress: String

    /// The type of real address.
    var realAddressType: EmailMaskRealAddressTypeEntity

    /// The current status of the mask.
    var status: EmailMaskStatusEntity

    /// The total number of inbound messages received by this mask.
    var inboundReceived: Int

    /// The total number of inbound messages successfully delivered.
    var inboundDelivered: Int

    /// The total number of outbound messages received from this mask.
    var outboundReceived: Int

    /// The total number of outbound messages successfully delivered.
    var outboundDelivered: Int

    /// The number of messages identified as spam.
    var spamCount: Int

    /// The number of messages identified as containing viruses.
    var virusCount: Int

    /// Optional metadata associated with the email mask.
    var metadata: [String: String]?

    /// Optional expiration timestamp in seconds since epoch.
    var expiresAt: Date?

    /// Email service timestamp to when the email mask was created.
    var createdAt: Date

    /// Email service timestamp to when the email mask was last updated.
    var updatedAt: Date

    /// Version of this entity, increments on update.
    var version: Int
}

/// Core entity representation of email mask real address type.
enum EmailMaskRealAddressTypeEntity: String, Equatable {
    /// The real address is an internal Sudo Platform email address.
    case `internal` = "INTERNAL"

    /// The real address is an external email address.
    case external = "EXTERNAL"
}

/// Core entity representation of email mask status.
enum EmailMaskStatusEntity: String, Equatable {
    /// Mask is enabled and will be functional for forwarding emails.
    case enabled = "ENABLED"

    /// Mask is disabled and will not be functional for forwarding emails.
    case disabled = "DISABLED"

    /// Mask has been locked by admin or the system and cannot be used.
    case locked = "LOCKED"

    /// Mask is pending activation and not yet functional.
    case pending = "PENDING"
}
