//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import CryptoKit

class StringHasher {
    static func hashString(stringToHash: String, algorithm: String = "SHA256") throws -> String {
        if let data = stringToHash.data(using: .utf8) {
            switch algorithm {
            case "SHA256":
                let hash = SHA256.hash(data: data)
                let hashData = Data(hash)
                return hashData.base64EncodedString()
                
            default:
                throw SudoEmailError.internalError("Invalid hash algorithm")
            }
        } else {
            throw SudoEmailError.internalError("Invalid string")
        }
    }
}
