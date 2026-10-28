//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for updating an email alias using `SudoEmailClient`
public struct UpdateEmailAliasInput: Equatable {

    /// The unique identifier of email alias to deprovision
    public let emailAliasId: String

    /// Optional name/value pair metadata to associated with the email alias. Provide the empty
    /// map to clear existing metadata.
    public let metadata: [String: String]?

    /// Optional expiration date for the email alias. Provide a date of 0 to clear existing expiration.
    public let expiresAt: Date?

    /// Optional real email address for the email alias. Only valid for external aliases in a pending state. Intended for the
    /// use case of accidentally inputting the wrong external address.
    public let realAddress: String?

    public init(emailAliasId: String, metadata: [String: String]? = nil, expiresAt: Date? = nil, realAddress: String? = nil) {
        self.emailAliasId = emailAliasId
        self.metadata = metadata
        self.expiresAt = expiresAt
        self.realAddress = realAddress
    }
}
