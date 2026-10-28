//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for deprovisioning an email alias using `SudoEmailClient`
public struct DeprovisionEmailAliasInput: Equatable {

    /// The unique identifier of email alias to deprovision
    public let emailAliasId: String

    public init(emailAliasId: String) {
        self.emailAliasId = emailAliasId
    }
}
