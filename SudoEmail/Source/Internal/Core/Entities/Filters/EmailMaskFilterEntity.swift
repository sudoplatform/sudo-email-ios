//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core entity representation of a domain business rule. Depicts the rules for a filter of the `status` property of a `ScheduledDraftMessageEntity`.
enum EmailMaskStatusFilterEntity: Equatable {
    /// Return only results that match the given status.
    case equal(EmailMaskStatusEntity)
    /// Return only results that match one of the given status.
    case oneOf([EmailMaskStatusEntity])
    /// Return only results that do not match the given status.
    case notEqual(EmailMaskStatusEntity)
    /// Return only results that do not match any of the given status.
    case notOneOf([EmailMaskStatusEntity])
}

/// Core entity representation of a domain business rule. Depicts the rules for a filter of the `realAddressType` property of an `EmailMask`.
enum EmailMaskRealAddressTypeFilterEntity: Equatable {
    /// Return only results that match the given address type.
    case equal(EmailMaskRealAddressTypeEntity)
    /// Return only results that match one of the given address type.
    case oneOf([EmailMaskRealAddressTypeEntity])
    /// Return only results that do not match the given address type.
    case notEqual(EmailMaskRealAddressTypeEntity)
    /// Return only results that do not match any of the given address type.
    case notOneOf([EmailMaskRealAddressTypeEntity])
}

/// Core entity representation of a domain business rule. Depicts the filter traits for an email mask.
/// The GraphQLFilterable protocol allows us to send no entries instead of explicit nulls for any filters which are not set
struct EmailMaskFilterEntity: Equatable, GraphQLFilterable {
    /// Filter rule for a status
    var status: EmailMaskStatusFilterEntity?
    /// Filter rule for an address type property
    var realAddressType: EmailMaskRealAddressTypeFilterEntity?

    /// Initialize an EmailMaskFilterEntity with optional filter criteria
    init(status: EmailMaskStatusFilterEntity? = Optional.none, realAddressType: EmailMaskRealAddressTypeFilterEntity? = Optional.none) {
        self.status = status
        self.realAddressType = realAddressType
    }

    // MARK: - GraphQLFilterable

    /// Convert to GraphQL filter input, returning nil if no filters are provided
    func toGraphQLFilter() -> GraphQL.EmailMaskFilterInput? {
        // Return nil if no filters are provided to avoid sending explicit nulls
        guard status != nil || realAddressType != nil else {
            return nil
        }

        // Use the existing transformer to create the GraphQL input
        let transformer = EmailMaskFilterInputGQLTransformer()
        return transformer.transform(self)
    }
}
