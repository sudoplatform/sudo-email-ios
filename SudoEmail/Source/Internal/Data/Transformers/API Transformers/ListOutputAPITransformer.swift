//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform list output entities from the Core level to output results of the SDK.
struct ListOutputAPITransformer {

    /// Utility to transform email account entities to email addresses.
    let emailAddressTransformer = EmailAddressAPITransformer()

    /// Utility to transform email folder entities to email folders.
    let emailFolderTransformer = EmailFolderAPITransformer()

    /// Utility to transform email message entites to email messages.
    let emailMessageTransformer = EmailMessageAPITransformer()

    /// Transform a email account entity list output to API list output of email addresses.
    func transformEmailAccounts(_ entities: ListOutputEntity<EmailAccountEntity>) -> ListOutput<EmailAddress> {
        let items = entities.items.map(emailAddressTransformer.transform(_:))
        let nextToken = entities.nextToken
        return ListOutput(items: items, nextToken: nextToken)
    }

    /// Transform a email folder entity list output to API list output of email folderss.
    func transformEmailFolders(_ entities: ListOutputEntity<EmailFolderEntity>) -> ListOutput<EmailFolder> {
        let items = entities.items.map(emailFolderTransformer.transform(_:))
        let nextToken = entities.nextToken
        return ListOutput(items: items, nextToken: nextToken)
    }

    func transformEmailMessages(_ entities: ListOutputEntity<EmailMessageEntity>) -> ListOutput<EmailMessage> {
        let items = entities.items.map(emailMessageTransformer.transform(_:))
        let nextToken = entities.nextToken
        return ListOutput(items: items, nextToken: nextToken)
    }
}
