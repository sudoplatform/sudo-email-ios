//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for enabling an email alias using `SudoEmailClient`
public struct EnableEmailAliasInput: Equatable {

    /// The unique identifier of email alias to enable
    public let emailAliasId: String

    public init(emailAliasId: String) {
        self.emailAliasId = emailAliasId
    }
}
