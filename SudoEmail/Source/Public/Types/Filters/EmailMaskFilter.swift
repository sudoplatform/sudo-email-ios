//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public enum EmailMaskStatusFilter: Equatable {
    /// Return only results that match the given status.
    case equal(EmailMask.EmailMaskStatus)
    /// Return only results that match one of the given statuses.
    case oneOf([EmailMask.EmailMaskStatus])
    /// Return only results that do not match the given status.
    case notEqual(EmailMask.EmailMaskStatus)
    /// Return only results that do not match any of the given statuses.
    case notOneOf([EmailMask.EmailMaskStatus])
}

public enum EmailMaskAddressTypeFilter: Equatable {
    /// Return only results that match the given address type.
    case equal(EmailMask.RealAddressType)
    /// Return only results that match one of the given address types.
    case oneOf([EmailMask.RealAddressType])
    /// Return only results that do not match the given address type.
    case notEqual(EmailMask.RealAddressType)
    /// Return only results that do not match any of the given address types.
    case notOneOf([EmailMask.RealAddressType])
}

public struct EmailMaskFilter: Equatable {

    /// Filter by `status` property
    public var status: EmailMaskStatusFilter?

    // filter by realAddressType property
    public var realAddressType: EmailMaskAddressTypeFilter?

    public init(
        status: EmailMaskStatusFilter? = nil,
        realAddressType: EmailMaskAddressTypeFilter? = nil
    ) {
        self.status = status
        self.realAddressType = realAddressType
    }
}
