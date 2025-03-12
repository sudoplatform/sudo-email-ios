//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging
import SudoUser

/// Generic type associated with API completion/closures. Generic type O is the expected output result in a
/// success case.
public typealias ClientCompletion<O> = (Swift.Result<O, Error>) -> Void

/// Generic type associated with Subscription Status change completion/closures.
public typealias SudoSubscriptionStatusChangeHandler = (PlatformSubscriptionStatus) -> Void

/// Maximum number of draft messages that can be deleted per request.
public let deleteDraftsRequestLimit = 10

/// Client used to interface with the Sudo Email Platform service.
///
/// It is recommended to code to this interface, rather than the implementation class (`DefaultSudoEmailClient`) as
/// the implementation class is only meant to be used for initializing an instance of the client.
public protocol SudoEmailClient: AnyObject {

    // MARK: - Lifecycle

    /// Removes all keys associated with this client, resets any cached data, cleans up subscriptions, and purges any pending operations.
    ///
    /// It is important to note that this will clear ALL cached data related to all
    /// sudo services.
    func reset() throws

    // MARK: - Mutations

    /// Provision an email address.
    /// - Parameters:
    ///   - input: Parameters used to provision an email address, including:
    ///     - emailAddress: Email address to provision, of the form localpart@domain. domain must be a registered domain
    ///     retrieved from SudoEmailClient.getSupportedEmailDomains
    ///     - ownershipProofToken: The signed ownership proof of the Sudo to be associated with the provisioned email address.
    ///     The ownership proof must contain an audience of "sudoplatform".
    ///     - alias: An alias for the email address.
    /// - Returns:
    ///   - Success: Successfully provisioned email. This address will return in all lower-case.
    ///   - Failure: `SudoEmailError`.
    func provisionEmailAddress(withInput input: ProvisionEmailAddressInput) async throws -> EmailAddress

    /// Deprovision an email address.
    /// - Parameters:
    ///   - id: Unique identifier of the email address to be deprovisioned.
    /// - Returns:
    ///   - Success: Successfully deprovisioned email.
    ///   - Failure: `SudoEmailError`.
    func deprovisionEmailAddress(_ id: String) async throws -> EmailAddress

    /// Update the metadata of an email address.
    /// - Parameters:
    ///  - input: Parameters used to update the metadata of an email address.
    /// - Returns:
    ///  - Success: the id of the updated email address
    ///  - Failure: `SudoEmailError`.
    func updateEmailAddressMetadata(withInput input: UpdateEmailAddressMetadataInput) async throws -> String

    /// Send an email message using [RFC 6854] supersedes [RFC 822] (https://tools.ietf.org/html/rfc6854) data.
    /// Email messages sent to in-network recipients (i.e. email addresses that exist within the Sudo Platform) will be sent end-to-end encrypted.
    /// - Parameters:
    ///   - input: Parameters used to send an email message
    /// - Returns:
    ///   - Success: SendEmailMessageResult
    ///   - Failure: `SudoEmailError`.
    func sendEmailMessage(withInput input: SendEmailMessageInput) async throws -> SendEmailMessageResult

    /// Delete multiple email messages using a list of identifiers.
    ///
    /// Email Messages can only be deleted in batches of 100 or less. Anything greater will throw
    /// a LimitExceededError.
    ///
    /// - Parameters:
    ///   - ids: A list of one or more identifiers of the email messages to be deleted. There is a limit of
    ///   100 email message ids per API request. Exceeding this will cause an error to be thrown.
    /// - Returns: The results of the delete operation:
    ///     - status:
    ///         - Success - All draft email messages succeeded to delete.
    ///         - Partial - Only a partial amount of draft messages succeeded to delete. Result includes two lists;
    ///           one containing success results and the other containing failure results.
    ///         - Failure - All draft email messages failed to delete. Result contains a list of identifiers of draft email
    ///           messages that failed to delete.
    ///     - successItems - A list of the result items containing identifiers of the draft email messages that were successfully deleted.
    ///     - failureItems - A list of the id and errorType of each draft email message that failed to be deleted.
    func deleteEmailMessages(withIds ids: [String]) async throws -> BatchOperationResult<DeleteEmailMessageSuccessResult, EmailMessageOperationFailureResult>

