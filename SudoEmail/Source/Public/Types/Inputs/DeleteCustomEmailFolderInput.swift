//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for deleting a custom EmailFolder

public struct DeleteCustomEmailFolderInput {

    /// The identifier of the custom EmailFolder to delete
    public var emailFolderId: String

    /// The email address id associated with the EmailFolder
    public var emailAddressId: String

    public init(emailFolderId: String, emailAddressId: String) {
        self.emailFolderId = emailFolderId
        self.emailAddressId = emailAddressId
    }
}
