//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoKeyManager

/// A sealed symmetric key which is sealed by encrypting it with a public key.
/// It can be unsealed by decrypting it with the corresponding private key.
struct SealedKeyEntity: Encodable, Equatable, Hashable {

    // MARK: - Properties

    /// Identifier associated with the public key.
    let publicKeyId: String

    /// The symmetric key data.
    let symmetricKey: Data

    /// The algorithm used to encrypt the symmetric key.
    let algorithm: PublicKeyEncryptionAlgorithm

    /// The encrypted key data.
    var encryptedKey: Data = Data()

    // MARK: - Lifecycle

    /// Initialize an instance of `SealedKeyEntity`.
    /// - Parameters:
    ///   - publicKeyId: Identifier associated with the public key.
    ///   - symmetricKey: The symmetric key data.
    ///   - algorithm: The algorithm used to encrypt the symmetric key.
    init(publicKeyId: String, symmetricKey: Data, algorithm: PublicKeyEncryptionAlgorithm = PublicKeyEncryptionAlgorithm.rsaEncryptionOAEPSHA1) {
        self.publicKeyId = publicKeyId
        self.symmetricKey = symmetricKey
        self.algorithm = algorithm
    }

    // MARK: - Conformance: Encodable

    private enum CodingKeys: String, CodingKey {
        case publicKeyId, algorithm, encryptedKey
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(publicKeyId, forKey: .publicKeyId)
        try container.encode(encryptedKey.base64EncodedString(), forKey: .encryptedKey)
        try container.encode(String(describing: algorithm), forKey: .algorithm)
    }

    // MARK: - Conformance: Equatable

    static func == (lhs: SealedKeyEntity, rhs: SealedKeyEntity) -> Bool {
        return lhs.publicKeyId == rhs.publicKeyId &&
            lhs.symmetricKey == rhs.symmetricKey &&
            lhs.algorithm == rhs.algorithm &&
            lhs.encryptedKey == rhs.encryptedKey
    }

    // MARK: - Conformance: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(publicKeyId)
        hasher.combine(symmetricKey)
        hasher.combine(algorithm)
        hasher.combine(encryptedKey)
    }

    // MARK: - Methods

    /// Encode the current `SealedKeyEntity` instance into a JSON string.
    public func toJson() throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        let jsonData = try encoder.encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
}

struct SealedKeyComponentsEntity: Decodable {

    // MARK: - Properties

    let publicKeyId: String
    let algorithm: PublicKeyEncryptionAlgorithm
    let encryptedKey: Data

    // MARK: - Conformance: Decodable

    private enum CodingKeys: String, CodingKey {
        case publicKeyId, algorithm, encryptedKey
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let decodedPublicKeyId = try values.decode(String.self, forKey: .publicKeyId)
        let decodedAlgorithm = try values.decode(String.self, forKey: .algorithm)
        let decodedEncryptedKey = try values.decode(String.self, forKey: .encryptedKey)

        publicKeyId = decodedPublicKeyId
        algorithm = PublicKeyEncryptionAlgorithm(decodedAlgorithm) ?? PublicKeyEncryptionAlgorithm.rsaEncryptionOAEPSHA1
        guard let encryptedKeyData = Data(base64Encoded: decodedEncryptedKey) else {
            throw EmailCryptoServiceError.decodingError("Failed to decode SealedKeyComponentsEntity from JSON data")
        }
        encryptedKey = encryptedKeyData
    }

    // MARK: - Methods

    /// Decode a `SealedKeyComponentsEntity` instance from the JSON string.
    static func fromJson(_ jsonString: String) throws -> SealedKeyComponentsEntity {
        do {
            let jsonData = Data(jsonString.utf8)
            return try JSONDecoder().decode(SealedKeyComponentsEntity.self, from: jsonData)
        } catch {
            throw EmailCryptoServiceError.decodingError("Failed to decode JSON string: \(error.localizedDescription)")
        }
    }
}
