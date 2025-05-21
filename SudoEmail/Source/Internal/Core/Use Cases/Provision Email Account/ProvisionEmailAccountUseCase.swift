//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of a operation to provision an email account.
///
/// Performs the following operations:
/// - Checks to see if the device key is registered and if not, will register the key.
/// - Gets the user's ownership proof for the account.
/// - Calls the sudo email service provision email api to finish the provision.
class ProvisionEmailAccountUseCase {

    // MARK: - Properties: Repositories

    /// Key pair repository to access the public key for the user's account.
    let keyWorker: ServiceKeyWorker

    /// Email account repository to create the email account.
    let emailAccountRepository: EmailAccountRepository

    // MARK: - Properties

    /// Identifier of the Public Key to provision the email account with.
    let keyId: String?

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of the `ProvisionEmailAccount` use case.
    init(
        keyWorker: ServiceKeyWorker,
        emailAccountRepository: EmailAccountRepository,
        keyId: String? = nil,
        logger: Logger = .emailSDKLogger
    ) {
        self.keyWorker = keyWorker
        self.emailAccountRepository = emailAccountRepository
        self.keyId = keyId
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - emailAddress: Email address to use to provision.
    ///   - sudoId: Identifier of the sudo to provision the email account to.
    /// - Returns: A newly created email account.
    func execute(emailAddress: EmailAddressEntity, ownershipProofToken: String) async throws -> EmailAccountEntity {
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
        let emailAccount = try await emailAccountRepository.createWithEmailAddress(
            emailAddress,
            publicKey: publicKey,
            ownershipProofToken: ownershipProofToken
        )
        return emailAccount
    }
}
