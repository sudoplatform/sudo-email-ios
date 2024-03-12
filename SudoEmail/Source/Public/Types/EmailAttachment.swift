//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct EmailAttachment {
    
    // MARK: - Properties
    
    /// The name of the email attachment file.
    var filename: String
    
    /// Identifier used to identify an attachment within an email body.
    var contentId: String?
    
    /// The type of content that is attached.
    var mimetype: String
    
    /// Flag indicating whether this is an inline attachment or not.
    var inlineAttachment: Bool
    
    /// The email attachment data as a base64 encoded string.
    var data: String
}
