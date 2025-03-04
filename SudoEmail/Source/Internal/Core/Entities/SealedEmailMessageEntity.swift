//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

struct SealedEmailMessageEntity {

    // MARK: - Properties: Unsealed Attributes

    /// Unique identifier of the email message. Combination of the `messageId` and the `keyId`.
    ///
    /// E.g. `\(messageId)-\(keyId)`
    var id: String

    /// Identifier of the user that owns the email message.
    var owner: String

    /// List of identifiers of user/accounts associated with this email message.
    var owners: [OwnerEntity]

    /// Email address identifier that is associated with the account of the email message.
    ///
    /// This is the id of the account that sent/received this message.
    var emailAddressId: String

    /// Unique identifier of the associated decryption/encryption key.
    var keyId: String

    /// Algorithm used to decrypt/encrypt this entity.
    var algorithm: String

    /// Unique identifier of the email folder which the message resource is assigned to.
    var folderId: String

    /// Unique identifier of the previous email folder which the message resource was assigned to, if any.
    var previousFolderId: String?

    /// Direction of the email message.
    var direction: DirectionEntity

    /// True if the user has seen the email message previously.
    var seen: Bool

    /// True if the email message has been replied to.
    var repliedTo: Bool

    /// True if the email message has been forwarded.
    var forwarded: Bool

    /// State of the email message.
    var state: StateEntity

    /// Unique client reference identifier.
    var clientRefId: String?

    /// Version of this entity, increments on update.
    var version: Int

    /// Date when the email message was processed by the service.
    var sortDate: Date

    /// Date timestamp when the email message was created on the service.
    var createdAt: Date

    /// Date timestamp when the email message was last updated on the service.
    var updatedAt: Date

    /// Size, in bytes, of this email message
    var size: Double

    /// The encryption status of the message
    var encryptionStatus: EncryptionStatus

    // MARK: - Properties: Sealed Attributes

    /// SEALED - RFC 822 header data for the email message. Contains the recipients and subject matter.
    var rfc822Header: String
}
