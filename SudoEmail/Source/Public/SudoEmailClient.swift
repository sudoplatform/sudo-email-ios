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
    ///   - Success: Successfully provisioned email. This address will return in all lower-case.
    ///   - Failure: `SudoEmailError`.
    func provisionEmailAddress(_ emailAddress: String, sudoId: String, completion: @escaping ClientCompletion<EmailAddress>)

    /// Deprovision an email address.
    /// - Parameters:
    ///   - emailAddressId: Unique identifier of the email address to be deprovisioned.
    /// - Returns:
    ///   - Success: Successfully deprovisioned email.
    ///   - Failure: `SudoEmailError`.
    func deprovisionEmailAddressWithId(_ emailAddressId: String, completion: @escaping ClientCompletion<EmailAddress>)

    /// Send an email message using [RFC 6854] supersedes [RFC 822] (https://tools.ietf.org/html/rfc6854) data.
    /// - Parameters:
    ///   - data: Data formatted under the [RFC 6854] supersedes [RFC 822] (https://tools.ietf.org/html/rfc6854) standard.
    ///   - emailAddressId: Identifier of the email address being used to send the email. The address must match the address of the `from` field in the RFC 6854
    ///       data.
    /// - Returns:
    ///   - Success: Identifier of the email message that is being sent.
    ///   - Failure: `SudoEmailError`.
    func sendEmailMessage(withRFC822Data data: Data, emailAddressId: String, completion: @escaping ClientCompletion<String>)

    /// Delete an email message.
    /// - Parameters:
    ///   - id: Identifier of the email message to be deleted.
    /// - Returns:
    ///   - Success: Identifier of the email message that was deleted.
    ///   - Failure: `SudoEmailError`.
    func deleteEmailMessage(withId id: String, completion: @escaping ClientCompletion<String>)

    // MARK: - Queries

    /// Check the availability of email address combinations.
    /// - Parameters:
    ///   - localParts: The local parts of the email address to check. All upper-case characters will be normalized and returned as lower-case.
    ///   - domains: The domains of the email address to check. If `nil` is supplied, the registered service email address domains will be used.
    /// - Returns:
    ///   - Success: Returns the fully qualified email addresses, filtering out used email addresses. Email addresses are returned in all lower-case.
    ///   - Failure: `SudoEmailError`.
    func checkEmailAddressAvailabilityWithLocalParts(_ localParts: [String], domains: [String]?, completion: @escaping ClientCompletion<[String]>)

    /// Get a list of the supported email domains from the service.
    /// - Parameters:
    ///   - cachePolicy: Determines how the data is fetched. When using `cacheOnly`, please be aware that this will only return cached results of similar exact
    ///       API calls.
    /// - Returns:
    ///   - Success: Array of supported domains.
    ///   - Failure: `SudoEmailError`.
    func getSupportedEmailDomainsWithCachePolicy(_ cachePolicy: CachePolicy, completion: @escaping ClientCompletion<[String]>)

    /// Get a `EmailAddress` record using the `id` parameter. If the email address cannot be found, `nil` will be returned.
    /// - Parameters:
    ///   - id: Identifier of the email address to be retrieved.
    ///   - cachePolicy: Determines how the data is fetched. When using `cacheOnly`, please be aware that this will only return cached results of similar exact
    ///       API calls.
    /// - Returns:
    ///   - Success: Email address associated with `id`, or `nil` if the email address cannot be found.
    ///   - Failure: `SudoEmailError`.
    func getEmailAddressWithId(_ id: String, cachePolicy: CachePolicy, completion: @escaping ClientCompletion<EmailAddress?>)

    /// Get a list of email addresses. If no email addresses can be found, an empty list will be returned.
    /// - Parameters:
    ///   - sudoId: Identifier of the sudo associated with the results to list.
    ///   - filter: Filter to be applied to results of query.
    ///   - limit: Number of email addresses to return. If `nil`, the limit is upward of 1MB of data, before the filter is applied.
    ///   - nextToken: Generated token by previous calls to `listEmailAddressesWithSudoId`. This is used for pagination. This value should be pre-generated from
    ///       a previous pagination call, otherwise it will throw an error. It is important to note that the same structured API call should be used if using a
    ///       previously generated `nextToken`.
    ///   - cachePolicy: Determines how the data is fetched. When using `cacheOnly`, please be aware that this will only return cached results of similar exact
    ///       API calls.
    /// - Returns:
    ///   - Success: Email addresses associated with user, or empty list if no email address can be found.
    ///   - Failure: `SudoEmailError`.
    func listEmailAddressesWithSudoId(
        _ sudoId: String?,
        filter: EmailAddressFilter?,
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
    ///   - sudoId: Identifier of the sudo associated with the results to list. If an email address identifier is supplied, a sudoId **MUST** also be supplied,
    ///       otherwise an error will occur.
    ///   - emailAddressId: Identifier of the sudo associated with the results to list.
    ///   - filter: Filter to be applied to results of query.
    ///   - limit: Number of email messages to return. If `nil`, the limit is upward of 1MB of data, before the filter is applied.
    ///   - nextToken: Generated token by previous calls to `listEmailMessagesWithSudoId`. This is used for pagination. This value should be pre-generated from
    ///       a previous pagination call, otherwise it will throw an error. It is important to note that the same structured API call should be used if using a
    ///       previously generated `nextToken`.
    ///   - cachePolicy: Determines how the data is fetched. When using `cacheOnly`, please be aware that this will only return cached results of similar exact
    ///       API calls.
    /// - Returns:
    ///   - Success: Email messages associated with user, or empty list if no email message can be found.
    ///   - Failure: `SudoEmailError`.
    func listEmailMessagesWithSudoId(
        _ sudoId: String?,
        emailAddressId: String?,
        filter: EmailMessageFilter?,
        limit: Int?,
        nextToken: String?,
        cachePolicy: CachePolicy,
        completion: @escaping ClientCompletion<ListOutput<EmailMessage>>
    )

    /// Get the raw RFC 6854 (supersedes RFC 822) data of an email message associated with the `messageId`.
    ///
    /// If no email message exists for `messageId`, `SudoEmailError.noEmailMessageRFC822Available` will be returned.
    /// - Parameters:
    ///   - messageId: Message identifier associated with the RFC 6854 data attempting to be fetched.
    /// - Returns:
    ///   - Success: Stored RFC 6854 email message data of the email message.
    ///   - Failure: `SudoEmailError.noEmailMessageRFC822Available` if the email message cannot be accessed/found.
    func getEmailMessageRFC822DataWithId(_ messageId: String, completion: @escaping ClientCompletion<Data>)

    // MARK: - Subscriptions

    /// Subscribe to email message creation events.
    ///
    /// - Parameters:
    ///   - resultHandler: Updated email message event.
    ///   - direction: Direction of the email message events to watch for. If `nil`, both directions will be watched.
    /// - Returns: `SubscriptionToken` object to cancel the subscription. On denitialization, the subscription will be cancelled.
    /// - Throws: `SudoEmailError` if an error occurs while setting up the initial connection the subscription.
    func subscribeToEmailMessageCreated(
        withDirection direction: EmailMessage.Direction?,
        resultHandler: @escaping ClientCompletion<EmailMessage>
    ) throws -> SubscriptionToken

    /// Subscribe to email message deleted events.
    /// - Parameters:
    ///   - id: Identifier of a specific deletion event to watch for. If `nil`, all deletion events will be handled.
    /// - Returns: `SubscriptionToken` object to cancel the subscription. On denitialization, the subscription will be cancelled.
    /// - Throws: `SudoEmailError` if an error occurs while setting up the initial connection the subscription.
    func subscribeToEmailMessageDeleted(resultHandler: @escaping ClientCompletion<EmailMessage>) throws -> SubscriptionToken
}

