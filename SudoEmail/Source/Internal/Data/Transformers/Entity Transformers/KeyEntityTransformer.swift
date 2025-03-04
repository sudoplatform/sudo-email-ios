//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct KeyEntityTransformer {

    /// Transform the success result of `CreatePublicKeyForEmailMutation` from the service to a `KeyEntity` with `publicKey` type.
    /// - Parameter data: GraphQL data to transform.
    /// - Throws: `SudoEmailError`.
    /// - Returns: Public key entity.
    func transformPublicKey(_ data: GraphQL.CreatePublicKeyForEmailMutation.Data) throws -> KeyEntity {
        let gqlKey = data.createPublicKeyForEmail
        guard let keyData = Data(base64Encoded: gqlKey.publicKey) else {
            throw SudoEmailError.internalError("Public key string not base 64 encoded")
        }
        let entity = KeyEntity(type: .publicKey, keyId: gqlKey.keyId, keyRingId: gqlKey.keyRingId, keyData: keyData)
        return entity
    }

    /// Transform the success result of `GetPublicKeyForEmailQuery` from the service to a `KeyEntity` with `publicKey` type.
    /// - Parameter data: GraphQL data to transform.
    /// - Throws: `SudoEmailError`.
    /// - Returns: Public key entity.
    func transformPublicKey(_ data: GraphQL.GetPublicKeyForEmailQuery.Data) throws -> KeyEntity? {
        guard let gqlKey = data.getPublicKeyForEmail else {
            return nil
        }
        guard let keyData = Data(base64Encoded: gqlKey.publicKey) else {
            throw SudoEmailError.internalError("Public key string not base 64 encoded")
        }
        let entity = KeyEntity(type: .publicKey, keyId: gqlKey.keyId, keyRingId: gqlKey.keyRingId, keyData: keyData)
        return entity
    }
}
