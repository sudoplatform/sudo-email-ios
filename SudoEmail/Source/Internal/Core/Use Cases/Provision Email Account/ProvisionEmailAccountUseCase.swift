//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Core use case representation of a operation to provision an email account.
///
/// Performs the following operations:
/// - Chooses the key pair to provision with, following the client's `SudoEmailClientConfig`.
/// - Calls the sudo email service provision email api to finish the provision.
/// - Removes a key pair generated for the provision if the service definitely didn't carry it out.
class ProvisionEmailAccountUseCase {

    // MARK: - Properties: Repositories

    /// Key pair repository to access the public key for the user's account.
    let keyWorker: ServiceKeyWorker

    /// Email account repository to create the email account.
    let emailAccountRepository: EmailAccountRepository

    /// Chooses the key pair to provision with, and removes it if the provision is rejected.
    let keyProvider: ProvisioningKeyProvider

    // MARK: - Properties

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of the `ProvisionEmailAccount` use case.
    init(
        keyWorker: ServiceKeyWorker,
        emailAccountRepository: EmailAccountRepository,
        clientConfig: SudoEmailClientConfig = SudoEmailClientConfig(),
        logger: Logger = .emailSDKLogger
    ) {
        self.keyWorker = keyWorker
        self.emailAccountRepository = emailAccountRepository
        self.logger = logger
        keyProvider = ProvisioningKeyProvider(keyWorker: keyWorker, clientConfig: clientConfig, logger: logger)
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameter input: Parameters used to provision the email address.
    /// - Returns: A newly created email account.
    /// - Throws: `SudoEmailError`; see `ProvisioningKeyProvider.key(forKeyId:)` for the key errors.
    func execute(withInput input: ProvisionEmailAddressInput) async throws -> EmailAccountEntity {
        let key = try await keyProvider.key(forKeyId: input.keyId)
        let emailAccount = try await emailAccountRepository.createWithEmailAddress(
            input.emailAddress,
            publicKey: key.publicKey,
            ownershipProofToken: input.ownershipProofToken,
            displayName: input.displayName,
            onDefinitiveRejection: { keyProvider.discardRejectedKey(key) }
        )
        return emailAccount
    }
}
