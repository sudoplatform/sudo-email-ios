//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

typealias KeyPair = (publicKey: KeyEntity, privateKey: KeyEntity)

/// Core entity representation of a public/private key pair repository used in business logic. Used to perform CRUD operations for key pairs.
protocol KeyRepository: class {

    // MARK: - Key Pair

    /// Generate a key pair on the device. Returns the freshly generated key pair.
    /// Throws: `SudoEmailError`.
    func generate() throws -> KeyPair

    /// Get the current key pair on the device. Returns `nil` if there is no current key pair.
    /// Throws: `SudoEmailError`.
    func getCurrentKeyPair() throws -> KeyPair?

    // MARK: - PublicKey

    /// Register a public key to the service.
    /// - Parameters:
    ///   - publicKey: Public key to be registered.
    ///   - completion: Returns the successfully registered public key on success, or error on failure.
    func registerPublicKey(_ publicKey: KeyEntity, completion: @escaping ClientCompletion<KeyEntity>)

    /// Determine if a key is registered to the service.
    /// - Parameters:
    ///   - publicKey: Public key to determine if registered.
    ///   - completion: Returns true if key is registered on success, or error on failure.
    func isPublicKeyRegistered(_ publicKey: KeyEntity, completion: @escaping ClientCompletion<Bool>)

    /// Get a public key by its id. If no key can be found, `nil` will be returned.
    /// - Parameters:
    ///   - id: Identifier of the key.
    ///   - completion: Returns the public key (or `nil` if cannot be found), or error on failure.
    func getPublicKeyById(_ id: String, completion: @escaping ClientCompletion<KeyEntity?>)

}