    /// Delete an email message.
    /// - Parameters:
    ///   - id: Identifier of the email message to be deleted.
    /// - Returns:
    ///   - Success: Result containing the identifier of the email message that was deleted.
    ///   - Failure: `SudoEmailError`.
    func deleteEmailMessage(withId id: String) async throws -> DeleteEmailMessageSuccessResult?

    /// Update multiple email messages using a list of identifiers.
    ///
    /// Email Messages can only be updated in batches of 100 or less. Anything greater will throw
    /// a LimitExceededError.
    ///
    /// - Parameters:
    ///   - input: Parameters used to update a list of email messages.
    /// - Returns: The results of the updates:
    ///      - status:
    ///        - Success - All email messages succeeded to update.
    ///        - Partial - Only a partial amount of messages succeeded to update. Result includes a list of the
    ///           identifiers of the email messages that failed and succeeded to update.
    ///        - Failure - All email messages failed to update. Result contains a list of identifiers of email messages
    ///           that failed to update.
    ///      - successItems - A list of the id, createdAt and updatedAt of each message that successfully updated
    ///      - failureItems - A list of the id, and errorType of each message that failed to be updated
    func updateEmailMessages(
        withInput input: UpdateEmailMessagesInput
    ) async throws -> BatchOperationResult<UpdatedEmailMessageSuccess, EmailMessageOperationFailureResult>

    /// Create a draft email message in RFC 6854 (supersedes RFC 822)(https://tools.ietf.org/html/rfc6854) format.
    ///  - Parameters:
    ///    - input: Input parameters used to create a draft email message.
    ///  - Returns:
    ///    - The metadata associated with the created draft email message
    func createDraftEmailMessage(
        withInput input: CreateDraftEmailMessageInput
    ) async throws -> DraftEmailMessageMetadata

    /// Update a draft email message in RFC 6854 (supersedes RFC 822)(https://tools.ietf.org/html/rfc6854) format.
    ///  - Parameters:
    ///    - input: Input parameters used to update a draft email message.
    ///  - Returns:
    ///    - The metadata associated with the updated draft email message
    func updateDraftEmailMessage(
        withInput input: UpdateDraftEmailMessageInput
    ) async throws -> DraftEmailMessageMetadata

    /// Delete the draft email messages identified by the list of ids.
    /// Any draft email message ids that do not exist will be marked as success.
    /// Any emailAddressId that is not owned or does not exist, will throw an error.
    ///  - Parameters:
    ///    - input: Input parameters used to delete a list of draft email messages.
    ///  - Returns: The results of the delete operation:
    ///     - status:
    ///         - Success - All email messages succeeded to delete.
    ///         - Partial - Only a partial amount of draft messages succeeded to delete. Result includes two lists;
    ///           one containing success results and the other containing failure results.
    ///         - Failure - All email messages failed to delete. Result contains a list of identifiers of email messages
    ///           that failed to delete.
    ///     - successItems - A list of result items containing the identifiers of the email messages that were successfully deleted.
    ///     - failureItems - A list of the id and errorType of each email message that failed to be deleted.
    func deleteDraftEmailMessages(
        withInput input: DeleteDraftEmailMessagesInput
    ) async throws -> BatchOperationResult<DeleteEmailMessageSuccessResult, EmailMessageOperationFailureResult>

    /// Create a custom EmailFolder
    ///   - Parameters:
    ///     - input: Input parameters used to create a custom EmailFolder.
    ///   - Returns:
    ///     - The newly created EmailFolder
    func createCustomEmailFolder(
        withInput input: CreateCustomEmailFolderInput
    ) async throws -> EmailFolder

