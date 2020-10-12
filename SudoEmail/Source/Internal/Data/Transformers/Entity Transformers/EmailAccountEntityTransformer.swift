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
        let id = graphQLEmail.id
        let userId = graphQLEmail.userId
        let sudoId = graphQLEmail.sudoId
        let identityId = graphQLEmail.identityId
        let keyRingId = graphQLEmail.keyRingId
        let emailAddress = try emailAddressTransformer.transform(graphQLEmail.emailAddress)
        let owners = graphQLEmail.owners.map(ownerTransformer.transform(_:))
        let created = Date(millisecondsSince1970: graphQLEmail.createdAtEpochMs)
        let updated = Date(millisecondsSince1970: graphQLEmail.updatedAtEpochMs)
        return EmailAccountEntity(
            id: id,
            userId: userId,
            sudoId: sudoId,
            identityId: identityId,
            keyRingId: keyRingId,
            emailAddress: emailAddress,
            owners: owners,
            created: created,
            updated: updated
        )
    }

    /// Transform the success result of `DeprovisionEmailAddressMutation` from the service to a `EmailAccountEntity`.
    func transform(_ data: DeprovisionEmailAddressMutation.Data) throws -> EmailAccountEntity {
        let graphQLEmail = data.deprovisionEmailAddress
        let id = graphQLEmail.id
        let userId = graphQLEmail.userId
        let sudoId = graphQLEmail.sudoId
        let identityId = graphQLEmail.identityId
        let keyRingId = graphQLEmail.keyRingId
        let emailAddress = try emailAddressTransformer.transform(graphQLEmail.emailAddress)
        let owners = graphQLEmail.owners.map(ownerTransformer.transform(_:))
        let created = Date(millisecondsSince1970: graphQLEmail.createdAtEpochMs)
        let updated = Date(millisecondsSince1970: graphQLEmail.updatedAtEpochMs)
        return EmailAccountEntity(
            id: id,
            userId: userId,
            sudoId: sudoId,
            identityId: identityId,
            keyRingId: keyRingId,
            emailAddress: emailAddress,
            owners: owners,
            created: created,
            updated: updated
        )
    }

    /// Transform the success result of `GetEmailAddressQuery` from the service to a `EmailAccountEntity`.
    func transform(_ graphQLEmail: GetEmailAddressQuery.Data.GetEmailAddress) throws -> EmailAccountEntity {
        let id = graphQLEmail.id
        let userId = graphQLEmail.userId
        let sudoId = graphQLEmail.sudoId
        let identityId = graphQLEmail.identityId
        let keyRingId = graphQLEmail.keyRingId
        let emailAddress = try emailAddressTransformer.transform(graphQLEmail.emailAddress)
        let owners = graphQLEmail.owners.map(ownerTransformer.transform(_:))
        let created = Date(millisecondsSince1970: graphQLEmail.createdAtEpochMs)
        let updated = Date(millisecondsSince1970: graphQLEmail.updatedAtEpochMs)
        return EmailAccountEntity(
            id: id,
            userId: userId,
            sudoId: sudoId,
            identityId: identityId,
            keyRingId: keyRingId,
            emailAddress: emailAddress,
            owners: owners,
            created: created,
            updated: updated
        )
    }

    /// Transform the success result of `ListEmailAddressesQuery` from the service to a `EmailAccountEntity`.
    func transform(_ graphQLEmail: ListEmailAddressesQuery.Data.ListEmailAddress.Item) throws -> EmailAccountEntity {
        let id = graphQLEmail.id
        let userId = graphQLEmail.userId
        let sudoId = graphQLEmail.sudoId
        let identityId = graphQLEmail.identityId
        let keyRingId = graphQLEmail.keyRingId
        let emailAddress = try emailAddressTransformer.transform(graphQLEmail.emailAddress)
        let owners = graphQLEmail.owners.map(ownerTransformer.transform(_:))
        let created = Date(millisecondsSince1970: graphQLEmail.createdAtEpochMs)
        let updated = Date(millisecondsSince1970: graphQLEmail.updatedAtEpochMs)
        return EmailAccountEntity(
            id: id,
            userId: userId,
            sudoId: sudoId,
            identityId: identityId,
            keyRingId: keyRingId,
            emailAddress: emailAddress,
            owners: owners,
            created: created,
            updated: updated
        )
    }

}
