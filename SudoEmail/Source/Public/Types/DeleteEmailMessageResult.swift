//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// The result of a successful email message delete
public struct DeleteEmailMessageSuccessResult: Equatable {

    // MARK: - Properties

    /// The unique identifier of the deleted email message
    public let id: String

    // MARK: - Lifecycle

    /// Initialize an instance of `DeleteEmailMessageSuccessResult`
    public init(id: String) {
        self.id = id
    }
}