    /// Delete a custom EmailFolder
    /// Any messages in the folder will be moved to TRASH
    ///   - Parameters:
    ///     - input: Input parameters used to delete a custom EmailFolder.
    ///   - Returns:
    ///     - The deleted EmailFolder or nil if not found
    func deleteCustomEmailFolder(
        withInput input: DeleteCustomEmailFolderInput
    ) async throws -> EmailFolder?

    /// Update a custom EmailFolder
    ///   - Parameters:
    ///     - input: Input parameters used to update a custom EmailFolder.
    ///   - Returns:
    ///     - The updated EmailFolder
    func updateCustomEmailFolder(
        withInput input: UpdateCustomEmailFolderInput
    ) async throws -> EmailFolder

    /// Imports cryptographic keys from a key archive.
    ///
    /// - Parameter archiveData: Key archive data to import the keys from.
    func importKeys(archiveData: Data) throws

    // MARK: - Queries

    /// Check the availability of email address combinations.
    /// - Parameters:
    ///   - input: The local parts and domains of the email addresses to check. All upper-case characters will be normalized and returned as lower-case.
    /// - Returns:
    ///   - Success: Returns the fully qualified email addresses, filtering out used email addresses. Email addresses are returned in all lower-case.
    ///   - Failure: `SudoEmailError`.
    func checkEmailAddressAvailability(withInput input: CheckEmailAddressAvailabilityInput) async throws -> [String]

    /// Get a list of the supported email domains. Primarily intended to be used to perform a domain search
    /// which occurs prior to provisioning an email address.
    /// - Parameters:
    ///   - cachePolicy: Determines how the data is fetched. When using `cacheOnly`, please be aware that this will only return cached results of similar exact
    ///       API calls.
    /// - Returns:
    ///   - Success: Array of supported domains.
    ///   - Failure: `SudoEmailError`.
    func getSupportedEmailDomains(_ cachePolicy: CachePolicy) async throws -> [String]

    /// Get a list of all of the configured domains. Primarily intended to be used as part of performing
    /// an email send operation in order to fetch all domains configured for the service so that appropriate
    /// encryption decisions can be made.
    /// - Parameters:
    ///   - cachePolicy: Determines how the data is fetched. When using `cacheOnly`, please be aware that this will only return cached results of identical API
    /// calls.
    ///       API calls.
    /// - Returns:
    ///   - Success: Array of all configured domains.
    ///   - Failure: `SudoEmailError`.
    func getConfiguredEmailDomains(_ cachePolicy: CachePolicy) async throws -> [String]

    /// Get a `EmailAddress` record using the `id` parameter. If the email address cannot be found, `nil` will be returned.
    /// - Parameters:
    ///   - input: Input object specifying the email address to be retrieved.
    /// - Returns:
    ///   - Success: Email address associated with `id`, or `nil` if the email address cannot be found.
    ///   - Failure: `SudoEmailError`.
    func getEmailAddress(withInput input: GetEmailAddressInput) async throws -> EmailAddress?

    /// Get a list of email addresses. If no email addresses can be found, an empty list will be returned.
    /// - Parameters:
    ///   - input: Parameters used to retrieve a list of provisioned email addresses.
    /// - Returns:
    ///   - Success: Email addresses associated with user, or empty list if no email address can be found.
    ///   - Failure: `SudoEmailError`.
    func listEmailAddresses(withInput input: ListEmailAddressesInput) async throws -> ListOutput<EmailAddress>

    /// Get a list of provisioned email addresses owned by the Sudo identified by sudoId.
    ///  - Parameters:
    ///    - input: Parameters used to retrieve a list of provisioned email addresses for a sudoId.
    ///  - Returns:
    ///   - Success: Email addresses associated with the sudo specified by sudoId, or empty list if no email address can be found.
    ///   - Failure: `SudoEmailError`.
    func listEmailAddressesForSudoId(
        withInput input: ListEmailAddressesForSudoIdInput
    ) async throws -> ListOutput<EmailAddress>

