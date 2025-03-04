//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoApiClient

/// Cache policy that determines how data is accessed when performing a query method from
/// the Email Service.
///
public enum CachePolicy: Equatable {
    /// Use the device cached data.
    case cacheOnly
    /// Query and use the data on the server.
    case remoteOnly
}
