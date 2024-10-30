//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for creating a custom EmailFolder

public struct CreateCustomEmailFolderInput {
    
    /// The email address id associated with the EmailFolder
    public var emailAddressId: String
    
    /// The name of the custom EmailFolder
    public var customFolderName: String
    
    public init(emailAddressId: String, customFolderName: String) {
        self.emailAddressId = emailAddressId
        self.customFolderName = customFolderName
    }
}
