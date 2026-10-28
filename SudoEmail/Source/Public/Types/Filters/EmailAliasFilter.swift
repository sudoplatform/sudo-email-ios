//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public enum EmailAliasStatusFilter: Equatable {
    /// Return only results that match the given status.
    case equal(EmailAlias.EmailAliasStatus)
    /// Return only results that match one of the given statuses.
    case oneOf([EmailAlias.EmailAliasStatus])
    /// Return only results that do not match the given status.
    case notEqual(EmailAlias.EmailAliasStatus)
    /// Return only results that do not match any of the given statuses.
    case notOneOf([EmailAlias.EmailAliasStatus])
}

public enum EmailAliasAddressTypeFilter: Equatable {
    /// Return only results that match the given address type.
    case equal(EmailAlias.RealAddressType)
    /// Return only results that match one of the given address types.
    case oneOf([EmailAlias.RealAddressType])
    /// Return only results that do not match the given address type.
    case notEqual(EmailAlias.RealAddressType)
    /// Return only results that do not match any of the given address types.
    case notOneOf([EmailAlias.RealAddressType])
}

public struct EmailAliasFilter: Equatable {

    /// Filter by `status` property
    public var status: EmailAliasStatusFilter?

    /// filter by realAddressType property
    public var realAddressType: EmailAliasAddressTypeFilter?

    public init(
        status: EmailAliasStatusFilter? = nil,
        realAddressType: EmailAliasAddressTypeFilter? = nil
    ) {
        self.status = status
        self.realAddressType = realAddressType
    }
}
