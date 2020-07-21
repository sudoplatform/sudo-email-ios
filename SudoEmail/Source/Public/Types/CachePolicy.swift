//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoOperations

/// Cache policy that determines how data is accessed when performing a query method from
/// the Email Service.
///
/// This is a veneer around `SudoOperations.CachePolicy`.
public enum CachePolicy: Equatable {
    /// Use the device cached data.
    case useCache
    /// Query and use the data on the server.
    case useOnline

    // MARK: - Internal

    /// Converts `Self` to the matching SudoOperations `CachePolicy`.
    func toSudoOperationsCachePolicy() -> SudoOperations.CachePolicy {
        switch self {
        case .useCache:
            return SudoOperations.CachePolicy.useCache
        case .useOnline:
            return SudoOperations.CachePolicy.useOnline
        }
    }
}
