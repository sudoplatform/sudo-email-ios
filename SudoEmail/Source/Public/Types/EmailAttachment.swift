//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct EmailAttachment: Hashable, Equatable {
    
    // MARK: - Properties

    /// The name of the email attachment file.
    public let filename: String
    
    /// Identifier used to identify an attachment within an email body.
    public let contentId: String?
    
    /// The type of content that is attached.
    public let mimetype: String
    
    /// Flag indicating whether this is an inline attachment or not.
    public let inlineAttachment: Bool
    
    /// The data of the email attachment.
    public let data: Data

    /// Instantiate an instance of `EmailAttachment`.
    public init(filename: String, contentId: String? = nil, mimetype: String, inlineAttachment: Bool, data: Data) {
        self.filename = filename
        self.contentId = contentId
        self.mimetype = mimetype
        self.inlineAttachment = inlineAttachment
        self.data = data
    }

    // MARK: - Conformance: Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(filename)
        hasher.combine(contentId)
        hasher.combine(mimetype)
        hasher.combine(inlineAttachment)
        hasher.combine(data)
    }
}
