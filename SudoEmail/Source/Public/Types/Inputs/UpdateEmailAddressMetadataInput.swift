//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// object defining the values to be set when updating email address metadata using `SudoEmailClient`
public struct UpdateEmailAddressMetadataValues: Equatable {

    /// alias associated with this email address
    public let alias: String?

    public init(alias: String?) {
        self.alias = alias
    }
}

/// input object for updating an email address' metadata using `SudoEmailClient`
public struct UpdateEmailAddressMetadataInput: Equatable {

    /// The unique identity of email address to update.
    public let id: String

    /// An alias for the email address.
    public let values: UpdateEmailAddressMetadataValues

    public init(id: String, values: UpdateEmailAddressMetadataValues) {
        self.id = id
        self.values = values
    }
}
