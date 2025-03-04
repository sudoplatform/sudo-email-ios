//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// object defining the values to be set when updating a custom email address using `SudoEmailClient`
public struct UpdateCustomEmailFolderValues: Equatable {

    /// custom name of the email folder
    public let customFolderName: String?

    public init(customFolderName: String?) {
        self.customFolderName = customFolderName
    }
}

/// input object for updating a custom email folder using `SudoEmailClient`
public struct UpdateCustomEmailFolderInput: Equatable {

    /// The identifier of the custom email folder to update.
    public let emailFolderId: String

    /// The identifier of the email address associated with the email folder
    public let emailAddressId: String

    /// The values to update
    public let values: UpdateCustomEmailFolderValues

    public init(emailFolderId: String, emailAddressId: String, values: UpdateCustomEmailFolderValues) {
        self.emailFolderId = emailFolderId
        self.emailAddressId = emailAddressId
        self.values = values
    }
}