extension SudoEmailClient {

    func listEmailAddressesWithSudoId(
        _ sudoId: String? = nil,
        filter: EmailAddressFilter? = nil,
        limit: Int? = nil,
        nextToken: String? = nil,
        cachePolicy: CachePolicy,
        completion: @escaping ClientCompletion<ListOutput<EmailAddress>>
    ) {
        return listEmailAddressesWithSudoId(
            sudoId,
            filter: filter,
            limit: limit,
            nextToken: nextToken,
            cachePolicy: cachePolicy,
            completion: completion
        )
    }

    func listEmailMessagesWithSudoId(
        _ sudoId: String? = nil,
        emailAddressId: String? = nil,
        filter: EmailMessageFilter? = nil,
        limit: Int? = nil,
        nextToken: String? = nil,
        cachePolicy: CachePolicy,
        completion: @escaping ClientCompletion<ListOutput<EmailMessage>>
    ) {
        return listEmailMessagesWithSudoId(
            sudoId,
            emailAddressId: emailAddressId,
            filter: filter,
            limit: limit,
            nextToken: nextToken,
            cachePolicy: cachePolicy,
            completion: completion
        )
    }

    func subscribeToEmailMessageCreated(
        withDirection direction: EmailMessage.Direction? = nil,
        resultHandler: @escaping ClientCompletion<EmailMessage>
    ) throws -> SubscriptionToken {
        return try subscribeToEmailMessageCreated(withDirection: direction, resultHandler: resultHandler)
    }

    func checkEmailAddressAvailabilityWithLocalParts(_ localParts: [String], domains: [String]? = nil, completion: @escaping ClientCompletion<[String]>) {
        return checkEmailAddressAvailabilityWithLocalParts(localParts, domains: domains, completion: completion)
    }
}
