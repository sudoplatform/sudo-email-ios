//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

struct UpdateEmailMessagesStatusApiTransformer {
    func transform(_ graphQL: GraphQL.UpdateEmailMessagesStatus) throws -> BatchOperationResultStatus {
        switch graphQL {
        case .failed:
            return .failure
        case .partial:
            return .partial
        case .success:
            return .success
        case .unknown(let status):
            throw SudoEmailError.internalError("Unsupported email message update status: \(status)")
        }
    }
}
