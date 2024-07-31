//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct EmailAddressAndName: Equatable, CustomStringConvertible {
    
    // MARK: - Properties
    
    /// The email address in the format `local-part@domain.com`
    public var address: String
    
    /// Optional display name for the address
    public var displayName: String?
    
    public var description: String {
        if let displayName = displayName, !displayName.isEmpty {
            return "\(displayName) <\(address)>"
        } else {
            return address
        }
    }

    public init(address: String, displayName: String? = nil) {
        self.address = address
        self.displayName = displayName
    }
}
