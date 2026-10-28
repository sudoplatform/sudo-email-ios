//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Input object for provisioning an email alias using `SudoEmailClient`
public struct ProvisionEmailAliasInput: Equatable {

    /// The email alias address to provision, in the form `${localPart}@${domain}`.
    public let aliasAddress: String

    /// The real email address to which the alias will forward to, in the form `${localPart}@${domain}`.
    public let realAddress: String

    /// The signed ownership proof of the Sudo to be associated with the provisioned email alias.
    ///  The ownership proof must contain an audience of "sudoplatform".
    public let ownershipProofToken: String

    /// Optional name/value pair metadata to associated with the email alias
    public let metadata: [String: String]?

    /// Optional expiration date for the email alias. If not provided, the alias does not expire.
    public let expiresAt: Date?

    /// Optional identifier of the Public Key to use to provision the email alias.
    public let keyId: String?

    public init
        (
            aliasAddress: String,
            realAddress: String,
            ownershipProofToken: String,
            metadata: [String: String]? = nil,
            expiresAt: Date? = nil,
            keyId: String? = nil
        ) {
        self.aliasAddress = aliasAddress
        self.realAddress = realAddress
        self.ownershipProofToken = ownershipProofToken
        self.metadata = metadata
        self.expiresAt = expiresAt
        self.keyId = keyId
    }
}
