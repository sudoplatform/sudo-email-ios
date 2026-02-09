//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of an operation to provision an email mask.
///
/// Provisions a new email mask with the specified configuration.
class ProvisionEmailMaskUseCase {

    // MARK: - Properties

    /// Cryptographic key worker for this device
    let keyWorker: ServiceKeyWorker

    /// Email mask repository to access the email mask from the service.
    let emailMaskRepository: EmailMaskRepository

    /// Domain repository to access domain information.
    let domainRepository: DomainRepository

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `ProvisionEmailMaskUseCase`.
    init(keyWorker: ServiceKeyWorker, emailMaskRepository: EmailMaskRepository, domainRepository: DomainRepository, logger: Logger) {
        self.keyWorker = keyWorker
        self.emailMaskRepository = emailMaskRepository
        self.domainRepository = domainRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - maskAddress: The email mask address to provision, in the form `${localPart}@${domain}`.
    ///   - realAddress: The real email address to which the mask will forward to, in the form `${localPart}@${domain}`.
    ///   - ownershipProofToken: The signed ownership proof of the Sudo to be associated with the provisioned email mask.
    ///   - metadata: Optional name/value pair metadata to associate with the email mask.
    ///   - expiresAt: Optional expiration date for the email mask. If not provided, the mask does not expire.
    ///   - keyId: Optional identifier of the Public Key to use to provision the email mask.
    /// - Returns: The newly provisioned email mask entity.
    func execute(
        maskAddress: String,
        realAddress: String,
        ownershipProofToken: String,
        metadata: [String: String]?,
        expiresAt: Date?,
        keyId: String?
    ) async throws -> EmailMaskEntity {
        logger.info("Provisioning email mask: \(maskAddress) -> \(realAddress)")

        var publicKey: KeyEntity
        do {
            if let keyId = keyId {
                guard let pubKey = try await keyWorker.getPublicKeyWithId(keyId: keyId) else {
                    throw SudoEmailError.keyNotFound
                }
                publicKey = pubKey
            } else {
                let keyPair = try await keyWorker.generateKeyPair()
                publicKey = keyPair.publicKey
            }
        } catch let error as SudoEmailError {
            logger.error("Error getting public key \(error.localizedDescription)")
            throw error
        } catch {
            logger.error("Error getting public key \(error.localizedDescription)")
            throw SudoEmailError.internalError(error.localizedDescription)
        }

        return try await emailMaskRepository.provisionEmailMask(
            maskAddress: maskAddress,
            realAddress: realAddress,
            ownershipProofToken: ownershipProofToken,
            publicKey: publicKey,
            metadata: metadata,
            expiresAt: expiresAt
        )
    }
}
