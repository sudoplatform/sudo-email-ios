//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

enum EmailAddressParser {
    // swiftlint:disable:next force_try
    private static let regex = try! NSRegularExpression(pattern: "^[\\S]+@[\\S]+\\.[\\S]+$", options: [])

    static func normalize(address: String) throws -> String {
        let parts = address.lowercased().split(separator: "@").map(String.init)

        guard parts.count <= 2 else {
            throw SudoEmailError.internalError("Unsupported email address: \(address)")
        }

        if parts.count == 1 {
            return parts[0]
        } else {
            return "\(parts[0])@\(parts[1])"
        }
    }

    static func getDomain(email: String) -> String {
        let parts = email.lowercased().split(separator: "@", maxSplits: 1)
        return parts.count == 2 ? String(parts[1]) : ""
    }

    static func validate(email: String) -> Bool {
        if email.count > 256 {
            return false
        }

        let range = NSRange(location: 0, length: email.utf16.count)
        if regex.firstMatch(in: email, options: [], range: range) == nil {
            return false
        }

        let parts = email.split(separator: "@", maxSplits: 1)
        guard parts.count == 2 else { return false }

        let localPart = parts[0]
        let address = parts[1]

        if localPart.count > 64 {
            return false
        }

        if address.isEmpty {
            return false
        }

        let domainParts = address.split(separator: ".")
        if domainParts.contains(where: { $0.count > 63 }) {
            return false
        }

        return true
    }
}
