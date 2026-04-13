//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a verify external email address result.
struct VerifyExternalEmailAddressResultEntity: Equatable {

    /// Indicates whether the email address was successfully verified
    let isVerified: Bool

    /// Optional reason for verification failure or additional information
    let reason: String?
}
