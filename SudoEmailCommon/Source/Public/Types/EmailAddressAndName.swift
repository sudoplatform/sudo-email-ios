//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct EmailAddressAndName: Equatable {
    public var address: String
    public var displayName: String?

    public init(address: String, displayName: String? = nil) {
        self.address = address
        self.displayName = displayName
    }
}
