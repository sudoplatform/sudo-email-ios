//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for deprovisioning an email mask using `SudoEmailClient`
public struct DeprovisionEmailMaskInput: Equatable {

    /// The unique identifier of email mask to deprovision
    public let emailMaskId: String

    public init(emailMaskId: String) {
        self.emailMaskId = emailMaskId
    }
}
