//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Internal subscriber that listens for message deletion notifications
/// and removes the corresponding entries from the email message body cache.
class CacheInvalidationSubscriber: Subscriber {

    // MARK: - Properties

    private let cache: EmailMessageBodyCache

    // MARK: - Lifecycle

    init(cache: EmailMessageBodyCache) {
        self.cache = cache
    }

    // MARK: - Subscriber

    func notify(notification: SubscriptionNotification) {
        if case .messageDeleted(let message) = notification {
            Task {
                await cache.deleteMessage(messageId: message.id)
            }
        }
    }

    func connectionStatusChanged(state: SubscriptionConnectionState) {
        // No-op — we don't need to react to connection state changes
    }
}
