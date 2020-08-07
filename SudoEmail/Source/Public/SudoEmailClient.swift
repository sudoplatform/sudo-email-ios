//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SudoUser
import SudoLogging
import SudoProfiles

/// Generic type associated with API completion/closures. Generic type O is the expected output result in a
/// success case.
public typealias ClientCompletion<O> = (Swift.Result<O, Error>) -> Void

/// Client used to interface with the Sudo Email Platform service.
///
/// It is recommended to code to this interface, rather than the implementation class (`DefaultSudoEmailClient`) as
/// the implementation class is only meant to be used for initializing an instance of the client.
public protocol SudoEmailClient: class {

    // MARK: - Lifecycle

    /// Removes all keys associated with this client, resets any cached data, cleans up subscriptions, and purges any pending operations.
    ///
    /// It is important to note that this will clear ALL cached data related to all
    /// sudo services.
    func reset() throws

    // MARK: - Mutations

    /// Provision an email address.
    /// - Parameters:
    ///   - emailAddress: Email address to provision.
    ///   - sudoId: Identifier of the sudo to provision email with.
    /// - Returns:
    ///   - Success: Successfully provisioned email.
    ///   - Failure: `SudoEmailError`.
    func provisionEmailAddress(_ emailAddress: String, sudoId: String, completion: @escaping ClientCompletion<EmailAddress>)

    /// Deprovision an email address.
    /// - Parameters:
    ///   - emailAddress: Email address to be deprovisioned.
    /// - Returns:
    ///   - Success: Successfully deprovisioned email.
    ///   - Failure: `SudoEmailError`.
    func deprovisionEmailAddress(_ emailAddress: String, completion: @escaping ClientCompletion<EmailAddress>)

    /// Send an email message using [RFC-822](https://tools.ietf.org/html/rfc822) data.
    /// - Parameters:
    ///   - data: Data formatted under the [RFC-822](https://tools.ietf.org/html/rfc822) standard.
    ///   - senderEmailAddress: email address being used to send the email. The address must match the address of the `from` field in the RFC-822 data.
    /// - Returns:
    ///   - Success: Identifier of the email message that is being sent.
    ///   - Failure: `SudoEmailError`.
    func sendEmailMessage(withRFC822Data data: Data, senderEmailAddress: String, completion: @escaping ClientCompletion<String>)

    /// Delete an email message.
    /// - Parameters:
    ///   - id: Identifier of the email message to be deleted.
    /// - Returns:
    ///   - Success: Identifier of the email message that was deleted.
    ///   - Failure: `SudoEmailError`.
    func deleteEmailMessage(withId id: String, completion: @escaping ClientCompletion<String>)

    // MARK: - Queries

    /// Get a list of the supported email domains from the service.
    /// - Parameters:
    ///   - cachePolicy: Determines how the data is fetched. When using `cacheOnly`, please be aware that this will only return cached results of similar exact
    ///       API calls.
    /// - Returns:
    ///   - Success: Array of supported domains.
    ///   - Failure: `SudoEmailError`.
    func getSupportedEmailDomainsWithCachePolicy(_ cachePolicy: CachePolicy, completion: @escaping ClientCompletion<[String]>)

    /// Get a `EmailAddress` record using the `address` parameter. If the email address cannot be found, `nil` will be returned.
    /// - Parameters:
    ///   - id: Identifier of the email address to be retrieved.
    ///   - cachePolicy: Determines how the data is fetched. When using `cacheOnly`, please be aware that this will only return cached results of similar exact
    ///       API calls.
    /// - Returns:
    ///   - Success: Email address associated with `id`, or `nil` if the email address cannot be found.
    ///   - Failure: `SudoEmailError`.
    func getEmailAddressWithAddress(_ address: String, cachePolicy: CachePolicy, completion: @escaping ClientCompletion<EmailAddress?>)

