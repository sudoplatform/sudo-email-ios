//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform mailbox IDs entity filter data to the GraphQL input filter data.
struct MailboxIdsFilterInputGQLTransformer {

    // MARK: - Properties

    /// Utility class to transform `StringFilterEntity` to `StringFilterInput`.
    let stringFilterTransformer = StringFilterInputGQLTransformer()

    // MARK: - Methods

    /// Transform a `MailboxIdsFilterEntity` filter rule into a GraphQL `MailboxIdsFilterInput` filter rule.
    func transform(_ entity: MailboxIdsFilterEntity) -> GraphQL.MailboxIdsFilterInput {
        let id = stringFilterTransformer.transformToStringFilterInput(entity.id)
        let type = transformType(entity.type)
        return GraphQL.MailboxIdsFilterInput(id: id, type: type)
    }

    /// Transform a `MailboxTypeEntity` into a GraphQL `MailboxType`.
    func transformType(_ entity: MailboxTypeEntity) -> GraphQL.MailboxType {
        switch entity {
        case .address:
            return .address
        case .mask:
            return .mask
        }
    }
}
