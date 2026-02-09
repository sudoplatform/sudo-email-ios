//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for enabling an email mask using `SudoEmailClient`
public struct EnableEmailMaskInput: Equatable {

    /// The unique identifier of email mask to enable
    public let emailMaskId: String

    public init(emailMaskId: String) {
        self.emailMaskId = emailMaskId
    }
}
