//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a domain business rule. Depicts the name of a domain.
struct EmailDomainEntity {

    /// Name of the domain.
    var domain: String

    /// Whether the domains is for email masks or not
    var isMaskDomain: Bool

    /// Metadata about the domain as JSON
    var metadata: [String: String]
}
