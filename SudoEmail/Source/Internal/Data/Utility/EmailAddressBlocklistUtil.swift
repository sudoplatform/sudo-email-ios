//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

class EmailAddressBlocklistUtil {
    static func generateAddressHash(plaintextAddress: String, ownerId: String) throws -> String {
        return try StringHasher.hashString(stringToHash: "\(ownerId)|\(plaintextAddress)")
    }
}