    /// Get a list of public info objects associated with the provided email addresses.
    ///
    /// If no email addresses or public keys can be found, an empty list will be returned.
    ///  - Parameters:
    ///    - emailAddresses: A list of email address strings in format 'local-part@domain'.
    ///    - cachePolicy: Determines how the data will be fetched. Default usage is `remoteOnly`.
    ///  - Returns:
    ///    - An array of public information objects or an empty array if no email addresses or public keys can be found.
    func lookupEmailAddressesPublicInfo(withInput: LookupEmailAddressesPublicInfoInput) async throws -> [EmailAddressPublicInfo]

    /// Get a list of email folders associated with the email address identified by emailAddressId.
    ///  - Parameters:
    ///    - input: Parameters used to retrieve a list of email folders for an emailAddressId.
    ///  - Returns:
    ///    - An array of email folders or an empty array if no matching email folders can be found.
    func listEmailFoldersForEmailAddressId(
        withInput input: ListEmailFoldersForEmailAddressIdInput
    ) async throws -> ListOutput<EmailFolder>

    /// Get an email message using the `id` parameter. If the email message cannot be found, `nil` will be returned.
    /// - Parameters:
    ///   - id: Identifier of the email message to be retrieved.
    ///   - cachePolicy: Determines how the data is fetched. When using `cacheOnly`, please be aware that this will only return cached results of similar exact
    ///       API calls.
    /// - Returns:
    ///   - Success: Email message associated with `id`, or `nil` if the email message cannot be found.
    ///   - Failure: `SudoEmailError`.
    func getEmailMessage(withInput input: GetEmailMessageInput) async throws -> EmailMessage?

    /// Get a list of all email messages for the user. If no email messages can be found, an empty list will be returned.
    /// - Parameters:
    ///   - input: Parameters used to retrieve a list of email messages.
    /// - Returns:
    ///   - A `ListAPIResult.ListSuccessResult` or a `ListAPIResult.ListPartialResult` result
    ///     containing either a list of `EmailMessage`s or `PartialEmailMessage`s respectively.
    ///     Returns an empty list if no email messages can be found.
    func listEmailMessages(
        withInput: ListEmailMessagesInput
    ) async throws -> ListAPIResult<EmailMessage, PartialEmailMessage>

    /// Get a list of email messages for the provided email address. If no email messages can be found, an empty list will be returned.
    /// - Parameters:
    ///   - input: Parameters used to retrieve a list of email messages.
    /// - Returns:
    ///   - A `ListAPIResult.ListSuccessResult` or a `ListAPIResult.ListPartialResult` result
    ///     containing either a list of `EmailMessage`s or `PartialEmailMessage`s respectively.
    ///     Returns an empty list if no email messages can be found.
    func listEmailMessagesForEmailAddressId(
        withInput: ListEmailMessagesForEmailAddressInput
    ) async throws -> ListAPIResult<EmailMessage, PartialEmailMessage>

    /// Get a list of email messages for the provided email folder. If no email messages can be found, an empty list will be returned.
    /// - Parameters:
    ///   - input: Parameters used to retrieve a list of email messages.
    /// - Returns:
    ///   - A `ListAPIResult.ListSuccessResult` or a `ListAPIResult.ListPartialResult` result
    ///     containing either a list of `EmailMessage`s or `PartialEmailMessage`s respectively.
    ///     Returns an empty list if no email messages can be found.
    func listEmailMessagesForEmailFolderId(
        withInput: ListEmailMessagesForEmailFolderIdInput
    ) async throws -> ListAPIResult<EmailMessage, PartialEmailMessage>

