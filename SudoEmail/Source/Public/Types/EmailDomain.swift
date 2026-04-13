//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of an email domain object associated with an email address in Platform SDK.
///
/// The `EmailDomain` struct represents an email domain that may be associated with an email address.
/// It contains the domain name, a flag indicating whether it is a mask domain, and metadata about the domain.
public struct EmailDomain: Hashable {

    // MARK: - Properties

    /// The email domain name.
    public let domain: String

    /// Indicates whether the email domain is a mask domain.
    public let isMaskDomain: Bool

    /// Metadata associated with the email domain.
    public let metadata: [String: String]

    public init(domain: String, isMaskDomain: Bool, metadata: [String: String]) {
        self.domain = domain
        self.isMaskDomain = isMaskDomain
        self.metadata = metadata
    }
}
