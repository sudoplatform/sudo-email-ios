//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
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
    let keyWorker: DeviceKeyWorker

    /// Email account repository to create the email account.
    let emailAccountRepository: EmailAccountRepository

    // MARK: - Properties

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of the `ProvisionEmailAccount` use case.
    init(
        keyWorker: DeviceKeyWorker,
        emailAccountRepository: EmailAccountRepository,
        logger: Logger = .emailSDKLogger
    ) {
        self.keyWorker = keyWorker
        self.emailAccountRepository = emailAccountRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - emailAddress: Email address to use to provision.
    ///   - sudoId: Identifier of the sudo to provision the email account to.
    /// - Returns: A newly created email account.
    func execute(emailAddress: EmailAddressEntity, ownershipProofToken: String) async throws -> EmailAccountEntity {
        let publicKey: KeyEntity
        do {
            let keyPair = try keyWorker.generateKeyPair()
            publicKey = keyPair.publicKey
        } catch {
            throw SudoEmailError.internalError(error.localizedDescription)
        }
        let emailAccount = try await self.emailAccountRepository.createWithEmailAddress(
            emailAddress,
            publicKey: publicKey,
            ownershipProofToken: ownershipProofToken
        )
        return emailAccount
    }
}
