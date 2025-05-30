//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a email message repository used in business logic. Used to perform CRUD operations for sealed email messages.
protocol EmailMessageRepository: Repository {

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
    ///   - replyingMessageId: Identifier of the email message being replied to.
    ///   - forwardingMessageId: Identifier of the email message being forwarded.
    /// - Returns: SendEmailMessageResult
    func sendEmailMessage(
        withRFC822Data data: Data,
        emailAccountId: String,
        emailMessageHeader: InternetMessageFormatHeader,
        hasAttachments: Bool,
        replyingMessageId: String?,
        forwardingMessageId: String?
    ) async throws -> SendEmailMessageResult

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
    func updateEmailMessages(
        withInput input: UpdateEmailMessagesInput
    ) async throws -> BatchOperationResult<UpdatedEmailMessageSuccess, EmailMessageOperationFailureResult>

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

    /// Schedule a draft message to be sent at a specified time in the future
    ///  - Parameters:
    ///    - input: The parameters needed to schedule send a draft message
    ///  - Returns: On success, a record of the scheduled draft message
    func scheduleSendDraftMessage(
        withInput input: ScheduleSendDraftMessageInput
    ) async throws -> ScheduledDraftMessageEntity

    /// Cancel a scheduled draft message from being sent
    /// - Parameters:
    ///   - input: Input parameters used to cancel a scheduled draft message
    /// - Returns:
    ///   - The id of the draft message on success.
    /// - Throws:
    ///   - recordNotFound if no record of draft being scheduled is found
    func cancelScheduledDraftMessage(
        withInput input: CancelScheduledDraftMessageInput
    ) async throws -> String

    /// List scheduled draft messages for an email address id
    /// - Parameters:
    ///   - input: Input parameters used to list scheduled draft messages for an email address.
    /// - Returns: a list of results with a next token if there are more results to fetch, or error on failure.
    func listScheduledDraftMessagesForEmailAddressId(
        withInput input: ListScheduledDraftMessagesForEmailAddressIdInput
    ) async throws -> ListOutputEntity<ScheduledDraftMessageEntity>

    /// Get the message body and attachments of an email address.
    ///  - Parameters:
    ///    - messageId: The identifier of the email message to retrieve.
    ///    - emailAddressId: The email address id associated with the email message to retrieve.
    ///  - Returns: The identifier of the deleted email message.
    func getEmailMessageWithBody(
        messageId: String,
        emailAddressId: String
    ) async throws -> EmailMessageWithBody?

    /// Get the sealed email message by its identifier. Fetches the message remotely from the email service.
    /// - Parameters:
    ///   - id: Identifier of the email message to fetch.
    /// - Returns: on success, the sealed email message with the input identifier
    func fetchEmailMessageById(_ id: String) async throws -> SealedEmailMessageEntity?

    /// List all sealed email messages for the user.
    /// - Parameters:
    ///   - input: input parameters for the list email messages query
    func listEmailMessages(withInput input: ListEmailMessagesInput) async throws -> ListOutputEntity<SealedEmailMessageEntity>

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
}
