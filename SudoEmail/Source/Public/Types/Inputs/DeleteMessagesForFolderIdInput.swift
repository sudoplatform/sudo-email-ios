//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for deleting all messages in a folder

public struct DeleteMessagesForFolderIdInput {

    /// folderId of the folder to delete messages from
    public var emailFolderId: String

    /// emailAddressId of the address that owns the folder
    public var emailAddressId: String

    /// If true (default), messages will be completely deleted. If false, messages will be moved to TRASH, unless the folder itself is TRASH.
    public var hardDelete: Bool?

    public init(emailFolderId: String, emailAddressId: String, hardDelete: Bool? = nil) {
        self.emailFolderId = emailFolderId
        self.emailAddressId = emailAddressId
        self.hardDelete = hardDelete
    }
}
