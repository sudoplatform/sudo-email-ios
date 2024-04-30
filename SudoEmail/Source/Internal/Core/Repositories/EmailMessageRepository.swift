//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a email message repository used in business logic. Used to perform CRUD operations for sealed email messages.
protocol EmailMessageRepository: AnyObject {

    /// Send an email message.
    /// - Parameters:
    ///   - data: RFC 6854 (supersedes RFC 822) data to be sent representing the email message.
    ///   - emailAccountId: Identifier of the email account to send the email message from. The user must own this account.
    /// - Returns: SendEmailMessageResult
    func sendEmailMessage(withRFC822Data data: Data, emailAccountId: String) async throws -> SendEmailMessageResult

    /// Send an end-to-end encrypted email message (if possible).
    /// - Parameters:
    ///   - data: RFC 6854 (supersedes RFC 822) data to be sent representing the email message.
    ///   - emailAccountId: Identifier of the email account to send the email message from. The user must own this account.
    ///   - emailMessageHeader: Message headers used for E2E encryption.
    ///   - hasAttachments: Indicates whether or not the encrypted data contains email attachments.
    /// - Returns: SendEmailMessageResult
    func sendEmailMessage(withRFC822Data data: Data, emailAccountId: String, emailMessageHeader: InternetMessageFormatHeader, hasAttachments: Bool) async throws -> SendEmailMessageResult

    /// Delete an email message.
    /// - Parameters:
    ///   - id: Unique Identifier of the email message to be deleted.
    /// - Returns: The IDs of any email messages that failed to delete
    func deleteEmailMessages(withIds ids: [String]) async throws -> [String]

    /// Update a list of email messages
    ///  - Parameters:
    ///   - input: list of email message ids to update and values to set.
    ///   - Returns: The status of the update:
    ///       - success: All email messages updated successfully.
    ///       - partial: Only some of the email messages updated successfully. Includes a list of the
    ///               identifiers of the email messages that failed and succeeded to update.
    ///       - failed: All email messages failed to update.
    func updateEmailMessages(withInput input: UpdateEmailMessagesInput) async throws -> BatchOperationResult<String>

    /// Save a draft email message
    ///  - Parameters:
    ///   - rfc822Data: The RFC822 data of the draft email message
    ///   - senderEmailAddressId: The id of the sender's email address
    ///   - id: The id of the draft email message to save
    ///   - Returns: On success, the metadata associated with the saved draft email message
    func saveDraft(
        rfc822Data: Data,
        senderEmailAddressId: String,
        id: String?
    ) async throws -> DraftEmailMessageMetadataEntity

    /// Delete a draft email message.
    ///  - Parameters:
    ///    - id: The identifier of the draft email message to delete.
    ///    - emailAddressId: The email address id associated with the draft email message to delete.
    ///  - Returns: The identifier of the deleted email message.
    func deleteDraft(
        id: String,
        emailAddressId: String
    ) async throws -> String

    /// Get the sealed email message by its identifier. Gets the message locally from the cache of the device.
    /// - Parameters:
    ///   - id: Identifier of the email message to get.
    /// - Returns: on success, the sealed email message with the input identifier
    func getEmailMessageById(_ id: String) async throws -> SealedEmailMessageEntity?

    /// Get the sealed email message by its identifier. Fetches the message remotely from the email service.
    /// - Parameters:
    ///   - id: Identifier of the email message to fetch.
    /// - Returns: on success, the sealed email message with the input identifier
    func fetchEmailMessageById(_ id: String) async throws -> SealedEmailMessageEntity?
    
    /// List all sealed email messages for the user.
    /// - Parameters:
    ///   - input: input parameters for the list email messages query
    func listEmailMessages(
        withInput input: ListEmailMessagesInput
    ) async throws -> ListOutputEntity<SealedEmailMessageEntity>

    /// List sealed email messages for the specified email address ID.
    /// - Parameters:
    ///   - input: input parameters, including emailAddressId, for the list email messages query
    func listEmailMessagesForEmailAddressId(
        withInput input: ListEmailMessagesForEmailAddressInput
    ) async throws -> ListOutputEntity<SealedEmailMessageEntity>

    /// List sealed email messages for the specified email folder ID.
    /// - Parameters:
    ///   - input: input parameters, including emailFolderId, for the list email messages query
    func listEmailMessagesForEmailFolderId(
        withInput input: ListEmailMessagesForEmailFolderIdInput
    ) async throws -> ListOutputEntity<SealedEmailMessageEntity>

    /// Fetch the sealed email message RFC 6854 (supersedes RFC 822) data remotely.
    /// - Parameters:
    ///   - sealedId: Identifier of the email message to fetch.
    ///   - emailAddressId: Identifier of the email address that owns the sealed email message.
    /// - Returns: The RFC822 S3Object for the email message.
    func fetchEmailMessageRFC822Data(_ sealedId: String, emailAddressId: String) async throws -> S3ObjectEntity?

    /// Get a saved draft email message.
    ///  - Parameters:
    ///   - input: input parameters for the get draft email message query
    /// - Returns: The draft email message, or undefined if not found.
    func getDraft(withInput input: GetDraftEmailMessageInput) async throws -> DraftEmailMessage?

    /// Determine if a draft email message exists.
    ///  - Parameters:
    ///    - id: The identifier of the draft email message to check.
    ///    - emailAddressId: Identifier of the email address associated with the draft email message.
    ///  - Returns: true if the draft email message exists, false otherwise.
    func draftExists(id: String, emailAddressId: String) async throws -> Bool

    /// List draft email message metadata for the specified email address identifier.
    ///  - Parameters:
    ///    - emailAddressId: Identifier of the email address associated with the draft email messages.
    ///  - Returns:
    ///    - A list of draft email message metadata. Will be empty if no draft messages found.
    func listDraftsMetadataForEmailAddressId(emailAddressId: String) async throws -> [DraftEmailMessageMetadataEntity]

    /// Subscribe to all sealed email messages created events.
    /// - Parameter direction: Direction of the email message create event (INBOUND or OUTBOUND). If `nil`, all events, irrespective of direction, will be
    ///     returned.
    /// - Parameter resultHandler: Result handler for each incoming or outgoing email message.
    /// - Throws: `SudoEmailError` if an error occurs while setting up the initial subscription connection.
    /// - Returns: The token identifying this subscription
    func subscribeToEmailMessageCreated(
        withDirection direction: DirectionEntity?,
        resultHandler: @escaping ClientCompletion<SealedEmailMessageEntity>
    ) async throws -> SubscriptionToken

    /// Subscribe to all sealed email messages deleted.
    /// - Parameters:
    ///   - id: The specific email message id to watch for deletion. If `nil`, all message deletions will be watched.
    ///   - resultHandler: Result handler for email message delete events.
    /// - Throws: `SudoEmailError` if an error occurs while setting up the initial subscription connection.
    /// - Returns: The token identifying this subscription
    func subscribeToEmailMessageDeleted(
        withId id: String?,
        resultHandler: @escaping ClientCompletion<SealedEmailMessageEntity>
    ) async throws -> SubscriptionToken

    /// Unsubscribe from all email notifications.
    func unsubscribeAll()
}
