//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for verifying an external email address using `SudoEmailClient`
public struct VerifyExternalEmailAddressInput: Equatable {

    /// The external email address to verify
    public let emailAddress: String

    /// The unique identifier of the email alias associated with this verification
    public let emailAliasId: String

    /// Optional verification code (if required by the verification flow)
    public let verificationCode: String?

    public init(emailAddress: String, emailAliasId: String, verificationCode: String? = nil) {
        self.emailAddress = emailAddress
        self.emailAliasId = emailAliasId
        self.verificationCode = verificationCode
    }
}
