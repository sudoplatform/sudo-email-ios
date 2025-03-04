//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

class EmailAddressBlocklistUtil {
    static func generateAddressHash(plaintextAddress: String, prefix: String) throws -> String {
        return try StringHasher.hashString(stringToHash: "\(prefix)|\(plaintextAddress)")
    }
}
