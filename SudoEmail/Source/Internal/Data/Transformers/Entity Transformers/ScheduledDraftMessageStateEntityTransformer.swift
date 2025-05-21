//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK
struct ScheduledDraftMessageStateEntityTransformer {

    // MARK: - Methods

    func transform(_ state: GraphQL.ScheduledDraftMessageState) throws -> ScheduledDraftMessageStateEntity {
        switch state {
        case .scheduled:
            return .scheduled
        case .cancelled:
            return .cancelled
        case .failed:
            return .failed
        case .sent:
            return .sent
        case .unknown:
            throw SudoEmailError.internalError("Unsupported state: \(state)")
        }
    }
}
