//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct EmailAddressEntityTransformer {

    /// Transform a `String` email formatted as `localPart@domain`.
    func transform(_ address: String) throws -> EmailAddressEntity {
        let rfc822parts = address.split(separator: "<").map(String.init)
        var displayName: String?
        var rfc822Address: String
        if rfc822parts.count > 1 {
            displayName = rfc822parts[0].trimmingCharacters(in: .whitespacesAndNewlines)
            if rfc822parts[1].hasSuffix(">") {
                rfc822Address = String(rfc822parts[1].dropLast())
            } else {
                throw SudoEmailError.internalError("Unsupported email address: \(address)")
            }
        } else {
            rfc822Address = address
        }
        let parts = rfc822Address.split(separator: "@").map(String.init)
        guard parts.count == 2 else {
            throw SudoEmailError.internalError("Unsupported email address: \(address)")
        }
        return EmailAddressEntity(localPart: parts[0], domain: parts[1], displayName: displayName)
    }
}
