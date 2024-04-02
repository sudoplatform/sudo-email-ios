//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core representation of an email folder repository used in business logic.
protocol EmailFolderRepository: AnyObject {

    /// Get the list of email folders for the specified email address.
    /// - Parameters:
    ///   - input: Parameters used to get a list of email folders for an email address.
    ///   - Returns a list of results with a next token if there are more results to list.
    func listEmailFoldersForEmailAddressId(
        withInput input: ListEmailFoldersForEmailAddressIdInput
    ) async throws -> ListOutputEntity<EmailFolderEntity>

}
