//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform email account entity filter data to the GraphQL input filter data.
struct EmailAddressFilterInputGQLTransformer {

    /// Utility for transforming `StringFilterEntity` to `StringFilterInput`.
    let stringTransformer = StringFilterInputGQLTransformer()

    /// Transform a `EmailAccountFilterEntity` filter rule into a GraphQL `EmailAddressFilterInput` filter rule.
    func transform(_ entity: EmailAccountFilterEntity) -> EmailAddressFilterInput {
        switch entity {
        case let .id(id):
            let idFilterInput = stringTransformer.transformToIdFilterInput(id)
            return EmailAddressFilterInput(id: idFilterInput)
        case let .sudoId(id):
            let idFilterInput = stringTransformer.transformToIdFilterInput(id)
            return EmailAddressFilterInput(sudoId: idFilterInput)
        case let .identityId(id):
            let idFilterInput = stringTransformer.transformToIdFilterInput(id)
            return EmailAddressFilterInput(identityId: idFilterInput)
        case let .keyRingId(id):
            let idFilterInput = stringTransformer.transformToIdFilterInput(id)
            return EmailAddressFilterInput(keyRingId: idFilterInput)
        case let .emailAddress(stringFilterEntity):
            let stringFilterInput = stringTransformer.transformToStringFilterInput(stringFilterEntity)
            return EmailAddressFilterInput(emailAddress: stringFilterInput)
        case let .not(emailFilterEntity):
            let emailFilterInput = transform(emailFilterEntity)
            return EmailAddressFilterInput(not: emailFilterInput)
        case let .and(emailFilterEntities):
            let emailFilterInputs = emailFilterEntities.map(transform(_:))
            return EmailAddressFilterInput(and: emailFilterInputs)
        case let .or(emailFilterEntities):
            let emailFilterInputs = emailFilterEntities.map(transform(_:))
            return EmailAddressFilterInput(or: emailFilterInputs)
        }
    }

}
