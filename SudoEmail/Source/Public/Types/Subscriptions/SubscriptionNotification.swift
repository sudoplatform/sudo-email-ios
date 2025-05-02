//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// The types of notifications that can be sent to `Subscriber` instances.
public enum SubscriptionNotification: Equatable {
    /// An email message has been updated.
    case messageCreated(EmailMessage)
    /// An email message has been updated.
    case messageUpdated(EmailMessage)
    /// An email message has been deleted.
    case messageDeleted(EmailMessage)
}
