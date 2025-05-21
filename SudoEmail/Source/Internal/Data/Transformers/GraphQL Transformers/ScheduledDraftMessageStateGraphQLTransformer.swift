//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from  the Core/Entity level of the SDK to GraphQL
struct ScheduledDraftMessageStateGraphQLTransformer {

    // MARK: - Methods

    func transform(_ state: ScheduledDraftMessageState) throws -> GraphQL.ScheduledDraftMessageState {
        switch state {
        case .cancelled:
            return .cancelled
        case .failed:
            return .failed
        case .scheduled:
            return .scheduled
        case .sent:
            return .sent
        }
    }
}