    /// Get a list of email addresses. If no email addresses can be found, an empty list will be returned.
    /// - Parameters:
    ///   - filter: Filter to be applied to results of query.
    ///   - limit: Number of email addresses to return. If `nil`, the limit is 10.
    ///   - nextToken: Generated token by previous calls to `listEmailAddressesWithFilter`. This is used for pagination. This value should be pre-generated from
    ///       a previous pagination call, otherwise it will throw an error. It is important to note that the same structured API call should be used if using a
    ///       previously generated `nextToken`.
    ///   - cachePolicy: Determines how the data is fetched. When using `cacheOnly`, please be aware that this will only return cached results of similar exact
    ///       API calls.
    /// - Returns:
    ///   - Success: Email addresses associated with user, or empty list if no email address can be found.
    ///   - Failure: `SudoEmailError`.
    func listEmailAddressesWithFilter(
        _ filter: EmailAddressFilter?,
        limit: Int?,
        nextToken: String?,
        cachePolicy: CachePolicy,
        completion: @escaping ClientCompletion<ListOutput<EmailAddress>>
    )

    /// Get an email message using the `id` parameter. If the email message cannot be found, `nil` will be returned.
    /// - Parameters:
    ///   - id: Identifier of the email message to be retrieved.
    ///   - cachePolicy: Determines how the data is fetched. When using `cacheOnly`, please be aware that this will only return cached results of similar exact
    ///       API calls.
    /// - Returns:
    ///   - Success: Email message associated with `id`, or `nil` if the email message cannot be found.
    ///   - Failure: `SudoEmailError`.
    func getEmailMessageWithId(_ id: String, cachePolicy: CachePolicy, completion: @escaping ClientCompletion<EmailMessage?>)

    /// Get a list of email messages. If no email messages can be found, an empty list will be returned.
    /// - Parameters:
    ///   - filter: Filter to be applied to results of query.
    ///   - limit: Number of email messages to return. If `nil`, the limit is 10.
    ///   - nextToken: Generated token by previous calls to `listEmailMessagesWithFilter`. This is used for pagination. This value should be pre-generated from
    ///       a previous pagination call, otherwise it will throw an error. It is important to note that the same structured API call should be used if using a
    ///       previously generated `nextToken`.
    ///   - cachePolicy: Determines how the data is fetched. When using `cacheOnly`, please be aware that this will only return cached results of similar exact
    ///       API calls.
    /// - Returns:
    ///   - Success: Email messages associated with user, or empty list if no email message can be found.
    ///   - Failure: `SudoEmailError`.
    func listEmailMessagesWithFilter(
        _ filter: EmailMessageFilter?,
        limit: Int?,
        nextToken: String?,
        cachePolicy: CachePolicy,
        completion: @escaping ClientCompletion<ListOutput<EmailMessage>>
    )

    /// Get the raw RFC822 data of an email message associated with the `messageId`.
    ///
    /// If no email message exists for `messageId`, `SudoEmailError.noEmailMessageRFC822Available` will be returned.
    /// - Parameters:
    ///   - messageId: Message identifier associated with the RFC822 data attempting to be fetched.
    /// - Returns:
    ///   - Success: Stored RFC822 email message data of the email message.
    ///   - Failure: `SudoEmailError.noEmailMessageRFC822Available` if the email message cannot be accessed/found.
    func getEmailMessageRFC822DataWithId(_ messageId: String, completion: @escaping ClientCompletion<Data>)

    // MARK: - Subscriptions

    /// Subscribe to email message creation events.
    ///
    /// - Parameter resultHandler: Updated email message event.
    /// - Returns: `SubscriptionToken` object to cancel the subscription. On denitialization, the subscription will be cancelled.
    /// - Throws: `SudoEmailError` if an error occurs while setting up the initial connection the subscription.
    func subscribeToEmailMessageCreated(resultHandler: @escaping ClientCompletion<EmailMessage>) throws -> SubscriptionToken

    /// Subscribe to email message deleted events.
    /// - Parameters:
    ///   - id: Identifier of a specific deletion event to watch for. If `nil`, all deletion events will be handled.
    /// - Returns: `SubscriptionToken` object to cancel the subscription. On denitialization, the subscription will be cancelled.
    /// - Throws: `SudoEmailError` if an error occurs while setting up the initial connection the subscription.
    func subscribeToEmailMessageDeleted(resultHandler: @escaping ClientCompletion<EmailMessage>) throws -> SubscriptionToken
}
