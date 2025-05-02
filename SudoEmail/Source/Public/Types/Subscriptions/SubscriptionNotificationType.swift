//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// The types of notifications that `Subscriber` instances can subscribe to.
public enum SubscriptionNotificationType: Equatable, CaseIterable {
    /// Sent when an email message is created.
    case messageCreated
    /// Sent when an email message is updated.
    case messageUpdated
    /// Sent when an email message  is deleted.
    case messageDeleted
}
