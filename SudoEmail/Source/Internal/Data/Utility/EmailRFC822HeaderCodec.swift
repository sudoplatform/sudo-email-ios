//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
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
}

class EmailRFC822HeaderCodec {

    func decode(header: String) throws -> Rfc822Header {
        guard let headerData = header.data(using: .utf8) else {
            throw SudoEmailError.internalError("invalid rfc822Header format \(header)")
        }
        do {
            return try JSONDecoder().decode(Rfc822Header.self, from: headerData)
        } catch {
            throw SudoEmailError.internalError("invalid rfc822Header format \(header)")
        }
    }
}
