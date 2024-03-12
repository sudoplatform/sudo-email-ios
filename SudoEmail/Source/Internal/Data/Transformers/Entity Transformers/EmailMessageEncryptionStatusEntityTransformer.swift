//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility to transform data received from API and GraphQL to the Core/Entity level of the SDK
struct EmailMessageEncryptionStatusEntityTransformer {
    
    /// Transform the `EmailMessageEncryptionStatus` from the service to the entity
    func transform (_ graphQL: GraphQL.EmailMessageEncryptionStatus?) throws -> EncryptionStatus {
        switch graphQL {
        case .encrypted:
            return .ENCRYPTED
        case .unencrypted, nil:
            return .UNENCRYPTED
        case let .unknown(encryptionStatus):
            throw SudoEmailError.internalError("Unsupported email encryption status \(encryptionStatus)")
        }
    }
}
