//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct OwnerEntityTransformer {

    /// Transform the success result of `ProvisionEmailAddressMutation` from the service to a `OwnerEntity`.
    func transform(_ data: ProvisionEmailAddressMutation.Data.ProvisionEmailAddress.Owner) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `DeprovisionEmailAddressMutation` from the service to a `OwnerEntity`.
    func transform(_ data: DeprovisionEmailAddressMutation.Data.DeprovisionEmailAddress.Owner) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `GetEmailAddressQuery` from the service to a `OwnerEntity`.
    func transform(_ data: GetEmailAddressQuery.Data.GetEmailAddress.Owner) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `ListEmailAddressesQuery` from the service to a `OwnerEntity`.
    func transform(_ data: ListEmailAddressesQuery.Data.ListEmailAddress.Item.Owner) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }
}
