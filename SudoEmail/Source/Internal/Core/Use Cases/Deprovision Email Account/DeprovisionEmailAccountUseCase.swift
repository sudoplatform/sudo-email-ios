//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// Result of `DeprovisionEmailAccountUseCase.execute(emailAccountId:)`.
struct DeprovisionEmailAccountResult: Equatable {

    /// The email account that was deprovisioned.
    let emailAccount: EmailAccountEntity

    /// Identifiers of key pairs that were due to be removed from the device but couldn't be. Empty if every removal
    /// succeeded, or none was due.
    let keyIdsNotRemoved: [String]
}

/// Core use case representation of a operation to deprovision an email account.
///
/// Once the service has deprovisioned the email account, if the client doesn't allow caller managed keys, the account's
/// key pairs are removed from the device, except a key pair that another email address or email alias still uses.
/// Nothing is removed while the client allows caller managed keys or enforces a singleton key pair, and the singleton
/// is never removed.
class DeprovisionEmailAccountUseCase {

    // MARK: - Properties

    /// Email account repository to delete the email account.
    let emailAccountRepository: EmailAccountRepository

    /// Cryptographic key worker for this device.
    let keyWorker: ServiceKeyWorker

    /// Options for how the client manages key pairs.
    let clientConfig: SudoEmailClientConfig

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `DeprovisionEmailAccountUseCase`.
    init(
        emailAccountRepository: EmailAccountRepository,
        keyWorker: ServiceKeyWorker,
        clientConfig: SudoEmailClientConfig = SudoEmailClientConfig(),
        logger: Logger = .emailSDKLogger
    ) {
        self.emailAccountRepository = emailAccountRepository
        self.keyWorker = keyWorker
        self.clientConfig = clientConfig
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameter emailAccountId: Identifier of the email account to deprovision.
    /// - Returns: The email account that was deprovisioned, and any key pairs that couldn't be removed.
    /// - Throws: `SudoEmailError` if the service doesn't deprovision the email account.
    func execute(emailAccountId: String) async throws -> DeprovisionEmailAccountResult {
        let emailAccount = try await emailAccountRepository.deleteWithId(emailAccountId)
        let keyIdsNotRemoved = await removeUnusedKeyPairs(of: emailAccount)
        return DeprovisionEmailAccountResult(emailAccount: emailAccount, keyIdsNotRemoved: keyIdsNotRemoved)
    }

    // MARK: - Helpers

    /// Removes the deprovisioned email account's key pairs from the device, unless another email address or email
    /// alias still uses them.
    ///
    /// Any doubt keeps a key pair: if the singleton or the service's key registrations can't be read, nothing is
    /// removed.
    /// - Parameter emailAccount: The deprovisioned email account.
    /// - Returns: Identifiers of key pairs that were due to be removed but couldn't be.
    func removeUnusedKeyPairs(of emailAccount: EmailAccountEntity) async -> [String] {
        guard !clientConfig.allowCallerManagedKeys, !clientConfig.enforceSingletonKeyPair else {
            return []
        }
        let candidateKeyIds: [String]
        do {
            let singletonKeyId = try keyWorker.singletonKeyId()
            candidateKeyIds = emailAccount.keyIds.filter { $0 != singletonKeyId }
        } catch {
            logger.warning("Keeping the key pairs of deprovisioned email account \(emailAccount.id): reading the singleton key id failed: \(error)")
            return []
        }
        guard !candidateKeyIds.isEmpty else {
            return []
        }

        let keyIdsInUse: Set<String>
        do {
            // The deprovisioned account's own registrations may still be listed until the service removes them.
            keyIdsInUse = try await Set(
                emailAccountRepository.listPublicKeyRegistrations()
                    .filter { $0.keyRingId != emailAccount.keyRingId }
                    .map(\.keyId)
            )
        } catch {
            logger.warning("Keeping the key pairs of deprovisioned email account \(emailAccount.id): listing key registrations failed: \(error)")
            return []
        }

        var keyIdsNotRemoved: [String] = []
        for keyId in candidateKeyIds where !keyIdsInUse.contains(keyId) {
            do {
                try keyWorker.removeKeyPair(keyId: keyId)
            } catch {
                logger.error("Removing key pair \(keyId) of deprovisioned email account \(emailAccount.id) failed: \(error)")
                keyIdsNotRemoved.append(keyId)
            }
        }
        return keyIdsNotRemoved
    }
}
