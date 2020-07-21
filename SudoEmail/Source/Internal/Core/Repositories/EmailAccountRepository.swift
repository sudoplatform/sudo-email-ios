//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a email account repository used in business logic. Used to perform CRUD operations for email accounts.
protocol EmailAccountRepository: class {

    /// Create an email account.
    /// - Parameters:
    ///   - emailAddress: Email address to use to create the email account.
    ///   - publicKey: Public key to be associated with the account. Used to encrypt user data.
    ///   - ownershipProof: Ownership proof of the user to create the account.
    ///   - completion: Returns a newly created email account on success, or error on failure.
    func createWithEmailAddress(
        _ emailAddress: EmailAddressEntity,
        publicKey: KeyEntity,
        ownershipProof: String,
        completion: @escaping ClientCompletion<EmailAccountEntity>
    )

    /// Delete an email account.
    /// - Parameters:
    ///   - emailAddress: Email address to delete the account of.
    ///   - completion: Returns the email account that was deleted on success, or error on failure.
    func deleteWithEmailAddress(_ emailAddress: EmailAddressEntity, completion: @escaping ClientCompletion<EmailAccountEntity>)

    /// Get the email account that matches the input `emailAddress`. Fetches the account locally from the device.
    /// - Parameters:
    ///   - emailAddress: Email address to match to a record to return from the service.
    ///   - completion: Returns on success, the record of the account, or `nil` if the address does not match any records. Returns failure on error.
    func getWithEmailAddress(_ emailAddress: EmailAddressEntity, completion: @escaping ClientCompletion<EmailAccountEntity?>)

    /// Get the email account that matches the input `emailAddress`. Fetches the account remotely from the email service.
    /// - Parameters:
    ///   - emailAddress: Email address to match to a record to return from the service.
    ///   - completion: Returns on success, the record of the account, or `nil` if the address does not match any records. Returns failure on error.
    func fetchWithEmailAddress(_ emailAddress: EmailAddressEntity, completion: @escaping ClientCompletion<EmailAccountEntity?>)

    /// Fetch the list of email accounts remotely.
    /// - Parameters:
    ///   - filter: Filter rules to be applied to the list.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    ///   - completion: Returns a list of results with a next token is there if more results to fetch, or error on failure.
    func fetchListWithFilter(
        _ filter: EmailAccountFilterEntity?,
        limit: Int?,
        nextToken: String?,
        completion: @escaping ClientCompletion<ListOutputEntity<EmailAccountEntity>>
    )

    /// Get the list of email accounts from the device cache.
    /// - Parameters:
    ///   - filter: Filter rules to be applied to the list.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    ///   - completion: Returns a list of results with a next token is there if more results to fetch, or error on failure.
    func listWithFilter(
        _ filter: EmailAccountFilterEntity?,
        limit: Int?,
        nextToken: String?,
        completion: @escaping ClientCompletion<ListOutputEntity<EmailAccountEntity>>
    )

}
