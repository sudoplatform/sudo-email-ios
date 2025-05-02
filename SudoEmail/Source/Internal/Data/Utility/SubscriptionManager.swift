//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SudoApiClient
import SudoLogging

/// Manages the subscription lifecycle for GraphQL-based notifications.
///
/// This protocol allows components to subscribe to and unsubscribe from specific notification types
/// denoted by `SubscriptionNotificationType`. Each subscription is associated with a unique subscriber ID.
protocol SubscriptionManager {

    /// Subscribes a subscriber to receive notifications about changes related to a specific notification type.
    /// - Parameters:
    ///   - id: A unique identifier associated with the subscriber.
    ///   - notificationType: The type of notifications the subscriber wishes to receive.
    ///   - subscriber: The entity that will receive the notifications.
    ///   - owner: The unique identifier of the Sudo that owns the subscription.
    func subscribe(id: String, notificationType: SubscriptionNotificationType, subscriber: Subscriber, owner: String) async

    /// Unsubscribes a specific subscriber, preventing them from receiving further notifications.
    /// - Parameter id: The unique identifier of the subscriber to be removed.
    func unsubscribe(id: String) async

    /// Unsubscribes all subscribers, stopping all notifications related to distributed vaults and members.
    func unsubscribeAll() async
}

actor DefaultSubscriptionManager: SubscriptionManager {

    // MARK: - Supplementary

    /// Wraps a client subscription with an additional Bool property
    /// to keep track of whether the subscription has connected.
    struct Subscription {

        /// The underlying subscription.
        let value: GraphQLClientSubscription

        /// `true` if the subscription has connected, or `false` otherwise.
        var isConnected: Bool
    }

    /// Struct that holds a weak reference to a Subscriber instance.
    struct WeakSubscriber {

        /// The identifier of the subscriber.
        let id: String

        /// The type of notification the subscriber will be notified of.
        let notificationType: SubscriptionNotificationType

        /// Weak reference to the subscriber instance.
        weak var subscriber: Subscriber?
    }

    // MARK: - Properties

    /// GraphQL client for communicating with the Sudo  service.
    let graphQLClient: SudoApiClient

    /// Utility for decrypting email messages.
    let unsealer: EmailMessageUnsealerService

    /// A logging instance.
    let logger: SudoLogging.Logger

    /// Utility for transformer the GraphQL email message types to the common `SealedEmailMessageEntity`.
    let sealedMessageTransformer = SealedEmailMessageEntityTransformer()

    /// Utility for transformer the internal `SealedEmailMessageEntity` to the public `EmailMessage` type.
    let messageEntityTransformer = EmailMessageAPITransformer()

    /// An array of weakly held subscribers.
    var subscribers: [WeakSubscriber] = []

    /// A map of active subscriptions keyed by notification type.
    var subscriptions: [SubscriptionNotificationType: Subscription] = [:]

    // MARK: - Lifecycle

    init(graphQLClient: SudoApiClient, unsealer: EmailMessageUnsealerService, logger: SudoLogging.Logger) {
        self.graphQLClient = graphQLClient
        self.unsealer = unsealer
        self.logger = logger
    }

    // MARK: - Conformance: SubscriptionManager

    func subscribe(id: String, notificationType: SubscriptionNotificationType, subscriber: Subscriber, owner: String) {
        subscribers.removeAll(where: { $0.id == id && $0.notificationType == notificationType })
        subscribers.append(WeakSubscriber(id: id, notificationType: notificationType, subscriber: subscriber))
        cancelSubscriptionsIfRequired()

        if let existingSubscription = subscriptions[notificationType] {
            if existingSubscription.isConnected {
                subscriber.connectionStatusChanged(state: .connected)
            }
            return
        }
        switch notificationType {
        case .messageCreated:
            subscribe(subscription: GraphQL.OnEmailMessageCreatedSubscription(owner: owner), notificationType: notificationType)

        case .messageUpdated:
            subscribe(subscription: GraphQL.OnEmailMessageUpdatedSubscription(owner: owner), notificationType: notificationType)

        case .messageDeleted:
            subscribe(subscription: GraphQL.OnEmailMessageDeletedSubscription(owner: owner), notificationType: notificationType)
        }
    }

    func unsubscribe(id: String) async {
        subscribers.removeAll(where: { $0.id == id })
        cancelSubscriptionsIfRequired()
    }

    func unsubscribeAll() async {
        subscribers.removeAll()
        cancelSubscriptionsIfRequired()
    }

    // MARK: - Helpers

    func cancelSubscriptionsIfRequired() {
        let subscribedTypes = Set(subscribers.map(\.notificationType))
        let unsubscribedTypes = Set(SubscriptionNotificationType.allCases).subtracting(subscribedTypes)
        let removedSubscriptions = unsubscribedTypes.compactMap { subscriptions.removeValue(forKey: $0) }
        removedSubscriptions.forEach {
            $0.value.cancel()
        }
    }

    func subscribe<S: GraphQLSubscription>(
        subscription: S,
        notificationType: SubscriptionNotificationType
    ) where S.Data: GraphQLSubscriptionResult {
        let activeSubscription = graphQLClient.subscribe(
            subscription: subscription,
            statusChangeHandler: { [weak self] connectionState in
                guard let self, connectionState == .connected else { return }
                Task {
                    await self.updateSubscriptionIsConnected(true, forNotificationType: notificationType)
                    await self.notifySubscribers(connectionState: .connected, notificationType: notificationType)
                }
            },
            completionHandler: { [weak self] _ in
                guard let self else { return }
                Task {
                    await self.notifySubscribers(connectionState: .disconnected, notificationType: notificationType)
                    await self.unsubscribe(notificationType: notificationType)
                }
            },
            resultHandler: { [weak self] result in
                guard let self else { return }
                Task {
                    switch result {
                    case .success(let data):
                        await self.notifySubscribers(data, notificationType: notificationType)
                    case .failure:
                        break
                    }
                }
            }
        )
        subscriptions[notificationType] = Subscription(value: activeSubscription, isConnected: false)
    }

    func updateSubscriptionIsConnected(_ isConnected: Bool, forNotificationType notificationType: SubscriptionNotificationType) {
        subscriptions[notificationType]?.isConnected = isConnected
    }

    func unsubscribe(notificationType: SubscriptionNotificationType) {
        subscribers.removeAll(where: { $0.notificationType == notificationType })
        cancelSubscriptionsIfRequired()
    }

    func notifySubscribers(connectionState: SubscriptionConnectionState, notificationType: SubscriptionNotificationType) {
        let subscribersToNotify = subscribers.filter { $0.notificationType == notificationType }
        subscribersToNotify.forEach {
            $0.subscriber?.connectionStatusChanged(state: connectionState)
        }
    }

    func notifySubscribers<D: GraphQLSubscriptionResult>(_ data: D, notificationType: SubscriptionNotificationType) {
        let subscribersToNotify = subscribers.filter { $0.notificationType == notificationType }
        guard !subscribersToNotify.isEmpty, let notification = getNotification(from: data, notificationType: notificationType) else {
            return
        }
        subscribersToNotify.forEach {
            $0.subscriber?.notify(notification: notification)
        }
    }

    func getNotification<D: GraphQLSubscriptionResult>(
        from data: D,
        notificationType: SubscriptionNotificationType
    ) -> SubscriptionNotification? {
        var sealedMessage: SealedEmailMessageEntity?
        switch notificationType {
        case .messageCreated:
            if let createdData = data as? GraphQL.OnEmailMessageCreatedSubscription.Data,
               let graphQLEmailMessage = createdData.onEmailMessageCreated {
                sealedMessage = try? sealedMessageTransformer.transform(graphQLEmailMessage)
            }
        case .messageUpdated:
            if let updatedData = data as? GraphQL.OnEmailMessageUpdatedSubscription.Data,
               let graphQLEmailMessage = updatedData.onEmailMessageUpdated {
                sealedMessage = try? sealedMessageTransformer.transform(graphQLEmailMessage)
            }
        case .messageDeleted:
            if let deletedData = data as? GraphQL.OnEmailMessageDeletedSubscription.Data,
               let graphQLEmailMessage = deletedData.onEmailMessageDeleted {
                sealedMessage = try? sealedMessageTransformer.transform(graphQLEmailMessage)
            }
        }
        guard let sealedMessage else {
            logger.error("Failed to get sealed message from subscription notification type \(notificationType).")
            return nil
        }
        let emailMessageEntity: EmailMessageEntity
        do {
            emailMessageEntity = try unsealer.unsealEmailMessage(sealedMessage)
        } catch {
            logger.error("Failed to unseal message from subscription notification type \(notificationType): \(error.localizedDescription)")
            return nil
        }
        let emailMessage = messageEntityTransformer.transform(emailMessageEntity)
        switch notificationType {
        case .messageCreated:
            return .messageCreated(emailMessage)
        case .messageUpdated:
            return .messageUpdated(emailMessage)
        case .messageDeleted:
            return .messageDeleted(emailMessage)
        }
    }
}
