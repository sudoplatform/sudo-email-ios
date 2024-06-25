//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

struct EmailAddressDisplay: Decodable {
    var emailAddress: String
    var displayName: String?
}

struct Rfc822Header: Decodable {
    var from: [EmailAddressDisplay]
    var to: [EmailAddressDisplay]
    var cc: [EmailAddressDisplay]
    var bcc: [EmailAddressDisplay]
    var replyTo: [EmailAddressDisplay]
    var subject: String?
    var hasAttachments: Bool?
    /// Will be sent in formate: 1970-01-01T00:00:00.000Z
    var date: Date?
}

class EmailRFC822HeaderCodec {

    func decode(header: String) throws -> Rfc822Header {
        guard let headerData = header.data(using: .utf8) else {
            throw SudoEmailError.internalError("invalid rfc822Header format \(header)")
        }
        do {
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            decoder.dateDecodingStrategy = .formatted(formatter)
            return try decoder.decode(Rfc822Header.self, from: headerData)
        } catch {
            throw SudoEmailError.internalError("invalid rfc822Header format \(header)")
        }
    }
}