    /// Get the raw RFC 6854 (supersedes RFC 822) data of an email message associated with the `messageId`.
    ///
    /// If no email message exists for `messageId`, `SudoEmailError.noEmailMessageRFC822Available` will be returned.
    /// - Parameters:
    ///   - messageId: Message identifier associated with the RFC 6854 data attempting to be fetched.
    /// - Returns:
    ///   - Success: Stored RFC 6854 email message data of the email message.
    ///   - Failure: `SudoEmailError.noEmailMessageRFC822Available` if the email message cannot be accessed/found.
    @available(*, deprecated, message: "Use getEmailMessageWithBody instead to retrieve email message data")
    func getEmailMessageRfc822Data(withInput input: GetEmailMessageRfc822DataInput) async throws -> Data

    /// Get the body and attachment data of an `EmailMessage`
    ///
    /// - Parameters:
    ///   - input: Parameters used to retrieve the data of the email message.
    /// - Returns:
    ///   - The data associated with the `EmailMessage` or null if the email message cannot be found.
    func getEmailMessageWithBody(withInput input: GetEmailMessageWithBodyInput) async throws -> EmailMessageWithBody?

    /// Lists the metadata and content of all draft email messages for the user.
    ///
    /// - Returns:
    ///   - An array of draft email messages or an empty array if no matching draft email messages can be found.
    func listDraftEmailMessages() async throws -> [DraftEmailMessage]

    /// Lists the metadata and content of all draft email messages for the specified email address identifier.
    ///
    /// - Parameters:
    ///   - emailAddressId: The identifier of the email address associated with the draft email messages.
    /// - Returns:
    ///   - An array of draft email messages or an empty array if no matching draft email messages can be found.
    func listDraftEmailMessagesForEmailAddressId(emailAddressId: String) async throws -> [DraftEmailMessage]

    /// Lists the metadata of all draft messages for the user.
    ///
    /// - Returns:
    ///   - An array of draft email message metadata or an empty array if no matching draft email messages can be found.
    func listDraftEmailMessageMetadata() async throws -> [DraftEmailMessageMetadata]

    /// Lists the metadata of all draft messages for the user.
    ///
    /// - Parameters:
    ///   - emailAddressId: The identifier of the email address associated with the draft email messages.
    /// - Returns:
    ///   - An array of draft email message metadata or an empty array if no matching draft email messages can be found.
    func listDraftEmailMessageMetadataForEmailAddressId(emailAddressId: String) async throws -> [DraftEmailMessageMetadata]

    /// Get a draft email message that has been saved previously.
    ///  - Parameters:
    ///    - input: Parameters used to retrieve a draft email message
    ///  - Returns:
    ///    - The draft email message identified by id or undefined if not found.
    func getDraftEmailMessage(withInput input: GetDraftEmailMessageInput) async throws -> DraftEmailMessage?

    /// Get the configuration data for the email service.
    func getConfigurationData() async throws -> ConfigurationData

    /// Export the cryptographic keys to a key archive.
    ///
    /// - Returns: Key archive data.
    func exportKeys() throws -> Data

    /// Blocks the addresses given from sending to the user
    ///
    ///  - Parameters:
    ///    - addresses: Array of addresses to block as strings
    ///    - action: The action to take on incoming messages from the blocked address(es). Optional: defaults to DROP
    ///    - emailAddressId: The id of the email address for which the blocked address is blocked. If not present, blocked address cannot send to any of owner's
    /// addresses.
    ///  - Returns: The status of the blocking:
    ///     Success - All addresses were succesfully blocked.
    ///     Partial - Only a partial number of the addresses were blocked successfully. Includes a list of the
    ///           addresses that failed and succeeded to be blocked.
    ///     Failure - All addresses failed to be blocked.
    func blockEmailAddresses(
        addresses: [String],
        action: UnsealedBlockedAddress.BlockedAddressAction,
        emailAddressId: String?
    ) async throws -> BatchOperationResult<String, String>

