//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a email message repository used in business logic. Used to perform CRUD operations for sealed email messages.
protocol SealedEmailMessageRepository: class {

    /// Send an email message.
    /// - Parameters:
    ///   - data: RFC822 data to be sent representing the email message.
    ///   - account: Email account to send the email message from. The user must own this account.
    ///   - completion: Returns, on success, the ID of the sent email address, or error on failure.
    func sendEmailMessage(withRFC822Data data: Data, fromAccount account: EmailAccountEntity, completion: @escaping ClientCompletion<String>)

    /// Delete an email message.
    /// - Parameters:
    ///   - id: Unique Identifier of the email message to be deleted.
    ///   - completion: Returns on success, the ID of the deleted email message, or error on failure.
    func deleteEmailMessage(withId id: String, completion: @escaping ClientCompletion<String>)

    /// Get the sealed email message by its identifier. Gets the message locally from the cache of the device.
    /// - Parameters:
    ///   - id: Identifier of the email message to get.
    ///   - keyId: Key identifier of the email message to determine which copy is relevant to the client.
    ///   - completion: Returns the found email message sealed, `nil` if it could not be found, or error on failure.
    func getEmailMessageById(_ id: String, keyId: String, completion: @escaping ClientCompletion<SealedEmailMessageEntity?>)

    /// Get the sealed email message by its identifier. Fetches the message remotely from the email service.
    /// - Parameters:
    ///   - id: Identifier of the email message to get.
    ///   - keyId: Key identifier of the email message to determine which copy is relevant to the client.
    ///   - completion: Returns the found email message sealed, `nil` if it could not be found, or error on failure.
    func fetchEmailMessageById(_ id: String, keyId: String, completion: @escaping ClientCompletion<SealedEmailMessageEntity?>)

    /// Get the list of sealed email messages from the device cache.
    /// - Parameters:
    ///   - filter: Filter rules to be applied to the list.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    ///   - completion: Returns a list of results with a next token is there if more results to fetch, or error on failure.
    func getListEmailMessagesByFilter(
        _ filter: EmailMessageFilterEntity?,
        limit: Int?,
        nextToken: String?,
        completion: @escaping ClientCompletion<ListOutputEntity<SealedEmailMessageEntity>>
    )

    /// Fetch the list of sealed email messages remotely.
    /// - Parameters:
    ///   - filter: Filter rules to be applied to the list.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    ///   - completion: Returns a list of results with a next token is there if more results to fetch, or error on failure.
    func fetchListEmailMessagesByFilter(
        _ filter: EmailMessageFilterEntity?,
        limit: Int?,
        nextToken: String?,
        completion: @escaping ClientCompletion<ListOutputEntity<SealedEmailMessageEntity>>
    )

    /// Fetch the sealed email message RFC822 data remotely.
    /// - Parameters:
    ///   - message: Message to fetch the data for.
    ///   - completion: Returns the RFC822 data of an email message, or error on failure.
    func fetchEmailMessageRFC822DataWithSealedId(_ sealedId: String, completion: @escaping ClientCompletion<Data>)

    /// Subscribe to all sealed email messages created events.
    /// - Parameter direction: Direction of the email message create event (INBOUND or OUTBOUND). If `nil`, all events, irrespective of direction, will be returned.
    /// - Parameter resultHandler: Result handler for each incoming or outgoing email message.
    /// - Throws: `SudoEmailError` if an error occurs while setting up the initial subscription connection.
    func subscribeToEmailMessageCreated(
        withDirection direction: DirectionEntity?,
        resultHandler: @escaping ClientCompletion<SealedEmailMessageEntity>
    ) throws -> SubscriptionToken

    /// Subscribe to all sealed email messages deleted.
    /// - Parameter resultHandler: Result handler for email message delete events.
    /// - Throws: `SudoEmailError` if an error occurs while setting up the initial subscription connection.
    func subscribeToEmailMessageDeleted(resultHandler: @escaping ClientCompletion<SealedEmailMessageEntity>) throws -> SubscriptionToken

}
