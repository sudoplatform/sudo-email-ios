//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import MailCore

extension MCOMessageParser {
    func isPlaintext() -> Bool {
        if let mainPart = mainPart(), mainPart is MCOMessagePart || mainPart is MCOAttachment, let mime = mainPart.mimeType {
            return mime == "text/plain"
        }
        return false
    }
}
