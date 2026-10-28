//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core entity representation of a domain business rule. Depicts the rules for a filter of the `status` property of a `ScheduledDraftMessageEntity`.
enum EmailAliasStatusFilterEntity: Equatable {
    /// Return only results that match the given status.
    case equal(EmailAliasStatusEntity)
    /// Return only results that match one of the given status.
    case oneOf([EmailAliasStatusEntity])
    /// Return only results that do not match the given status.
    case notEqual(EmailAliasStatusEntity)
    /// Return only results that do not match any of the given status.
    case notOneOf([EmailAliasStatusEntity])
}

/// Core entity representation of a domain business rule. Depicts the rules for a filter of the `realAddressType` property of an `EmailAlias`.
enum EmailAliasRealAddressTypeFilterEntity: Equatable {
    /// Return only results that match the given address type.
    case equal(EmailAliasRealAddressTypeEntity)
    /// Return only results that match one of the given address type.
    case oneOf([EmailAliasRealAddressTypeEntity])
    /// Return only results that do not match the given address type.
    case notEqual(EmailAliasRealAddressTypeEntity)
    /// Return only results that do not match any of the given address type.
    case notOneOf([EmailAliasRealAddressTypeEntity])
}

/// Core entity representation of a domain business rule. Depicts the filter traits for an email alias.
/// The GraphQLFilterable protocol allows us to send no entries instead of explicit nulls for any filters which are not set
struct EmailAliasFilterEntity: Equatable, GraphQLFilterable {
    /// Filter rule for a status
    var status: EmailAliasStatusFilterEntity?
    /// Filter rule for an address type property
    var realAddressType: EmailAliasRealAddressTypeFilterEntity?

    /// Initialize an EmailAliasFilterEntity with optional filter criteria
    init(status: EmailAliasStatusFilterEntity? = Optional.none, realAddressType: EmailAliasRealAddressTypeFilterEntity? = Optional.none) {
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
        let transformer = EmailAliasFilterInputGQLTransformer()
        return transformer.transform(self)
    }
}
