//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// object defining the values to be set when updating email address metadata using `SudoEmailClient`
public struct UpdateEmailAddressMetadataValues: Equatable {

    /// display name associated with this email address
    public let displayName: String?

    public init(displayName: String?) {
        self.displayName = displayName
    }
}

/// input object for updating an email address' metadata using `SudoEmailClient`
public struct UpdateEmailAddressMetadataInput: Equatable {

    /// The unique identity of email address to update.
    public let id: String

    /// The values to update for the email address, including the display name.
    public let values: UpdateEmailAddressMetadataValues

    public init(id: String, values: UpdateEmailAddressMetadataValues) {
        self.id = id
        self.values = values
    }
}
