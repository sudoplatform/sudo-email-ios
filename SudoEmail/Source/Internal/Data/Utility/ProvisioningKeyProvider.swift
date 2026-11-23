//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

/// The public key an email address or email alias is provisioned with.
struct ProvisioningKey {

    /// The public key to register with the service.
    let publicKey: KeyEntity

    /// Whether the key pair was generated for this provisioning, so belongs to it alone and may be removed if the
    /// provisioning is rejected. `false` for a key pair the caller supplied and for the singleton key pair.
    let isGeneratedForProvisioning: Bool
}

/// Chooses the key pair an email address or email alias is provisioned with, following the client's
/// `SudoEmailClientConfig`.
class ProvisioningKeyProvider {

    // MARK: - Properties

    /// Cryptographic key worker for this device.
    let keyWorker: ServiceKeyWorker

    /// Options for how the client manages key pairs.
    let clientConfig: SudoEmailClientConfig

    /// Logs diagnostic and error information.
    let logger: Logger

    // MARK: - Lifecycle

    /// Initialize an instance of `ProvisioningKeyProvider`.
    /// - Parameters:
    ///   - keyWorker: Cryptographic key worker for this device.
    ///   - clientConfig: Options for how the client manages key pairs.
    ///   - logger: Logs diagnostic and error information.
    init(keyWorker: ServiceKeyWorker, clientConfig: SudoEmailClientConfig, logger: Logger) {
        self.keyWorker = keyWorker
        self.clientConfig = clientConfig
        self.logger = logger
    }

    // MARK: - Methods

    /// The key to provision with.
    ///
    /// - A `keyId` the caller supplied is used as is, if the client allows caller managed keys, even with a singleton
    ///   key pair enforced.
    /// - Otherwise, with a singleton key pair enforced, the singleton is used. It is never created here.
    /// - Otherwise a key pair is generated for this provisioning.
    ///
    /// - Parameter keyId: Identifier of the key pair the caller supplied, if any.
    /// - Returns: The key to provision with.
    /// - Throws:
    ///   - `SudoEmailError.invalidArgument` if `keyId` is supplied but the client doesn't allow caller managed keys.
    ///   - `SudoEmailError.keyNotFound` if the supplied key pair isn't on this device.
    ///   - `SudoEmailError.singletonKeyPairNotFound` if the enforced singleton isn't on this device.
    ///   - `SudoEmailError` if the key can't be read or generated.
    func key(forKeyId keyId: String?) async throws -> ProvisioningKey {
        do {
            if let keyId {
                guard clientConfig.allowCallerManagedKeys else {
                    throw SudoEmailError.invalidArgument(
                        "keyId can't be supplied when SudoEmailClientConfig.allowCallerManagedKeys is false"
                    )
                }
                guard let publicKey = try await keyWorker.getPublicKeyWithId(keyId: keyId) else {
                    throw SudoEmailError.keyNotFound
                }
                return ProvisioningKey(publicKey: publicKey, isGeneratedForProvisioning: false)
            }
            if clientConfig.enforceSingletonKeyPair {
                guard let publicKey = try await keyWorker.getSingletonKeyPair() else {
                    throw SudoEmailError.singletonKeyPairNotFound
                }
                return ProvisioningKey(publicKey: publicKey, isGeneratedForProvisioning: false)
            }
            let keyPair = try await keyWorker.generateKeyPair()
            return ProvisioningKey(publicKey: keyPair.publicKey, isGeneratedForProvisioning: true)
        } catch let error as SudoEmailError {
            logger.error("Error getting public key \(error.localizedDescription)")
            throw error
        } catch {
            logger.error("Error getting public key \(error.localizedDescription)")
            throw SudoEmailError.internalError(error.localizedDescription)
        }
    }

    /// Removes a key pair generated for a provisioning the service definitely didn't carry out. Does nothing for a
    /// key pair the caller supplied or for the singleton.
    ///
    /// Best effort: a failure is logged, never thrown, so it can't replace the provisioning error.
    /// - Parameter key: The key the provisioning used.
    func discardRejectedKey(_ key: ProvisioningKey) {
        guard key.isGeneratedForProvisioning else { return }
        do {
            try keyWorker.removeKeyPair(keyId: key.publicKey.keyId)
        } catch {
            logger.warning("Removing key pair \(key.publicKey.keyId) after a rejected provisioning failed: \(error.localizedDescription)")
        }
    }
}
