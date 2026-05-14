//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform Input `MailboxIdsFilter` to `MailboxIdsFilterEntity`.
struct MailboxIdsFilterEntityTransformer {

    // MARK: - Properties

    /// Utility to transform `StringFilter` to `StringFilterEntity`.
    let stringFilterTransformer = StringFilterEntityTransformer()

    // MARK: - Methods

    /// Transform a input `MailboxIdsFilter` into a `MailboxIdsFilterEntity`.
    func transform(_ filter: MailboxIdsFilter) -> MailboxIdsFilterEntity {
        let type = transformType(filter.type)
        let id = stringFilterTransformer.transform(filter.id)
        return MailboxIdsFilterEntity(type: type, id: id)
    }

    /// Transform a `MailboxType` into a `MailboxTypeEntity`.
    func transformType(_ type: EmailMessageMailboxType) -> MailboxTypeEntity {
        switch type {
        case .address:
            return .address
        case .mask:
            return .mask
        }
    }
}
