//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct SealedEmailMessageEntityTransformer {

    /// Utility for transforming email message directions to `DirectionEntity`.
    let directionTransformer = EmailMessageDirectionEntityTransformer()

    /// Utility for transforming email message state to `StateEntity`.
    let stateTransformer = EmailMessageStateEntityTransformer()

    /// Transform the success result of `GetEmailMessageQuery` from the service to a `EmailMessageEntity`.
    func transform(
        _ graphQLMessage: GetEmailMessageQuery.Data.GetEmailMessage
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let messageId = graphQLMessage.messageId
        let userId = graphQLMessage.userId
        let sudoId = graphQLMessage.sudoId
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.keyId
        let algorithm = graphQLMessage.algorithm
        let clientRefId = graphQLMessage.clientRefId
        let created = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updated = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let seen = graphQLMessage.seen
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        /// Sealed Attributes.
        let from = graphQLMessage.from
        let replyTo = graphQLMessage.replyTo
        let to = graphQLMessage.to
        let cc = graphQLMessage.cc
        let bcc = graphQLMessage.bcc
        let subject = graphQLMessage.subject
        return SealedEmailMessageEntity(
            id: id,
            messageId: messageId,
            userId: userId,
            sudoId: sudoId,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            clientRefId: clientRefId,
            created: created,
            updated: updated,
            seen: seen,
            direction: direction,
            state: state,
            from: from,
            replyTo: replyTo,
            to: to,
            cc: cc,
            bcc: bcc,
            subject: subject
        )
    }

    /// Transform the success result of `ListEmailMessageQuery` from the service to a `EmailMessageEntity`.
    func transform(
        _ graphQLMessage: ListEmailMessagesQuery.Data.ListEmailMessage.Item
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let messageId = graphQLMessage.messageId
        let userId = graphQLMessage.userId
        let sudoId = graphQLMessage.sudoId
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.keyId
        let algorithm = graphQLMessage.algorithm
        let clientRefId = graphQLMessage.clientRefId
        let created = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updated = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let seen = graphQLMessage.seen
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        /// Sealed Attributes.
        let from = graphQLMessage.from
        let replyTo = graphQLMessage.replyTo
        let to = graphQLMessage.to
        let cc = graphQLMessage.cc
        let bcc = graphQLMessage.bcc
        let subject = graphQLMessage.subject
        return SealedEmailMessageEntity(
            id: id,
            messageId: messageId,
            userId: userId,
            sudoId: sudoId,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            clientRefId: clientRefId,
            created: created,
            updated: updated,
            seen: seen,
            direction: direction,
            state: state,
            from: from,
            replyTo: replyTo,
            to: to,
            cc: cc,
            bcc: bcc,
            subject: subject
        )
    }

    /// Transform the success result of `OnEmailMessageCreatedSubscription` from the service to a `EmailMessageEntity`.
    func transform(
        _ graphQLMessage: OnEmailMessageCreatedSubscription.Data.OnEmailMessageCreated
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let messageId = graphQLMessage.messageId
        let userId = graphQLMessage.userId
        let sudoId = graphQLMessage.sudoId
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.keyId
        let algorithm = graphQLMessage.algorithm
        let clientRefId = graphQLMessage.clientRefId
        let created = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updated = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let seen = graphQLMessage.seen
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        /// Sealed Attributes.
        let from = graphQLMessage.from
        let replyTo = graphQLMessage.replyTo
        let to = graphQLMessage.to
        let cc = graphQLMessage.cc
        let bcc = graphQLMessage.bcc
        let subject = graphQLMessage.subject
        return SealedEmailMessageEntity(
            id: id,
            messageId: messageId,
            userId: userId,
            sudoId: sudoId,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            clientRefId: clientRefId,
            created: created,
            updated: updated,
            seen: seen,
            direction: direction,
            state: state,
            from: from,
            replyTo: replyTo,
            to: to,
            cc: cc,
            bcc: bcc,
            subject: subject
        )
    }

    /// Transform the success result of `OnEmailMessageCreatedWithDirectionSubscription` from the service to a `EmailMessageEntity`.
    func transform(
        _ graphQLMessage: OnEmailMessageCreatedWithDirectionSubscription.Data.OnEmailMessageCreated
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let messageId = graphQLMessage.messageId
        let userId = graphQLMessage.userId
        let sudoId = graphQLMessage.sudoId
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.keyId
        let algorithm = graphQLMessage.algorithm
        let clientRefId = graphQLMessage.clientRefId
        let created = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updated = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let seen = graphQLMessage.seen
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        /// Sealed Attributes.
        let from = graphQLMessage.from
        let replyTo = graphQLMessage.replyTo
        let to = graphQLMessage.to
        let cc = graphQLMessage.cc
        let bcc = graphQLMessage.bcc
        let subject = graphQLMessage.subject
        return SealedEmailMessageEntity(
            id: id,
            messageId: messageId,
            userId: userId,
            sudoId: sudoId,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            clientRefId: clientRefId,
            created: created,
            updated: updated,
            seen: seen,
            direction: direction,
            state: state,
            from: from,
            replyTo: replyTo,
            to: to,
            cc: cc,
            bcc: bcc,
            subject: subject
        )
    }

    /// Transform the success result of `OnEmailMessageDeletedSubscription` from the service to a `EmailMessageEntity`.
    func transform(
        _ graphQLMessage: OnEmailMessageDeletedSubscription.Data.OnEmailMessageDeleted
    ) throws -> SealedEmailMessageEntity {
        /// Transform GraphQL properties.
        let id = graphQLMessage.id
        let messageId = graphQLMessage.messageId
        let userId = graphQLMessage.userId
        let sudoId = graphQLMessage.sudoId
        let emailAddressId = graphQLMessage.emailAddressId
        let keyId = graphQLMessage.keyId
        let algorithm = graphQLMessage.algorithm
        let clientRefId = graphQLMessage.clientRefId
        let created = Date(millisecondsSince1970: graphQLMessage.createdAtEpochMs)
        let updated = Date(millisecondsSince1970: graphQLMessage.updatedAtEpochMs)
        let seen = graphQLMessage.seen
        let direction = try directionTransformer.transform(graphQLMessage.direction)
        let state = try stateTransformer.transform(graphQLMessage.state)
        /// Sealed Attributes.
        let from = graphQLMessage.from
        let replyTo = graphQLMessage.replyTo
        let to = graphQLMessage.to
        let cc = graphQLMessage.cc
        let bcc = graphQLMessage.bcc
        let subject = graphQLMessage.subject
        return SealedEmailMessageEntity(
            id: id,
            messageId: messageId,
            userId: userId,
            sudoId: sudoId,
            emailAddressId: emailAddressId,
            keyId: keyId,
            algorithm: algorithm,
            clientRefId: clientRefId,
            created: created,
            updated: updated,
            seen: seen,
            direction: direction,
            state: state,
            from: from,
            replyTo: replyTo,
            to: to,
            cc: cc,
            bcc: bcc,
            subject: subject
        )
    }
}
