//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
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
        case .id(let id):
            let id = stringFilterTransformer.transformToIdFilterInput(id)
            return GraphQL.EmailMessageFilterInput(id: id)
        case .messageId(let messageId):
            let messageId = stringFilterTransformer.transformToIdFilterInput(messageId)
            return GraphQL.EmailMessageFilterInput(messageId: messageId)
        case .algorithm(let algorithm):
            let algorithm = stringFilterTransformer.transformToStringFilterInput(algorithm)
            return GraphQL.EmailMessageFilterInput(algorithm: algorithm)
        case .keyId(let keyId):
            let keyId = stringFilterTransformer.transformToIdFilterInput(keyId)
            return GraphQL.EmailMessageFilterInput(keyId: keyId)
        case .clientRefId(let clientRefId):
            let clientRefId = stringFilterTransformer.transformToIdFilterInput(clientRefId)
            return GraphQL.EmailMessageFilterInput(clientRefId: clientRefId)
        case .folderId(let folderId):
            let folderId = stringFilterTransformer.transformToIdFilterInput(folderId)
            return GraphQL.EmailMessageFilterInput(folderId: folderId)
        case .direction(let direction):
            let direction = directionFilterTransformer.transform(direction)
            return GraphQL.EmailMessageFilterInput(direction: direction)
        case .state(let state):
            let state = stateFilterTransformer.transform(state)
            return GraphQL.EmailMessageFilterInput(state: state)
        case .seen(let seen):
            let seen = boolFilterTransformer.transform(seen)
            return GraphQL.EmailMessageFilterInput(seen: seen)
        case .repliedTo(let repliedTo):
            let repliedTo = boolFilterTransformer.transform(repliedTo)
            return GraphQL.EmailMessageFilterInput(repliedTo: repliedTo)
        case .forwarded(let forwarded):
            let forwarded = boolFilterTransformer.transform(forwarded)
            return GraphQL.EmailMessageFilterInput(forwarded: forwarded)
        case .not(let emailMessageFilter):
            let emailMessageFilter = transform(emailMessageFilter)
            return GraphQL.EmailMessageFilterInput(not: emailMessageFilter)
        case .and(let emailMessageFilters):
            let emailMessageFilters = emailMessageFilters.map(transform(_:))
            return GraphQL.EmailMessageFilterInput(and: emailMessageFilters)
        case .or(let emailMessageFilters):
            let emailMessageFilters = emailMessageFilters.map(transform(_:))
            return GraphQL.EmailMessageFilterInput(or: emailMessageFilters)
        }
    }
}
