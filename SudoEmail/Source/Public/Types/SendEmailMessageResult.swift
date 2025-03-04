//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Result type of an API call to send an email message
public struct SendEmailMessageResult {

    /// The unique identifier of the email message
    public var id: String

    /// The timestamp of when the email message was created
    public var createdAt: Date

    /// Initializes an instance of `SendEmailMessageResult`.
    ///
    /// - Parameters:
    ///   - id: The unique identifier of the email message.
    ///   - createdAt: The timestamp of when the email message was created,
    public init(id: String, createdAt: Date) {
        self.id = id
        self.createdAt = createdAt
    }
}
