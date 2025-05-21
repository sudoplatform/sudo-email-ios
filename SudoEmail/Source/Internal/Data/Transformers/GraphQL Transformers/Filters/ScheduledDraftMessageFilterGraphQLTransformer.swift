//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

struct ScheduledDraftMessageFilterGraphQLTransformer {

    // MARK: - Methods

    func transform(_ entity: ScheduledDraftMessageFilter?) throws -> GraphQL.ScheduledDraftMessageFilterInput? {
        if entity?.state != nil {
            var stateFilter = GraphQL.ScheduledDraftMessageStateFilterInput()
            let stateTransformer = ScheduledDraftMessageStateGraphQLTransformer()
            switch entity?.state {
            case .equal(let value):
                stateFilter.eq = try stateTransformer.transform(value)
            case .oneOf(let values):
                stateFilter.in = try values.map(stateTransformer.transform(_:))
            case .notEqual(let value):
                stateFilter.ne = try stateTransformer.transform(value)
            case .notOneOf(let values):
                stateFilter.notIn = try values.map(stateTransformer.transform(_:))
            case .none:
                return nil
            }
            return GraphQL.ScheduledDraftMessageFilterInput(state: stateFilter)
        } else {
            return nil
        }
    }
}
