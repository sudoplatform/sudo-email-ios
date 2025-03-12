//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
/// Representation of the email headers formatted under the RFC-6854 (supersedes RFC 822) standard.
/// Some further rules (beyond RFC 6854) must also be applied to the data:
///   - At least one recipient must exist (to, cc, bcc).
///   - For all email addresses:
///     - Total length (including both local part and domain) must not exceed 256 characters.
///     - Local part must not exceed more than 64 characters.
///     - Input domain parts (domain separated by `.`) must not exceed 63 characters.
///     - Address must match standard email address pattern:
///        `^[a-zA-Z0-9](\.?[-_a-zA-Z0-9])*@[a-zA-Z0-9](-*\.?[a-zA-Z0-9])*\.[a-zA-Z](-?[a-zA-Z0-9])+$`.
public struct InternetMessageFormatHeader: Equatable {

    /// The email address belonging to the sender.
    public let from: EmailAddressAndName

    /// The email addresses belonging to the primary recipients.
    public let to: [EmailAddressAndName]

    /// The email addresses belonging to the secondary recipients.
    public let cc: [EmailAddressAndName]

    /// The email addresses belonging to additional recipients.
    public let bcc: [EmailAddressAndName]

    /// The email addresses in which responses are to be sent.
    public let replyTo: [EmailAddressAndName]

    /// The subject line of the email message.
    public let subject: String

    /// Initialize an instance of `InternetMessageFormatHeader`.
    public init(
        from: EmailAddressAndName,
        to: [EmailAddressAndName] = [],
        cc: [EmailAddressAndName] = [],
        bcc: [EmailAddressAndName] = [],
        replyTo: [EmailAddressAndName] = [],
        subject: String
    ) {
        self.from = from
        self.to = to
        self.cc = cc
        self.bcc = bcc
        self.replyTo = replyTo
        self.subject = subject
    }
}
