//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// The result of a successfull email message update
public struct UpdatedEmailMessageSuccess {
    
    /// The unique identifier of the email message
    public let id: String
    
    /// The date the message was created
    public let createdAt: Date
    
    /// The date the message was updated
    public let updatedAt: Date
}
