//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class for mananging subscription in the SDK to the service.
protocol SubscriptionManager: AnyObject {

    /// Add a subscription to the manager.
    func addSubscription(_ subscription: EmailSubscriptionToken)

    /// Remove a subscription which matches `id`.
    func removeSubscription(withId id: String)

    /// Remove all subscriptions from the manager.
    func removeAllSubscriptions()
}

/// Weak instance of an `EmailSubscriptionToken`.
class WeakEmailSubscriptionToken: Hashable {

    // MARK: - Properties

    /// Internal weak reference to the token.
    weak var value: EmailSubscriptionToken?

    /// Reference identifier.
    let id: String

    // MARK: - Lifecycle

    /// Initialize a Weak `EmailSubscriptionToken`.
    init(_ value: EmailSubscriptionToken) {
        self.id = value.id
        self.value = value
    }

    // MARK: - Methods

    /// If possible, cancels the internal weak reference. If the reference has already been lost, nothing will happen.
    func cancel() {
        value?.cancel()
    }

    // MARK: - Conformance: Equatable

    static func == (lhs: WeakEmailSubscriptionToken, rhs: WeakEmailSubscriptionToken) -> Bool {
        return lhs.value == rhs.value
    }

    // MARK: - Conformance: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}

/// Concrete implementation of the `SubscriptionManager`.
class DefaultSubscriptionManager: SubscriptionManager {

    // MARK: - Properties

    /// Queue to handle the mutation of `subscriptions` to avoid race conditions.
    let subscriptionQueue = DispatchQueue(label: "com.sudoplatform.DefaultSubscriptionManager")

    /// Set of unique subscriptions that are managed by this class.
    private(set) var subscriptions = Set<WeakEmailSubscriptionToken>()

    // MARK: - SubscriptionManager

    func addSubscription(_ subscription: EmailSubscriptionToken) {
        let weakSubscription = WeakEmailSubscriptionToken(subscription)
        subscriptionQueue.sync {
            _ = subscriptions.insert(weakSubscription)
        }
    }

    func removeSubscription(withId id: String) {
        subscriptionQueue.sync {
            guard let index = subscriptions.firstIndex(where: { $0.id == id }) else {
                return
            }
            let subscription = subscriptions.remove(at: index)
            subscription.cancel()
        }
    }

    func removeAllSubscriptions() {
        subscriptionQueue.sync {
            subscriptions.forEach { subscription in
                subscription.cancel()
            }
            subscriptions.removeAll()
        }
    }
}
