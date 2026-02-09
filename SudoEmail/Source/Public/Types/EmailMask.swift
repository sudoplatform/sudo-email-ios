//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of an Email Mask used in Sudo Email SDK.
public struct EmailMask: Equatable {

    public enum EmailMaskStatus: Equatable {
        /// Mask is enabled and will be functional for forwarding emails.
        case enabled

        /// Mask is disabled and will not be functional for forwarding emails.
        case disabled

        /// Mask has been locked by admin or the system and cannot be used..
        case locked

        /// Mask has been created but is pending confirmation (external masks only).
        case pending
    }

    public enum RealAddressType: Equatable {
        /// The real address is a Sudo Email Address.
        case `internal`

        /// The real address is an external email address.
        case external
    }

    /// Unique identifier of the email mask
    public let id: String

    /// Identifier of the user that owns the email mask
    public let owner: String

    /// List of owner identifiers and issuers associated with this email mask.
    public let owners: [Owner]

    /// Unique identifier of the identity associated with the email mask.
    public let identityId: String

    /// The publicly visible email address that serves as the mask
    public let maskAddress: String

    /// The actual email address that receives forwarded messages
    public let realAddress: String

    /// The type of real address
    public let realAddressType: RealAddressType

    /// The current status of the mask
    public let status: EmailMaskStatus

    /// The total number of inbound messages received by this mask
    public let inboundReceived: Int

    /// The total number of inbound messages successfully delivered
    public let inboundDelivered: Int

    /// The total number of outbound messages received from this mask
    public let outboundReceived: Int

    /// The total number of outbound messages successfully delivered
    public let outboundDelivered: Int

    /// The number of messages identified as spam
    public let spamCount: Int

    /// The number of messages identified as containing viruses
    public let virusCount: Int

    /// Email service timestamp to when the email mask was created.
    public let createdAt: Date

    /// Email service timestamp to when the email mask was last updated.
    public let updatedAt: Date

    /// Email service timestamp to when the email mask will expire, if applicable
    public let expiresAt: Date?

    /// The version number of the mask
    public let version: Int

    /// Optional name/value pair metadata associated with the email mask.
    public let metadata: [String: String]?

    public init(
        id: String,
        owner: String,
        owners: [Owner],
        identityId: String,
        maskAddress: String,
        realAddress: String,
        realAddressType: RealAddressType,
        status: EmailMaskStatus,
        inboundReceived: Int,
        inboundDelivered: Int,
        outboundReceived: Int,
        outboundDelivered: Int,
        spamCount: Int,
        virusCount: Int,
        createdAt: Date,
        updatedAt: Date,
        version: Int,
        expiresAt: Date? = nil,
        metadata: [String: String]? = nil
    ) {
        self.id = id
        self.owner = owner
        self.owners = owners
        self.identityId = identityId
        self.maskAddress = maskAddress
        self.realAddress = realAddress
        self.realAddressType = realAddressType
        self.status = status
        self.inboundReceived = inboundReceived
        self.inboundDelivered = inboundDelivered
        self.outboundReceived = outboundReceived
        self.outboundDelivered = outboundDelivered
        self.spamCount = spamCount
        self.virusCount = virusCount
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.version = version
        self.expiresAt = expiresAt
        self.metadata = metadata
    }
}
