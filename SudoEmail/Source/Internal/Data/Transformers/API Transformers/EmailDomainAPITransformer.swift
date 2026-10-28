//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

struct EmailDomainAPITransformer {

    func transform(_ entity: EmailDomainEntity) -> EmailDomain {
        return EmailDomain(
            domain: entity.domain,
            isAliasDomain: entity.isAliasDomain,
            metadata: entity.metadata
        )
    }
}
