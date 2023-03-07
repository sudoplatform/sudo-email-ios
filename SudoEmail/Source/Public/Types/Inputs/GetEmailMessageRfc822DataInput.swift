//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for getting an email message's RFC822 data using `SudoEmailClient`
public struct GetEmailMessageRfc822DataInput: Equatable {

    /// The unique identifier of email message to retrieve,.
    public let id: String

    /// Determines how the email address will be fetched. Default usage is `remoteOnly`.
    public let emailAddressId: String

    public init(id: String, emailAddressId: String) {
        self.id = id
        self.emailAddressId = emailAddressId
    }
}
