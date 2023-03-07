//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// object defining the values to be set when updating a list of email messages using `SudoEmailClient`
public struct UpdateEmailMessagesValues: Equatable {

    /// folderId of the folder associated with this message
    public let folderId: String?

    ///
    public let seen: Bool?

    public init(folderId: String?, seen: Bool?) {
        self.folderId = folderId
        self.seen = seen
    }
}

/// input object for updating a list of email messages using `SudoEmailClient`
public struct UpdateEmailMessagesInput: Equatable {

    /// the list of email message ids to update
    public let ids: [String]

    /// the values to set for each email message in the list
    public let values: UpdateEmailMessagesValues

    public init(ids: [String], values: UpdateEmailMessagesValues) {
        self.ids = ids
        self.values = values
    }
}
