//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform entities from the Core level to output results of the SDK.
struct OwnerAPITransformer {

    /// Transform a `OwnerEntity` to an `Owner`.
    /// - Parameter entity: Entity to be transformed.
    /// - Returns: Output result.
    func transform(_ entity: OwnerEntity) -> Owner {
        let id = entity.id
        let issuer = entity.issuer
        return Owner(id: id, issuer: issuer)
    }
}
