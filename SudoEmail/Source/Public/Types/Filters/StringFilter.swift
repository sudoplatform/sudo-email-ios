//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Filter for a `String` type.
public enum StringFilter: Equatable {
    /// Filter by equality of `String`.
    case equals(String)
    /// Filter by non-equality of `String`.
    case notEquals(String)
    /// Filter by searching for match that begins with `String`.
    case beginsWith(String)
}
