//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoOperations
import SudoLogging

/// Get the registered public key.
///
/// If a key pair has not been generated, a new keypair will first be generated. The operation then checks to see if the public key is registered. If
/// registered, the key is immediately returned. If not, it will register it and return the key.
class GetRegisteredPublicKeyOperation: PlatformOperation {

    // MARK: - Properties

    /// Result object of the operation. The registered public key.
    var resultObject: KeyEntity?

    /// Key pair repository to perform operations against.
    unowned let keyRepository: KeyRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `GetRegisteredKeyPairOperation`.
    init(keyRepository: KeyRepository, logger: Logger) {
        self.keyRepository = keyRepository
        super.init(logger: logger)
    }

    // MARK: - PlatformOperation

    override func execute() {
        let currentPublicKey: KeyEntity
        do {
            if let keyPair = try keyRepository.getCurrentKeyPair() {
                currentPublicKey = keyPair.publicKey
            } else {
                let currentKeyPair = try keyRepository.generate()
                currentPublicKey = currentKeyPair.publicKey
            }
        } catch {
            finishWithError(error)
            return
        }
        keyRepository.isPublicKeyRegistered(currentPublicKey) { [weak self] result in
            guard let weakSelf = self else { return }
            let isRegistered: Bool
            do {
                isRegistered = try result.get()
            } catch {
                weakSelf.finishWithError(error)
                return
            }
            if isRegistered {
                weakSelf.resultObject = currentPublicKey
                weakSelf.finish()
                return
            }
            weakSelf.keyRepository.registerPublicKey(currentPublicKey) { [weak self] result in
                guard let weakSelf = self else { return }
                switch result {
                case let .success(registeredPublicKey):
                    weakSelf.resultObject = registeredPublicKey
                    weakSelf.finish()
                    return
                case let .failure(error):
                    weakSelf.finishWithError(error)
                }
            }
        }
    }

}
