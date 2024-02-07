//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SudoUser
import SudoLogging

/// Generic type associated with API completion/closures. Generic type O is the expected output result in a
/// success case.
public typealias ClientCompletion<O> = (Swift.Result<O, Error>) -> Void

/// Generic type associated with Subscription Status change completion/closures.
public typealias SudoSubscriptionStatusChangeHandler = (PlatformSubscriptionStatus) -> Void

/// Maximum number of items that can be deleted per request.
public let deleteRequestLimit = 100

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
    /// - Parameters:
    ///   - input: Parameters used to send an email message
    /// - Returns:
    ///   - Success: Identifier of the email message that is being sent.
    ///   - Failure: `SudoEmailError`.
    func sendEmailMessage(withInput input: SendEmailMessageInput) async throws -> String

    /// Delete the email messages identified by the list of ids..
    /// - Parameters:
    ///   - ids: A list of one or more identifiers of the email messages to be deleted. There is a limit of
    ///   100 email message ids per API request. Exceeding this will cause an error to be thrown.
    /// - Returns:The status of the delete:
    ///    Success - All email messages succeeded to delete.
    ///    Partial - Only a partial amount of messages succeeded to delete. Includes a list of the
    ///              identifiers of the email messages that failed and succeeded to delete.
    ///    Failure - All email messages failed to delete.
    func deleteEmailMessages(withIds ids: [String]) async throws -> BatchOperationResult<String>

    /// Delete an email message.
    /// - Parameters:
    ///   - id: Identifier of the email message to be deleted.
    /// - Returns:
    ///   - Success: Identifier of the email message that was deleted.
    ///   - Failure: `SudoEmailError`.
    func deleteEmailMessage(withId id: String) async throws -> String?

    /// Update the email messages identified by a list of ids.
    ///  - Parameters:
    ///    - input: Input parameters used to update a list of email messages
    ///  - Returns: The status of the updates:
    ///     Success - All email messages succeeded to update.
    ///     Partial - Only a partial number of messages succeeded to update. Includes a list of the
    ///           identifiers of the email messages that failed and succeeded to update.
    ///    Failure - All email messages failed to update.
    func updateEmailMessages(withInput input: UpdateEmailMessagesInput) async throws -> BatchOperationResult<String>

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
    /// Draft email messages can only be deleted in batches of 10. Anything greater will throw a LimitExceededError.
    /// Any draft email message ids that do not exist will be marked as success.
    /// Any emailAddressId that is not owned or does not exist, will throw an error.
    ///  - Parameters:
    ///    - input: Input parameters used to delete a list of draft email messages.
    ///  - Returns: The status of the delete:
    ///     Success - All draft email messages succeeded to delete.
    ///     Partial - Only a partial number of the draft email messages were deleted successfully. Includes a list of the
    ///           identifiers of the draft email messages that failed and succeeded to delete.
    ///     Failure - All draft email messages failed to delete.
    func deleteDraftEmailMessages(
        withInput input: DeleteDraftEmailMessagesInput
    ) async throws -> BatchOperationResult<String>

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

    /// Get a list of the supported email domains from the service.
    /// - Parameters:
    ///   - cachePolicy: Determines how the data is fetched. When using `cacheOnly`, please be aware that this will only return cached results of similar exact
    ///       API calls.
    /// - Returns:
    ///   - Success: Array of supported domains.
    ///   - Failure: `SudoEmailError`.
    func getSupportedEmailDomains(_ cachePolicy: CachePolicy) async throws -> [String]

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
    func getEmailMessageRfc822Data(withInput input: GetEmailMessageRfc822DataInput) async throws -> Data

    /// Get a draft email message that has been saved previously.
    ///  - Parameters:
    ///    - input: Parameters used to retrieve a draft email message
    ///  - Returns:
    ///    - The draft email message identified by id or undefined if not found.
    func getDraftEmailMessage(withInput input: GetDraftEmailMessageInput) async throws -> DraftEmailMessage?

    /// Get the list of draft email message metadata for the specified email address.
    ///  - Parameters:
    ///   - emailAddressId: The identifier of the email address associated with the draft email messages.
    ///  - Returns:
    ///    - An array of draft email message metadata or an empty array if no matching draft email messages can be found.
    func listDraftEmailMessageMetadata(emailAddressId: String) async throws -> [DraftEmailMessageMetadata]

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
    ///  - Returns: The status of the blocking:
    ///     Success - All addresses were succesfully blocked.
    ///     Partial - Only a partial number of the addresses were blocked successfully. Includes a list of the
    ///           addresses that failed and succeeded to be blocked.
    ///     Failure - All addresses failed to be blocked.
    func blockEmailAddresses(addresses: [String]) async throws -> BatchOperationResult<String>
    
    /// Unblocks the addresses given from sending to the user
    ///
    ///  - Parameters:
    ///    - addresses: Array of addresses to unblock as strings
    ///  - Returns: The status of the unblocking:
    ///     Success - All addresses were succesfully unblocked.
    ///     Partial - Only a partial number of the addresses were unblocked successfully. Includes a list of the
    ///           addresses that failed and succeeded to be unblocked.
    ///     Failure - All addresses failed to be unblocked.
    func unblockEmailAddresses(addresses: [String]) async throws -> BatchOperationResult<String>
    
    /// Get email address blocklist for logged in user
    ///
    /// - Returns: The list of blocked email addresses
    func getEmailAddressBlocklist() async throws -> [String]

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

    /// Unsubscribe all subscribers from receiving sudo email notifications
    func unsubscribeAll()
}
