//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a email account repository used in business logic. Used to perform CRUD operations for email accounts.
protocol EmailAccountRepository: AnyObject {

    /// Check the availability of a combination of email addresses
    /// - Parameters:
    ///   - localParts: The local parts of the email address to check.
    ///   - domains: The domains of the email address to check.
    /// - Returns: The list of email addresses that are available.
    func checkEmailAddressAvailabilityWithLocalParts(
        _ localParts: [String],
        domains: [DomainEntity]?
    ) async throws -> [EmailAddressEntity]

    /// Create an email account.
    /// - Parameters:
    ///   - emailAddress: Email address to use to create the email account.
    ///   - publicKey: Public key to be associated with the account. Used to encrypt user data.
    ///   - ownershipProofToken: A signed ownership proof of the user to create the account.
    /// - Returns: The email account that was created.
    func createWithEmailAddress(
        _ emailAddress: EmailAddressEntity,
        publicKey: KeyEntity,
        ownershipProofToken: String
    ) async throws -> EmailAccountEntity

    /// Delete an email account.
    /// - Parameters:
    ///   - id: Identifier of the email address to delete the associated account.
    ///   - Returns the email account that was deleted on success, or error on failure.
    func deleteWithId(_ id: String) async throws -> EmailAccountEntity

    /// Update email account metadata
    /// - Parameters:
    ///  - id: Identifier of the email address to update metadata.
    ///  - values: The metadata values to update
    /// - Returns: the identifier of the email account for which the metadata was updated.
    func updateMetadata(id: String, values: UpdateEmailAddressMetadataValues) async throws -> String

    /// Get the email account that matches the input `emailAddress`. Fetches the account locally from the device.
    /// - Parameters:
    ///   - id: Identifier of the email address to match to a record to return from the service.
    ///   - Returns on success, the record of the account, or `nil` if the address does not match any records. Returns failure on error.
    func getWithEmailAddressId(_ id: String) async throws -> EmailAccountEntity?

    /// Get the email account that matches the input `emailAddress`. Fetches the account remotely from the email service.
    /// - Parameters:
    ///   - id: Identifier of the email address to match to a record to return from the service.
    ///   - Returns  the record of the account on success, or `nil` if the address does not match any records. Returns failure on error.
    func fetchWithEmailAddressId(_ id: String) async throws -> EmailAccountEntity?

    /// Fetch the list of email accounts remotely.
    /// - Parameters:
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    ///   - Returns a list of results with a next token if there are more results to fetch, or error on failure.
    func fetchList(
        limit: Int?,
        nextToken: String?
    ) async throws -> ListOutputEntity<EmailAccountEntity>

    /// Get the list of email accounts from the device cache.
    /// - Parameters:
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    ///   - Returns a list of results with a next token if there are more results to fetch, or error on failure.
    func list(
        limit: Int?,
        nextToken: String?
    ) async throws -> ListOutputEntity<EmailAccountEntity>

    /// Get the list of email accounts for the specified sudo.
    /// - Parameters:
    ///   - sudoId: the unique identifier of the sudo associated with the email accounts to retrieve
    ///   - cachePolicy: Determines how the email address will be fetched. Default usage is `remoteOnly`.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    ///   - Returns a list of results with a next token if there are more results to fetch, or error on failure.
    func listForSudoId(
        sudoId: String,
        cachePolicy: CachePolicy?,
        limit: Int?,
        nextToken: String?
    ) async throws -> ListOutputEntity<EmailAccountEntity>

    /// Retrieve a list email address public info objects for provided email addresses.
    /// - Parameters:
    ///   - emailAddresses: A list of email address strings in format 'local-part@domain'.
    ///   - cachePolicy: Determines how the public info will be fetched. Default usage is `remoteOnly`.   
    ///   - Returns: The list of public info objects found, or empty if no email addresses or public keys were found.
    func lookupPublicInfo(
        emailAddresses: [String],
        cachePolicy: CachePolicy?
    ) async throws -> [EmailAddressPublicInfoEntity]
}
