//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for getting an email message using `SudoEmailClient`
public struct GetEmailMessageInput: Equatable {

    /// The unique identifier of email message to retrieve.
    public let id: String

    public init(id: String) {
        self.id = id
    }
}
