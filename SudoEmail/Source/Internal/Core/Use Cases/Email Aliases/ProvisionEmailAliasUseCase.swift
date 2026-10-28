//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of an operation to provision an email alias.
///
/// Provisions a new email alias with the specified configuration.
class ProvisionEmailAliasUseCase {

    // MARK: - Properties

    /// Cryptographic key worker for this device
    let keyWorker: ServiceKeyWorker

    /// Email alias repository to access the email alias from the service.
    let emailAliasRepository: EmailAliasRepository

    /// Domain repository to access domain information.
    let domainRepository: DomainRepository

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `ProvisionEmailAliasUseCase`.
    init(keyWorker: ServiceKeyWorker, emailAliasRepository: EmailAliasRepository, domainRepository: DomainRepository, logger: Logger) {
        self.keyWorker = keyWorker
        self.emailAliasRepository = emailAliasRepository
        self.domainRepository = domainRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - aliasAddress: The email alias address to provision, in the form `${localPart}@${domain}`.
    ///   - realAddress: The real email address to which the alias will forward to, in the form `${localPart}@${domain}`.
    ///   - ownershipProofToken: The signed ownership proof of the Sudo to be associated with the provisioned email alias.
    ///   - metadata: Optional name/value pair metadata to associate with the email alias.
    ///   - expiresAt: Optional expiration date for the email alias. If not provided, the alias does not expire.
    ///   - keyId: Optional identifier of the Public Key to use to provision the email alias.
    /// - Returns: The newly provisioned email alias entity.
    func execute(
        aliasAddress: String,
        realAddress: String,
        ownershipProofToken: String,
        metadata: [String: String]?,
        expiresAt: Date?,
        keyId: String?
    ) async throws -> EmailAliasEntity {
        logger.info("Provisioning email alias: \(aliasAddress) -> \(realAddress)")

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

        return try await emailAliasRepository.provisionEmailAlias(
            aliasAddress: aliasAddress,
            realAddress: realAddress,
            ownershipProofToken: ownershipProofToken,
            publicKey: publicKey,
            metadata: metadata,
            expiresAt: expiresAt
        )
    }
}
