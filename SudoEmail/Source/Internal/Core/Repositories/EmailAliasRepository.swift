//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of an email alias repository used in business logic. Used to perform CRUD operations for email aliases.
protocol EmailAliasRepository: Repository {

    /// Provision a new email alias.
    /// - Parameters:
    ///   - aliasAddress: The email alias address to provision, in the form `${localPart}@${domain}`.
    ///   - realAddress: The real email address to which the alias will forward to.
    ///   - ownershipProofToken: The signed ownership proof of the Sudo to be associated with the provisioned email alias.
    ///   - publicKey: Public key to be associated with the email alias. Used to encrypt user data.
    ///   - metadata: Optional name/value pair metadata to associate with the email alias.
    ///   - expiresAt: Optional expiration date for the email alias.
    /// - Returns: The newly provisioned email alias entity.
    func provisionEmailAlias(
        aliasAddress: String,
        realAddress: String,
        ownershipProofToken: String,
        publicKey: KeyEntity,
        metadata: [String: String]?,
        expiresAt: Date?
    ) async throws -> EmailAliasEntity

    /// Deprovision an existing email alias.
    /// - Parameters:
    ///   - emailAliasId: The unique identifier of email alias to deprovision.
    /// - Returns: The deprovisioned email alias entity.
    func deprovisionEmailAlias(emailAliasId: String) async throws -> EmailAliasEntity

    /// Update an existing email alias's metadata and/or expiration date.
    /// - Parameters:
    ///   - emailAliasId: The unique identifier of email alias to update.
    ///   - metadata: Optional name/value pair metadata to associate with the email alias. Provide empty map to clear.
    ///   - expiresAt: Optional expiration date for the email alias. Provide date of 0 to clear existing expiration.
    ///   - realAddress: Optional real email address for the email alias. Only valid for external aliases in a pending state.
    /// - Returns: The updated email alias entity.
    func updateEmailAlias(
        emailAliasId: String,
        metadata: [String: String]?,
        expiresAt: Date?,
        realAddress: String?
    ) async throws -> EmailAliasEntity

    /// Enable a previously disabled email alias, allowing it to forward emails again.
    /// - Parameters:
    ///   - emailAliasId: The unique identifier of email alias to enable.
    /// - Returns: The enabled email alias entity.
    func enableEmailAlias(emailAliasId: String) async throws -> EmailAliasEntity

    /// Disable an active email alias, preventing it from forwarding emails.
    /// - Parameters:
    ///   - emailAliasId: The unique identifier of email alias to disable.
    /// - Returns: The disabled email alias entity.
    func disableEmailAlias(emailAliasId: String) async throws -> EmailAliasEntity

    /// Verify an external email address for use with email aliasing.
    /// - Parameters:
    ///   - emailAddress: The external email address to verify.
    ///   - emailAliasId: The unique identifier of the email alias.
    ///   - verificationCode: Optional verification code.
    /// - Returns: The verification result entity.
    func verifyExternalEmailAddress(emailAddress: String, emailAliasId: String, verificationCode: String?) async throws -> VerifyExternalEmailAddressResultEntity

    /// List email aliases owned by the current user with optional filtering and pagination.
    /// - Parameters:
    ///   - filter: Optional filter to apply to the email aliases being listed.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    /// - Returns: A list of email alias entities with pagination information.
    func listEmailAliasesForOwner(filter: EmailAliasFilterEntity?, limit: Int?, nextToken: String?) async throws -> ListOutputEntity<EmailAliasEntity>
}
