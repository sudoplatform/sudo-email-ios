//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct OwnerEntityTransformer {

    /// Transform the success result of `ProvisionEmailAddressMutation` from the service to a `OwnerEntity`.
    func transform(_ data: GraphQL.ProvisionEmailAddressMutation.Data.ProvisionEmailAddress.Owner) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `DeprovisionEmailAddressMutation` from the service to a `OwnerEntity`.
    func transform(_ data: GraphQL.DeprovisionEmailAddressMutation.Data.DeprovisionEmailAddress.Owner) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `GetEmailAddressQuery` from the service to a `OwnerEntity`.
    func transform(_ data: GraphQL.GetEmailAddressQuery.Data.GetEmailAddress.Owner) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `ListEmailAddressesQuery` from the service to a `OwnerEntity`.
    func transform(_ data: GraphQL.ListEmailAddressesQuery.Data.ListEmailAddress.Item.Owner) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `ListEmailAddressesQuery` from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.ListEmailAddressesForSudoIdQuery.Data.ListEmailAddressesForSudoId.Item.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `GetEmailMessageQuery` from the service to a `OwnerEntity`.
    func transform(_ data: GraphQL.GetEmailMessageQuery.Data.GetEmailMessage.Owner) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `ProvisionEmailAddressMutation` Folder from the service to a `OwnerEntity`.
    func transform(_ data: GraphQL.ProvisionEmailAddressMutation.Data.ProvisionEmailAddress.Folder.Owner) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `GetEmailAddressQuery` Folder from the service to a `OwnerEntity`.
    func transform(_ data: GraphQL.GetEmailAddressQuery.Data.GetEmailAddress.Folder.Owner) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `ListEmailAddressesQuery` Folder from the service to a `OwnerEntity`.
    func transform(_ data: GraphQL.ListEmailAddressesQuery.Data.ListEmailAddress.Item.Folder.Owner) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `ListEmailAddressesForSudoIdQuery` Folder from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.ListEmailAddressesForSudoIdQuery.Data.ListEmailAddressesForSudoId.Item.Folder.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `ListEmailAddressesQuery` Folder from the service to a `Owner`.
    func transform(_ data: OwnerEntity) -> Owner {
        let id = data.id
        let issuer = data.issuer
        return Owner(id: id, issuer: issuer)
    }

    /// Transform the success result of `ListEmailMessagesQuery` Owner from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.ListEmailMessagesQuery.Data.ListEmailMessage.Item.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `ListEmailMessagesForEmailAddressIdQuery` Owner from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.ListEmailMessagesForEmailAddressIdQuery.Data.ListEmailMessagesForEmailAddressId.Item.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `ListEmailFoldersForEmailAddressIdQuery` Owner from the service to an `OwnerEntity`.
    func transform(
        _ data: GraphQL.ListEmailFoldersForEmailAddressIdQuery.Data.ListEmailFoldersForEmailAddressId.Item.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `ListEmailMessagesForEmailFolderIdQuery` Owner from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.ListEmailMessagesForEmailFolderIdQuery.Data.ListEmailMessagesForEmailFolderId.Item.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `OnEmailMessageCreatedSubscription` owner from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.OnEmailMessageCreatedSubscription.Data.OnEmailMessageCreated.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `OnEmailMessageCreatedWithDirectionSubscription` owner from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.OnEmailMessageCreatedWithDirectionSubscription.Data.OnEmailMessageCreated.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `OnEmailMessageDeletedSubscription` owner from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.OnEmailMessageDeletedSubscription.Data.OnEmailMessageDeleted.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `OnEmailMessageDeletedWithIdSubscription` owner from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.OnEmailMessageDeletedWithIdSubscription.Data.OnEmailMessageDeleted.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `OnEmailMessageUpdatedSubscription` owner from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.OnEmailMessageUpdatedSubscription.Data.OnEmailMessageUpdated.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `OnEmailMessageUpdatedWithIdSubscription` owner from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.OnEmailMessageUpdatedWithIdSubscription.Data.OnEmailMessageUpdated.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `CreateCustomEmailFolder` owner from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.CreateCustomEmailFolderMutation.Data.CreateCustomEmailFolder.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `DeleteCustomEmailFolder` owner from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.DeleteCustomEmailFolderMutation.Data.DeleteCustomEmailFolder.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `UpdateCustomEmailFolder` owner from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.UpdateCustomEmailFolderMutation.Data.UpdateCustomEmailFolder.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `ScheduleDraftMessage` owner from the service to a `OwnerEntity`.
    func transform(
        _ data: GraphQL.ScheduleSendDraftMessageMutation.Data.ScheduleSendDraftMessage.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }

    /// Transform the success result of `ListScheduledDraftMessagesForEmailAddressId` owner from the service to a `OwnerEntity`.
    func transform(
        _ data:
        GraphQL.ListScheduledDraftMessagesForEmailAddressIdQuery.Data.ListScheduledDraftMessagesForEmailAddressId.Item.Owner
    ) -> OwnerEntity {
        let id = data.id
        let issuer = data.issuer
        return OwnerEntity(id: id, issuer: issuer)
    }
}
