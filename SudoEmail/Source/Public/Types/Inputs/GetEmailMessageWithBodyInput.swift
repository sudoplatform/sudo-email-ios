//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

///Input object containing an email message identifier and email address identifier used to retrieve the email message data.
public struct GetEmailMessageWithBodyInput: Equatable {

    /// Identifier of the email message body data to be retrieved.
    public let id: String

    /// Identifier of the email address associated with the email message.
    public let emailAddressId: String

    public init(id: String, emailAddressId: String) {
        self.id = id
        self.emailAddressId = emailAddressId
    }
}
