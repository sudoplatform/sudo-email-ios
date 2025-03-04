//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a domain business rule. Depicts the output rule of a list call.
struct ListOutputEntity<T> {

    /// Items returned by a List query output.
    let items: [T]

    /// Next token to call next page of paginated results.
    let nextToken: String?
}
