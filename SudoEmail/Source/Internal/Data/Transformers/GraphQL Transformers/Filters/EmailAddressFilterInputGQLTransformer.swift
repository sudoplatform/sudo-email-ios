//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
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
        case .id(let id):
            let idFilterInput = stringTransformer.transformToIdFilterInput(id)
            return GraphQL.EmailAddressFilterInput(id: idFilterInput)
        case .identityId(let id):
            let idFilterInput = stringTransformer.transformToIdFilterInput(id)
            return GraphQL.EmailAddressFilterInput(identityId: idFilterInput)
        case .keyRingId(let id):
            let idFilterInput = stringTransformer.transformToIdFilterInput(id)
            return GraphQL.EmailAddressFilterInput(keyRingId: idFilterInput)
        case .emailAddress(let stringFilterEntity):
            let stringFilterInput = stringTransformer.transformToStringFilterInput(stringFilterEntity)
            return GraphQL.EmailAddressFilterInput(emailAddress: stringFilterInput)
        case .not(let emailFilterEntity):
            let emailFilterInput = transform(emailFilterEntity)
            return GraphQL.EmailAddressFilterInput(not: emailFilterInput)
        case .and(let emailFilterEntities):
            let emailFilterInputs = emailFilterEntities.map(transform(_:))
            return GraphQL.EmailAddressFilterInput(and: emailFilterInputs)
        case .or(let emailFilterEntities):
            let emailFilterInputs = emailFilterEntities.map(transform(_:))
            return GraphQL.EmailAddressFilterInput(or: emailFilterInputs)
        }
    }
}
