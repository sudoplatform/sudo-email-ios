//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform email account entity filter data to the GraphQL input filter data.
struct EmailAddressFilterInputGQLTransformer {

    /// Utility for transforming `StringFilterEntity` to `StringFilterInput`.
    let stringTransformer = StringFilterInputGQLTransformer()

    /// Transform a `EmailAccountFilterEntity` filter rule into a GraphQL `EmailAddressFilterInput` filter rule.
    func transform(_ entity: EmailAccountFilterEntity) -> GraphQL.EmailAddressFilterInput {
        switch entity {
        case let .id(id):
            let idFilterInput = stringTransformer.transformToIdFilterInput(id)
            return GraphQL.EmailAddressFilterInput(id: idFilterInput)
        case let .identityId(id):
            let idFilterInput = stringTransformer.transformToIdFilterInput(id)
            return GraphQL.EmailAddressFilterInput(identityId: idFilterInput)
        case let .keyRingId(id):
            let idFilterInput = stringTransformer.transformToIdFilterInput(id)
            return GraphQL.EmailAddressFilterInput(keyRingId: idFilterInput)
        case let .emailAddress(stringFilterEntity):
            let stringFilterInput = stringTransformer.transformToStringFilterInput(stringFilterEntity)
            return GraphQL.EmailAddressFilterInput(emailAddress: stringFilterInput)
        case let .not(emailFilterEntity):
            let emailFilterInput = transform(emailFilterEntity)
            return GraphQL.EmailAddressFilterInput(not: emailFilterInput)
        case let .and(emailFilterEntities):
            let emailFilterInputs = emailFilterEntities.map(transform(_:))
            return GraphQL.EmailAddressFilterInput(and: emailFilterInputs)
        case let .or(emailFilterEntities):
            let emailFilterInputs = emailFilterEntities.map(transform(_:))
            return GraphQL.EmailAddressFilterInput(or: emailFilterInputs)
        }
    }

}
