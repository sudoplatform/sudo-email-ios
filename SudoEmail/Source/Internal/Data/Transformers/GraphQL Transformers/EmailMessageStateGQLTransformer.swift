//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform email message state entity data to the GraphQL data.
struct EmailMessageStateGQLTransformer {

    /// Transform a `StateEntity` into a GraphQL `EmailMessageState`.
    func transform(_ entity: StateEntity) -> GraphQL.EmailMessageState {
        switch entity {
        case .queued:
            return .queued
        case .sent:
            return .sent
        case .delivered:
            return .delivered
        case .undelivered:
            return .undelivered
        case .failed:
            return .failed
        case .received:
            return .received
        }
    }

}
