//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core representation of secure data items that can be encoded and decoded to and from JSON.
struct SecureDataEntity: Codable {

    /// The secure encrypted data.
    let encryptedData: Data

    /// The initialization vector.
    let initVectorData: Data

    // MARK: - Lifecycle

    /// Initialize an instance of `SecureData`.
    /// - Parameters:
    ///   - encryptedData: The secure encrypted data.
    ///   - initVectorData: The initialization vector.
    init(encryptedData: Data, initVectorData: Data) {
        self.encryptedData = encryptedData
        self.initVectorData = initVectorData
    }

    // MARK: - Conformance: Codable

    private enum CodingKeys: String, CodingKey {
        case encryptedData, initVectorData
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(encryptedData.base64EncodedString(), forKey: .encryptedData)
        try container.encode(initVectorData.base64EncodedString(), forKey: .initVectorData)
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let decodedEncryptedDataBase64 = try values.decode(String.self, forKey: .encryptedData)
        let decodedInitVectorDataBase64 = try values.decode(String.self, forKey: .initVectorData)

        guard let decodedEncryptedData = Data(base64Encoded: decodedEncryptedDataBase64),
              let decodedInitVectorData = Data(base64Encoded: decodedInitVectorDataBase64) else {
            throw SudoEmailError.internalError("Failed to decode SecureData from JSON data")
        }
        encryptedData = decodedEncryptedData
        initVectorData = decodedInitVectorData
    }

    // MARK: - Methods

    /// Encode the current `SecureDataEntity` instance into JSON data.
    public func toJson() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    /// Decode a `SecureDataEntity` entity from the JSON data.
    static func fromJson(_ jsonData: Data? = nil) throws -> SecureDataEntity {
        if let jsonData = jsonData {
            return try JSONDecoder().decode(SecureDataEntity.self, from: jsonData)
        } else {
            throw EmailCryptoServiceError.decodingError("Failed to decode JSON string")
        }
    }

    /// Decode a `SecureDataEntity` instance from the base64-encoded JSON string.
    static func fromJson(_ jsonString: String) throws -> SecureDataEntity {
        let jsonData = Data(base64Encoded: jsonString)
        return try fromJson(jsonData)
    }

}
