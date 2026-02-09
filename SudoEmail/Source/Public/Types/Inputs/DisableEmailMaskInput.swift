//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for disabling an email mask using `SudoEmailClient`
public struct DisableEmailMaskInput: Equatable {

    /// The unique identifier of email mask to disable
    public let emailMaskId: String

    public init(emailMaskId: String) {
        self.emailMaskId = emailMaskId
    }
}
