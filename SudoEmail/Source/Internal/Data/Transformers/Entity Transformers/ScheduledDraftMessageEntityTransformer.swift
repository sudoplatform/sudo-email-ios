//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK
struct ScheduledDraftMessageEntityTransformer {

    // MARK: - Methods

    func transform(_ scheduledDraftMessage: GraphQL.ScheduleSendDraftMessageMutation.Data.ScheduleSendDraftMessage) throws -> ScheduledDraftMessageEntity {
        let ownerTransformer = OwnerEntityTransformer()
        let stateTransformer = ScheduledDraftMessageStateEntityTransformer()
        let key = scheduledDraftMessage.draftMessageKey
        guard let id = key.suffixAfter(separator: "/") else {
            throw SudoEmailError.internalError("Invalid s3Key \(key)")
        }
        let state = try stateTransformer.transform(scheduledDraftMessage.getScheduledDraftMessageState())
        return ScheduledDraftMessageEntity(
            id: id,
            emailAddressId: scheduledDraftMessage.emailAddressId,
            sendAt: Date(millisecondsSince1970: scheduledDraftMessage.sendAtEpochMs),
            owner: scheduledDraftMessage.owner,
            owners: scheduledDraftMessage.owners.map(ownerTransformer.transform(_:)),
            state: state,
            createdAt: Date(millisecondsSince1970: scheduledDraftMessage.createdAtEpochMs),
            updatedAt: Date(millisecondsSince1970: scheduledDraftMessage.updatedAtEpochMs)
        )
    }

    func transform(
        _ scheduledDraftMessage: GraphQL.ListScheduledDraftMessagesForEmailAddressIdQuery.Data.ListScheduledDraftMessagesForEmailAddressId.Item
    ) throws -> ScheduledDraftMessageEntity {
        let ownerTransformer = OwnerEntityTransformer()
        let stateTransformer = ScheduledDraftMessageStateEntityTransformer()
        let key = scheduledDraftMessage.draftMessageKey
        guard let id = key.suffixAfter(separator: "/") else {
            throw SudoEmailError.internalError("Invalid s3Key \(key)")
        }
        let state = try stateTransformer.transform(scheduledDraftMessage.getScheduledDraftMessageState())
        return ScheduledDraftMessageEntity(
            id: id,
            emailAddressId: scheduledDraftMessage.emailAddressId,
            sendAt: Date(millisecondsSince1970: scheduledDraftMessage.sendAtEpochMs),
            owner: scheduledDraftMessage.owner,
            owners: scheduledDraftMessage.owners.map(ownerTransformer.transform(_:)),
            state: state,
            createdAt: Date(millisecondsSince1970: scheduledDraftMessage.createdAtEpochMs),
            updatedAt: Date(millisecondsSince1970: scheduledDraftMessage.updatedAtEpochMs)
        )
    }
}
