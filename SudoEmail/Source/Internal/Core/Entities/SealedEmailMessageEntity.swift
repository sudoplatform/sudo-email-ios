//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

struct SealedEmailMessageEntity {

    // MARK: - Properties: Unsealed Attributes

    /// Unique identifier of the email message. Combination of the `messageId` and the `keyId`.
    ///
    /// E.g. `\(messageId)-\(keyId)`
    var id: String

    /// Unique identitfier of the message itself. All sealed copies of the message share this id.
    var messageId: String

    /// Unique identifier of the user of the email message.
    var userId: String

    /// Unique identifier of the sudo of the email message.
    var sudoId: String

    /// Email address identifier that is associated with the account of the email message.
    ///
    /// This is the id of the account that sent/received this message.
    var emailAddressId: String

    /// Unique identifier associated with this entity for its key encryption/decryption.
    var keyId: String

    /// Algorithm used to encrypt/decrypt this entity.
    var algorithm: String

    /// Unique client reference identifier.
    var clientRefId: String?

    /// Date timestamp when the email message was created on the service.
    var created: Date

    /// Date timestamp when the email message was last updated on the service.
    var updated: Date

    /// True if the user has seen the email message previously.
    var seen: Bool

    /// Direction of the email message.
    var direction: DirectionEntity

    /// State of the email message.
    var state: StateEntity

    // MARK: - Properties: Sealed Attributes

    /// SEALED - Array of from recipients of the email message.
    var from: [String]

    /// SEALED - Array of replyTo recipients of the email message.
    var replyTo: [String]

    /// SEALED - Array of to recipients of the email message.
    var to: [String]

    /// SEALED - Array of carbon copy recipients of the email message.
    var cc: [String]

    /// SEALED - Array of blind carbon copy recipients of the email message.
    var bcc: [String]

    /// SEALED - Subject header of the email message.
    var subject: String?
}
