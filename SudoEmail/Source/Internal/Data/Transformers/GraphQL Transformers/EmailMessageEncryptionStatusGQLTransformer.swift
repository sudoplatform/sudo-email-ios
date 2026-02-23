//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SudoEmailCommon

/// Utility class to transform encryption status entity data to the GraphQL data.
struct EmailMessageEncryptionStatusGQLTransformer {

    /// Transform an `EncryptionStatus` into a GraphQL `EmailMessageEncryptionStatus`.
    func transform(_ entity: EncryptionStatus) -> GraphQL.EmailMessageEncryptionStatus {
        switch entity {
        case .ENCRYPTED:
            return .encrypted
        case .UNENCRYPTED:
            return .unencrypted
        }
    }
}
