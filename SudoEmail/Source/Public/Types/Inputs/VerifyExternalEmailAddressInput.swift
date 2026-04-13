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

    /// The unique identifier of the email mask associated with this verification
    public let emailMaskId: String

    /// Optional verification code (if required by the verification flow)
    public let verificationCode: String?

    public init(emailAddress: String, emailMaskId: String, verificationCode: String? = nil) {
        self.emailAddress = emailAddress
        self.emailMaskId = emailMaskId
        self.verificationCode = verificationCode
    }
}
