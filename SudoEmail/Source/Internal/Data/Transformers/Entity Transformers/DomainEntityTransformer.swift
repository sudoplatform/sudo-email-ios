//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

struct DomainEntityTransformer {

    func transform(_ domain: String) -> DomainEntity {
        return DomainEntity(name: domain)
    }
}
