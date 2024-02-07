//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

class EmailAddressParser {
    static func normalize(address: String) throws -> String {
        let parts = address.lowercased().split(separator: "@").map(String.init)
        
        guard parts.count <= 2 else {
            throw SudoEmailError.internalError("Unsupported email address: \(address)")
        }
        
        if(parts.count == 1) {
            return parts[0]
        } else {
            return "\(parts[0])@\(parts[1])"
        }
    }
}
