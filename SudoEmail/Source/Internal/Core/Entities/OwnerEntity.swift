//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a owner business rule. Depicts the identifier and issuer of an owner of a resource.
struct OwnerEntity: Equatable {

    /// Unique Identifier of the owner.
    var id: String

    /// Issuer of the owner.
    var issuer: String
}
