//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Result of verifying an external email address
public struct VerifyExternalEmailAddressResult: Equatable {

    /// Indicates whether the email address was successfully verified
    public let isVerified: Bool

    /// Optional reason for verification failure or additional information
    public let reason: String?

    public init(isVerified: Bool, reason: String? = nil) {
        self.isVerified = isVerified
        self.reason = reason
    }
}
