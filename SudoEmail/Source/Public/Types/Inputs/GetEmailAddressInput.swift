//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for getting an email address using `SudoEmailClient`
public struct GetEmailAddressInput: Equatable {

    /// The unique identifier of email address to retrieve,.
    public let id: String

    public init(id: String) {
        self.id = id
    }
}
