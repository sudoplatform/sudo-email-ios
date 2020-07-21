//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

struct SealedEmailMessageEntity {

    // MARK: - Properties: Unsealed Attributes

    /// Unique identifier of the email message.
    var id: String

    /// Unique identifier associated with this entity for its key encryption/decryption.
    var keyId: String

    /// Algorithm used to encrypt/decrypt this entity.
    var algorithm: String

    /// Unique identifier used for identifying where the message RFC822 is stored.
    var sealedId: String

    /// Unique client reference identifier.
    var clientRefId: String?

    /// Unique identifier of the owner of the email message.
    var owner: String

    /// Date timestamp when the email message was created on the service.
    var created: Date

    /// Date timestamp when the email message was last updated on the service.
    var updated: Date

    /// Email address that is associated with the account of the email message - which account sent/received this message.
    var accountAddress: EmailAddressEntity

    /// True if the user has seen the email message previously.
    var seen: Bool

    /// Direction of the email message.
    var direction: DirectionEntity

    /// State of the email message.
    var state: StateEntity

    // MARK: - Properties: Sealed Attributes

    /// SEALED - Array of from recipients of the email message.
    var from: [String]

    /// SEALED - Array of to recipients of the email message.
    var to: [String]

    /// SEALED - Array of carbon copy recipients of the email message.
    var cc: [String]

    /// SEALED - Array of blind carbon copy recipients of the email message.
    var bcc: [String]

    /// SEALED - Subject header of the email message.
    var subject: String?
}
