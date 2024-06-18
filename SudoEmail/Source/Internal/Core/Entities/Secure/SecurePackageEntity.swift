//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Representation of a package containing a set of keys and secure email data.
struct SecurePackageEntity {

    /// Set of email attachments representing the keys to decrypt the secure email body.
    public let keyAttachments: Set<EmailAttachment>
    /// List of email attachments representing the secure email body.
    public let bodyAttachment: EmailAttachment

    /// Get the values of `keyAttachments` and `bodyAttachment` as a list.
    ///
    /// - Returns: A list of `EmailAttachment` items.
    func toList() -> [EmailAttachment] {
        return Array(keyAttachments) + [bodyAttachment]
    }

}
