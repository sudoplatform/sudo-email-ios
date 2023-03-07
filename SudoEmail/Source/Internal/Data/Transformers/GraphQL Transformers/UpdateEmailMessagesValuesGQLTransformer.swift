//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform update email messages value to the GraphQL EmailMessageUpdateValuesInput.
struct UpdateEmailMessagesValuesGQLTransformer {

    /// Transform an `UpdateEmailMessages` values object into a GraphQL `EmailMessageUpdateValuesInput`
    func transform(_ values: UpdateEmailMessagesValues) -> GraphQL.EmailMessageUpdateValuesInput {
        var transformed = GraphQL.EmailMessageUpdateValuesInput()
        if values.folderId != nil {
            transformed.folderId = values.folderId
        }
        if values.seen != nil {
            transformed.seen = values.seen
        }
        return transformed
    }
}
