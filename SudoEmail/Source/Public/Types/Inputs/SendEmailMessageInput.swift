//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for sending an email message using `SudoEmailClient`
public struct SendEmailMessageInput: Equatable {

    /// rfc822Data Email message data formatted under the RFC 6854.
    ///   Some further rules (beyond RFC 6854) must also be applied to the data:
    ///     - At least one recipient must exist (to, cc, bcc).
    ///     - For all email addresses:
    ///       - Total length (including both local part and domain) must not exceed 256 characters.
    ///       - Local part must not exceed more than 64 characters.
    ///       - Input domain parts (domain separated by `.`) must not exceed 63 characters.
    ///       - Address must match standard email address pattern:
    ///         `^[a-zA-Z0-9](\.?[-_a-zA-Z0-9])*@[a-zA-Z0-9](-*\.?[a-zA-Z0-9])*\.[a-zA-Z](-?[a-zA-Z0-9])+$`.
    public let rfc822Data: Data

    /// senderEmailAddressId The identifier of the email address used to send the email. The identifier
    ///  must match the identifier of the email address of the `from` field in the RFC 6854 data.
    public let senderEmailAddressId: String

    public init(rfc822Data: Data, senderEmailAddressId: String) {
        self.rfc822Data = rfc822Data
        self.senderEmailAddressId = senderEmailAddressId
    }
}
