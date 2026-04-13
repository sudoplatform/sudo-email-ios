//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of an email mask repository used in business logic. Used to perform CRUD operations for email masks.
protocol EmailMaskRepository: Repository {

    /// Provision a new email mask.
    /// - Parameters:
    ///   - maskAddress: The email mask address to provision, in the form `${localPart}@${domain}`.
    ///   - realAddress: The real email address to which the mask will forward to.
    ///   - ownershipProofToken: The signed ownership proof of the Sudo to be associated with the provisioned email mask.
    ///   - publicKey: Public key to be associated with the email mask. Used to encrypt user data.
    ///   - metadata: Optional name/value pair metadata to associate with the email mask.
    ///   - expiresAt: Optional expiration date for the email mask.
    /// - Returns: The newly provisioned email mask entity.
    func provisionEmailMask(
        maskAddress: String,
        realAddress: String,
        ownershipProofToken: String,
        publicKey: KeyEntity,
        metadata: [String: String]?,
        expiresAt: Date?
    ) async throws -> EmailMaskEntity

    /// Deprovision an existing email mask.
    /// - Parameters:
    ///   - emailMaskId: The unique identifier of email mask to deprovision.
    /// - Returns: The deprovisioned email mask entity.
    func deprovisionEmailMask(emailMaskId: String) async throws -> EmailMaskEntity

    /// Update an existing email mask's metadata and/or expiration date.
    /// - Parameters:
    ///   - emailMaskId: The unique identifier of email mask to update.
    ///   - metadata: Optional name/value pair metadata to associate with the email mask. Provide empty map to clear.
    ///   - expiresAt: Optional expiration date for the email mask. Provide date of 0 to clear existing expiration.
    /// - Returns: The updated email mask entity.
    func updateEmailMask(
        emailMaskId: String,
        metadata: [String: String]?,
        expiresAt: Date?
    ) async throws -> EmailMaskEntity

    /// Enable a previously disabled email mask, allowing it to forward emails again.
    /// - Parameters:
    ///   - emailMaskId: The unique identifier of email mask to enable.
    /// - Returns: The enabled email mask entity.
    func enableEmailMask(emailMaskId: String) async throws -> EmailMaskEntity

    /// Disable an active email mask, preventing it from forwarding emails.
    /// - Parameters:
    ///   - emailMaskId: The unique identifier of email mask to disable.
    /// - Returns: The disabled email mask entity.
    func disableEmailMask(emailMaskId: String) async throws -> EmailMaskEntity

    /// Verify an external email address for use with email masking.
    /// - Parameters:
    ///   - emailAddress: The external email address to verify.
    ///   - emailMaskId: The unique identifier of the email mask.
    ///   - verificationCode: Optional verification code.
    /// - Returns: The verification result entity.
    func verifyExternalEmailAddress(emailAddress: String, emailMaskId: String, verificationCode: String?) async throws -> VerifyExternalEmailAddressResultEntity

    /// List email masks owned by the current user with optional filtering and pagination.
    /// - Parameters:
    ///   - filter: Optional filter to apply to the email masks being listed.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    /// - Returns: A list of email mask entities with pagination information.
    func listEmailMasksForOwner(filter: EmailMaskFilterEntity?, limit: Int?, nextToken: String?) async throws -> ListOutputEntity<EmailMaskEntity>
}