    /// Unblocks the addresses given from sending to the user
    ///
    ///  - Parameters:
    ///    - addresses: Array of addresses to unblock as strings
    ///  - Returns: The status of the unblocking:
    ///     Success - All addresses were succesfully unblocked.
    ///     Partial - Only a partial number of the addresses were unblocked successfully. Includes a list of the
    ///           addresses that failed and succeeded to be unblocked.
    ///     Failure - All addresses failed to be unblocked.
    func unblockEmailAddresses(addresses: [String]) async throws -> BatchOperationResult<String, String>

    /// Unblocks the hashed addresses given from sending to the user
    ///
    ///  - Parameters:
    ///    - hashedValues: Array of addresses to unblock as strings
    ///  - Returns: The status of the unblocking:
    ///     Success - All addresses were succesfully unblocked.
    ///     Partial - Only a partial number of the addresses were unblocked successfully. Includes a list of the
    ///           addresses that failed and succeeded to be unblocked.
    ///     Failure - All addresses failed to be unblocked.
    func unblockEmailAddressesByHashedValue(hashedValues: [String]) async throws -> BatchOperationResult<String, String>

    /// Get email address blocklist for logged in user
    ///
    /// - Returns: The list of blocked email addresses
    func getEmailAddressBlocklist() async throws -> [UnsealedBlockedAddress]

    // MARK: - Subscriptions

    /// Subscribe to email message creation events.
    ///
    /// - Parameters:
    ///   - direction: Direction of the email message events to watch for. If `nil`, both directions will be watched.
    ///   - resultHandler: Email message created event.
    /// - Returns: `SubscriptionToken` object to cancel the subscription. On denitialization, the subscription will be cancelled.
    /// - Throws: `SudoEmailError` if an error occurs while setting up the initial connection the subscription.
    func subscribeToEmailMessageCreated(
        withDirection direction: EmailMessage.Direction?,
        resultHandler: @escaping ClientCompletion<EmailMessage>
    ) async throws -> SubscriptionToken?

    /// Subscribe to email message deleted events.
    /// - Parameters:
    ///   - id: Identifier of a specific deletion event to watch for. If `nil`, all deletion events will be handled.
    ///   - resultHandler: Email message deleted event.
    /// - Returns: `SubscriptionToken` object to cancel the subscription. On denitialization, the subscription will be cancelled.
    /// - Throws: `SudoEmailError` if an error occurs while setting up the initial connection the subscription.
    func subscribeToEmailMessageDeleted(
        withId id: String?,
        resultHandler: @escaping ClientCompletion<EmailMessage>
    ) async throws -> SubscriptionToken?

    /// Subscribe to email message updated events.
    /// - Parameters:
    ///   - id: Identifier of a specific deletion event to watch for. If `nil`, all update events will be handled.
    ///   - resultHandler: Email message update event.
    /// - Returns: `SubscriptionToken` object to cancel the subscription. On denitialization, the subscription will be cancelled.
    /// - Throws: `SudoEmailError` if an error occurs while setting up the initial connection the subscription.
    func subscribeToEmailMessageUpdated(
        withId id: String?,
        resultHandler: @escaping ClientCompletion<EmailMessage>
    ) async throws -> SubscriptionToken?

    /// Unsubscribe all subscribers from receiving sudo email notifications
    func unsubscribeAll()
}

public extension SudoEmailClient {

    func blockEmailAddresses(
        addresses: [String],
        action: UnsealedBlockedAddress.BlockedAddressAction = .drop,
        emailAddressId: String? = nil
    ) async throws -> BatchOperationResult<String, String> {
        try await blockEmailAddresses(addresses: addresses, action: action, emailAddressId: emailAddressId)
    }
//    func blockEmailAddresses(
//        addresses: [String],
//        action: UnsealedBlockedAddress.BlockedAddressAction = .drop,
//        emailAddressId: String
//    ) async throws -> BatchOperationResult<String, String> {
//        try await blockEmailAddresses(addresses: addresses, action: action, emailAddressId: emailAddressId)
//    }
}
