//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
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
        case .id(let idFilter):
            let idFilter = stringFilterTransformer.transform(idFilter)
            /// This is not a typo - `id` maps to `messageId`
            return .messageId(idFilter)
        case .messageId(let idFilter):
            let idFilter = stringFilterTransformer.transform(idFilter)
            return .messageId(idFilter)
        case .algorithm(let algorithmFilter):
            let algorithmFilter = stringFilterTransformer.transform(algorithmFilter)
            return .algorithm(algorithmFilter)
        case .clientRefId(let clientRefIdFilter):
            let clientRefIdFilter = stringFilterTransformer.transform(clientRefIdFilter)
            return .clientRefId(clientRefIdFilter)
        case .direction(let directionFilter):
            let directionFilter = directionFilterTransformer.transform(directionFilter)
            return .direction(directionFilter)
        case .state(let stateFilter):
            let stateFilter = stateFilterTransformer.transform(stateFilter)
            return .state(stateFilter)
        case .seen(let seenFilter):
            let seenFilter = boolFilterTransformer.transform(seenFilter)
            return .seen(seenFilter)
        case .repliedTo(let repliedToFilter):
            let repliedToFilter = boolFilterTransformer.transform(repliedToFilter)
            return .repliedTo(repliedToFilter)
        case .forwarded(let forwardedFilter):
            let forwardedFilter = boolFilterTransformer.transform(forwardedFilter)
            return .forwarded(forwardedFilter)
        case .keyId(let keyIdFilter):
            let keyIdFilter = stringFilterTransformer.transform(keyIdFilter)
            return .keyId(keyIdFilter)
        case .folderId(let folderIdFilter):
            let folderIdFilter = stringFilterTransformer.transform(folderIdFilter)
            return .folderId(folderIdFilter)
        case .not(let emailMessageFilter):
            let emailMessageFilter = transform(emailMessageFilter)
            return .not(emailMessageFilter)
        case .and(let emailMessageFilters):
            let emailMessageFilters = emailMessageFilters.map(transform(_:))
            return .and(emailMessageFilters)
        case .or(let emailMessageFilters):
            let emailMessageFilters = emailMessageFilters.map(transform(_:))
            return .or(emailMessageFilters)
        }
    }
}
