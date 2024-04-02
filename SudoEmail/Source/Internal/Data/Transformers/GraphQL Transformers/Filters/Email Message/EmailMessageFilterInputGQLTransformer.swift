//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform email message entity filter data to the GraphQL input filter data.
struct EmailMessageFilterInputGQLTransformer {

    // MARK: - Properties

    /// Utility class to transform `EmailMessageDirectionFilterEntity` to `EmailMessageDirectionFilterInput`.
    let directionFilterTransformer = EmailMessageDirectionFilterInputGQLTransformer()

    /// Utility class to transform `EmailMessageStateFilterEntity` to `EmailMessageStateFilterInput`.
    let stateFilterTransformer = EmailMessageStateFilterInputGQLTransformer()

    /// Utility class to transform `BoolFilterEntity` to `BooleanFilterInput`.
    let boolFilterTransformer = BooleanFilterInputGQLTransformer()

    /// Utility class to transform `StringFilterEntity` to `StringFilterInput`.
    let stringFilterTransformer = StringFilterInputGQLTransformer()

    // MARK: - Methods

    /// Transform a `EmailMessageFilterEntity` filter rule into a GraphQL `EmailMessageFilterInput` filter rule.
    func transform(_ entity: EmailMessageFilterEntity) -> GraphQL.EmailMessageFilterInput {
        switch entity {
        case let .id(id):
            let id = stringFilterTransformer.transformToIdFilterInput(id)
            return GraphQL.EmailMessageFilterInput(id: id)
        case let .messageId(messageId):
            let messageId = stringFilterTransformer.transformToIdFilterInput(messageId)
            return GraphQL.EmailMessageFilterInput(messageId: messageId)
        case let .algorithm(algorithm):
            let algorithm = stringFilterTransformer.transformToStringFilterInput(algorithm)
            return GraphQL.EmailMessageFilterInput(algorithm: algorithm)
        case let .keyId(keyId):
            let keyId = stringFilterTransformer.transformToIdFilterInput(keyId)
            return GraphQL.EmailMessageFilterInput(keyId: keyId)
        case let .clientRefId(clientRefId):
            let clientRefId = stringFilterTransformer.transformToIdFilterInput(clientRefId)
            return GraphQL.EmailMessageFilterInput(clientRefId: clientRefId)
        case let .folderId(folderId):
            let folderId = stringFilterTransformer.transformToIdFilterInput(folderId)
            return GraphQL.EmailMessageFilterInput(folderId: folderId)
        case let .direction(direction):
            let direction = directionFilterTransformer.transform(direction)
            return GraphQL.EmailMessageFilterInput(direction: direction)
        case let .state(state):
            let state = stateFilterTransformer.transform(state)
            return GraphQL.EmailMessageFilterInput(state: state)
        case let .seen(seen):
            let seen = boolFilterTransformer.transform(seen)
            return GraphQL.EmailMessageFilterInput(seen: seen)
        case let .not(emailMessageFilter):
            let emailMessageFilter = transform(emailMessageFilter)
            return GraphQL.EmailMessageFilterInput(not: emailMessageFilter)
        case let .and(emailMessageFilters):
            let emailMessageFilters = emailMessageFilters.map(transform(_:))
            return GraphQL.EmailMessageFilterInput(and: emailMessageFilters)
        case let .or(emailMessageFilters):
            let emailMessageFilters = emailMessageFilters.map(transform(_:))
            return GraphQL.EmailMessageFilterInput(or: emailMessageFilters)
        }
    }

}
