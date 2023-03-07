//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform email message direction entity data to the GraphQL data.
struct EmailMessageDirectionGQLTransformer {

    /// Transform a `DirectionEntity` filter rule into a GraphQL `EmailMessageDirection` filter rule.
    func transform(_ entity: DirectionEntity) -> GraphQL.EmailMessageDirection {
        switch entity {
        case .inbound:
            return .inbound
        case .outbound:
            return .outbound
        }
    }

}
