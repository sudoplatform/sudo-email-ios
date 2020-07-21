//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct EmailAccountEntityTransformer {

    /// Utility for transforming addresses to `EmailAddressEntity`.
    let emailAddressTransformer = EmailAddressEntityTransformer()

    /// Utility for transforming owners to `OwnerTransformer`.
    let ownerTransformer = OwnerEntityTransformer()

    /// Transform the success result of `ProvisionEmailAddressMutation` from the service to a `EmailAccountEntity`.
    func transform(_ data: ProvisionEmailAddressMutation.Data) throws -> EmailAccountEntity {
        let graphQLEmail = data.provisionEmailAddress
        let owner = graphQLEmail.owner
        let owners = graphQLEmail.owners.map(ownerTransformer.transform(_:))
        let emailAddress = try emailAddressTransformer.transform(graphQLEmail.address)
        let created = Date(millisecondsSince1970: graphQLEmail.createdAtEpochMs)
        let updated = Date(millisecondsSince1970: graphQLEmail.updatedAtEpochMs)
        return EmailAccountEntity(
            emailAddress: emailAddress,
            owner: owner,
            owners: owners,
            created: created,
            updated: updated
        )
    }

    /// Transform the success result of `DeprovisionEmailAddressMutation` from the service to a `EmailAccountEntity`.
    func transform(_ data: DeprovisionEmailAddressMutation.Data) throws -> EmailAccountEntity {
        let graphQLEmail = data.deprovisionEmailAddress
        let owner = graphQLEmail.owner
        let owners = graphQLEmail.owners.map(ownerTransformer.transform(_:))
        let emailAddress = try emailAddressTransformer.transform(graphQLEmail.address)
        let created = Date(millisecondsSince1970: graphQLEmail.createdAtEpochMs)
        let updated = Date(millisecondsSince1970: graphQLEmail.updatedAtEpochMs)
        return EmailAccountEntity(
            emailAddress: emailAddress,
            owner: owner,
            owners: owners,
            created: created,
            updated: updated
        )
    }

    /// Transform the success result of `GetEmailAddressQuery` from the service to a `EmailAccountEntity`.
    func transform(_ graphQLEmail: GetEmailAddressQuery.Data.GetEmailAddress) throws -> EmailAccountEntity {
        let owner = graphQLEmail.owner
        let owners = graphQLEmail.owners.map(ownerTransformer.transform(_:))
        let emailAddress = try emailAddressTransformer.transform(graphQLEmail.address)
        let created = Date(millisecondsSince1970: graphQLEmail.createdAtEpochMs)
        let updated = Date(millisecondsSince1970: graphQLEmail.updatedAtEpochMs)
        return EmailAccountEntity(
            emailAddress: emailAddress,
            owner: owner,
            owners: owners,
            created: created,
            updated: updated
        )
    }

    /// Transform the success result of `ListEmailAddressesQuery` from the service to a `EmailAccountEntity`.
    func transform(_ graphQLEmail: ListEmailAddressesQuery.Data.ListEmailAddress.Item) throws -> EmailAccountEntity {
        let owner = graphQLEmail.owner
        let owners = graphQLEmail.owners.map(ownerTransformer.transform(_:))
        let emailAddress = try emailAddressTransformer.transform(graphQLEmail.address)
        let created = Date(millisecondsSince1970: graphQLEmail.createdAtEpochMs)
        let updated = Date(millisecondsSince1970: graphQLEmail.updatedAtEpochMs)
        return EmailAccountEntity(
            emailAddress: emailAddress,
            owner: owner,
            owners: owners,
            created: created,
            updated: updated
        )
    }

}
