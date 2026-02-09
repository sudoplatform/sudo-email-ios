//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for updating an email mask using `SudoEmailClient`
public struct UpdateEmailMaskInput: Equatable {

    /// The unique identifier of email mask to deprovision
    public let emailMaskId: String

    /// Optional name/value pair metadata to associated with the email mask. Provide the empty
    /// map to clear existing metadata.
    public let metadata: [String: String]?

    /// Optional expiration date for the email mask. Provide a date of 0 to clear existing expiration.
    public let expiresAt: Date?

    public init(emailMaskId: String, metadata: [String: String]? = nil, expiresAt: Date? = nil) {
        self.emailMaskId = emailMaskId
        self.metadata = metadata
        self.expiresAt = expiresAt
    }
}
