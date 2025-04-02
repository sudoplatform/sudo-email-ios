//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
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

    /// Create a custom email folder
    /// - Parameters:
    ///     - input: Parameters used to create a custom email folder
    /// - Returns: The newly created folder entity
    func createCustomEmailFolder(withInput input: CreateCustomEmailFolderInput) async throws -> EmailFolderEntity

    /// Delete a custom email folder
    /// - Parameters:
    ///     - input: Parameters used to delete a custom email folder
    /// - Returns: The deleted folder, or nil if not found
    func deleteCustomEmailFolder(withInput input: DeleteCustomEmailFolderInput) async throws -> EmailFolderEntity?

    /// Update a custom email folder
    ///
    /// - Parameters:
    ///     - input: Parameters used to update a custom email folder
    /// - Returns: The updated email folder
    func updateCustomEmailFolder(withInput input: UpdateCustomEmailFolderInput) async throws -> EmailFolderEntity

    /// Delete all messages for in an email folder.
    /// Deletion will be processed asynchronously since it may take a substantial amount of time.
    /// This method does not wait for deletion to complete. To check for completion, listen for subscriptions or check list endpoints.
    ///
    /// - Parameters:
    ///   - input: Input parameters needed to delete messages from a folder
    /// - Returns: The id of the folder
    func deleteMessagesForFolderId(withInput input: DeleteMessagesForFolderIdInput) async throws -> String
}
