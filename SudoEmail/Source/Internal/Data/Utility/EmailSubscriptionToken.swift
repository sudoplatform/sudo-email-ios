//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSAppSync
import Foundation

/// Internal subscription token for handling the state of a subscription.
class EmailSubscriptionToken: SubscriptionToken, Hashable {

    // MARK: - Properties

    /// Unique identifier of the subscription. Used to cancel/remove from the manager.
    let id: String

    /// Strong reference of AWSAppSync subscription cancellable.
    private(set) var subscriptionReference: Cancellable?

    /// Reference to the manager to remove itself on cancel/deinitialization.
    weak var manager: SubscriptionManager?

    // MARK: - Lifecycle

    /// Initialize an instance of `EmailSubscriptionToken`.
    init(id: String = UUID().uuidString, cancellable: Cancellable, manager: SubscriptionManager) {
        self.id = id
        subscriptionReference = cancellable
        self.manager = manager
        manager.addSubscription(self)
    }

    /// Remove and cancel subscription on deinitialization.
    deinit {
        manager?.removeSubscription(withId: id)
        cancel()
    }

    // MARK: - SubscriptionToken

    func cancel() {
        subscriptionReference?.cancel()
        subscriptionReference = nil
    }

    // MARK: - Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // MARK: - Equatable

    static func == (lhs: EmailSubscriptionToken, rhs: EmailSubscriptionToken) -> Bool {
        return lhs.id == rhs.id
    }
}
