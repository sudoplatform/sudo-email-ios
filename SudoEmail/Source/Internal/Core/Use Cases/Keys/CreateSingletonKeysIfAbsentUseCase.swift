//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core use case representation of an operation to create the singleton key pair, if this device doesn't have it.
class CreateSingletonKeysIfAbsentUseCase {

    // MARK: - Properties

    /// Cryptographic key worker for this device.
    let keyWorker: ServiceKeyWorker

    /// Whether the client enforces a singleton key pair.
    let enforceSingletonKeyPair: Bool

    // MARK: - Lifecycle

    /// Initialize an instance of `CreateSingletonKeysIfAbsentUseCase`.
    /// - Parameters:
    ///   - keyWorker: Cryptographic key worker for this device.
    ///   - enforceSingletonKeyPair: Whether the client enforces a singleton key pair.
    init(keyWorker: ServiceKeyWorker, enforceSingletonKeyPair: Bool) {
        self.keyWorker = keyWorker
        self.enforceSingletonKeyPair = enforceSingletonKeyPair
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Returns: Whether the singleton key pair was created, and its ID.
    /// - Throws: `SudoEmailError.invalidConfig` if the client doesn't enforce a singleton key pair, since each email
    ///   address and email alias then gets its own key when it is provisioned; otherwise `SudoEmailError` if the key
    ///   can't be created.
    func execute() async throws -> CreateSingletonKeysIfAbsentResult {
        guard enforceSingletonKeyPair else {
            throw SudoEmailError.invalidConfig
        }
        let result = try await keyWorker.createSingletonKeyPairIfAbsent()
        return CreateSingletonKeysIfAbsentResult(keyPair: .init(created: result.created, keyId: result.key.keyId))
    }
}
