//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Thrown by `SudoEmailClient.deprovisionEmailAddress(_:)` when the service deprovisioned the email address, but
/// some of its key pairs couldn't be removed from the device.
///
/// Treat the email address as deprovisioned. The key pairs stay on the device until `reset()`.
public struct KeyPairRemovalFailedError: Error, Equatable, LocalizedError, Sendable {

    // MARK: - Properties

    /// The email address that was deprovisioned.
    public let emailAddress: EmailAddress

    /// Identifiers of the key pairs that couldn't be removed from the device.
    public let keyIds: [String]

    // MARK: - LocalizedError

    public var errorDescription: String? {
        "Email address \(emailAddress.id) was deprovisioned, but removing its key pairs from the device failed"
    }

    // MARK: - Lifecycle

    /// Create the error.
    /// - Parameters:
    ///   - emailAddress: The email address that was deprovisioned.
    ///   - keyIds: Identifiers of the key pairs that couldn't be removed from the device.
    public init(emailAddress: EmailAddress, keyIds: [String]) {
        self.emailAddress = emailAddress
        self.keyIds = keyIds
    }
}
