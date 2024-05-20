//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

struct UpdateEmailMessagesStatusApiTransformer {
    func transform (_ graphQL: GraphQL.UpdateEmailMessagesStatus) throws -> BatchOperationResultStatus {
        switch graphQL {
        case .failed:
            return .failure
        case .partial:
            return .partial
        case .success:
            return .success
        case let .unknown(status):
            throw SudoEmailError.internalError("Unsupported email message update status: \(status)")
        }
    }
}
