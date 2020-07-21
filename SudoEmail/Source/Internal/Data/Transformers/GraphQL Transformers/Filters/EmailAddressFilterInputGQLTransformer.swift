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
        case let .address(stringFilterEntity):
            let stringFilterInput = stringTransformer.transform(stringFilterEntity)
            return EmailAddressFilterInput(address: stringFilterInput)
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
