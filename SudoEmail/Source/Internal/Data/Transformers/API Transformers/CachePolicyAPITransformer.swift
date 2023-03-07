//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSAppSync
import Foundation

/// Utility to transform output results of the SDK to core level entity.
struct CachePolicyAPITransformer {

    /// Transform `CachePolicy` to `AWSAppSync.CachePolicy`
    func transform(_ policy: CachePolicy) -> AWSAppSync.CachePolicy {
        switch policy {
        case .cacheOnly:
            return AWSAppSync.CachePolicy.returnCacheDataDontFetch
        case .remoteOnly:
            return AWSAppSync.CachePolicy.fetchIgnoringCacheData
        }
    }
}
