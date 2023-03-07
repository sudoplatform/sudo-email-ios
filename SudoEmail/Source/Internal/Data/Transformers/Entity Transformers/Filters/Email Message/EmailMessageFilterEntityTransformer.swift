//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform Input `EmailMessageStateFilters` to `EmailMessageStateFilterEntity`.
struct EmailMessageFilterEntityTransformer {

    // MARK: - Properties

    /// Utility to transform `EmailMessage.State` to `StateEntity`.
    let directionFilterTransformer = EmailMessageDirectionFilterEntityTransformer()

    /// Utility to transform `EmailMessage.State` to `StateEntity`.
    let stateFilterTransformer = EmailMessageStateFilterEntityTransformer()

    /// Utility to transform `EmailMessage.State` to `StateEntity`.
    let boolFilterTransformer = BoolFilterEntityTransformer()

    /// Utility to transform `EmailMessage.State` to `StateEntity`.
    let stringFilterTransformer = StringFilterEntityTransformer()

     // MARK: - Methods

    /// Transform a input `EmailMessageFilter` into a `EmailMessageFilterEntity`.
    func transform(_ filter: EmailMessageFilter) -> EmailMessageFilterEntity {
        switch filter {
        case let .id(idFilter):
            let idFilter = stringFilterTransformer.transform(idFilter)
            /// This is not a typo - `id` maps to `messageId`
            return .messageId(idFilter)
        case let .messageId(idFilter):
            let idFilter = stringFilterTransformer.transform(idFilter)
            return .messageId(idFilter)
        case let .algorithm(algorithmFilter):
            let algorithmFilter = stringFilterTransformer.transform(algorithmFilter)
            return .algorithm(algorithmFilter)
        case let .clientRefId(clientRefIdFilter):
            let clientRefIdFilter = stringFilterTransformer.transform(clientRefIdFilter)
            return .clientRefId(clientRefIdFilter)
        case let .direction(directionFilter):
            let directionFilter = directionFilterTransformer.transform(directionFilter)
            return .direction(directionFilter)
        case let .state(stateFilter):
            let stateFilter = stateFilterTransformer.transform(stateFilter)
            return .state(stateFilter)
        case let .seen(seenFilter):
            let seenFilter = boolFilterTransformer.transform(seenFilter)
            return .seen(seenFilter)
        case let .keyId(keyIdFilter):
            let keyIdFilter = stringFilterTransformer.transform(keyIdFilter)
            return .keyId(keyIdFilter)
        case let .folderId(folderIdFilter):
            let folderIdFilter = stringFilterTransformer.transform(folderIdFilter)
            return .folderId(folderIdFilter)
        case let .not(emailMessageFilter):
            let emailMessageFilter = transform(emailMessageFilter)
            return .not(emailMessageFilter)
        case let .and(emailMessageFilters):
            let emailMessageFilters = emailMessageFilters.map(transform(_:))
            return .and(emailMessageFilters)
        case let .or(emailMessageFilters):
            let emailMessageFilters = emailMessageFilters.map(transform(_:))
            return .or(emailMessageFilters)
        }
    }

}
