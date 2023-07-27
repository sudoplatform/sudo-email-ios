//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform email message entities from the core level to output results of the SDK.
struct EmailMessageAPITransformer {

    // MARK: - Supplementary

    /// Utility class to transform email message direction entities from the core level to output results of the SDK.
    struct DirectionAPITransformer {
        /// Transform a email message direction entity into an email message direction result of the SDK.
        func transform(_ directionEntity: DirectionEntity) -> EmailMessage.Direction {
            switch directionEntity {
            case .inbound:
                return .inbound
            case .outbound:
                return .outbound
            }
        }
    }

    /// Utility class to transform email message state entities from the core level to output results of the SDK.
    struct StateAPITransformer {
        /// Transform a email message state entity into an email message state result of the SDK.
        func transform(_ stateEntity: StateEntity) -> EmailMessage.State {
            switch stateEntity {
            case .queued:
                return .queued
            case .sent:
                return .sent
            case .delivered:
                return .delivered
            case .undelivered:
                return .undelivered
            case .failed:
                return .failed
            case .received:
                return .received
            }
        }
    }

    /// Utility class to transform email message address entities from the core level to output results of the SDK
    struct EmailAddressAPITransformer {
        /// Transform an email message address entity into an email message address result of the SDK.
        func transform(_ emailAddressEntity: EmailAddressEntity) -> EmailMessage.EmailAddress {
            return EmailMessage.EmailAddress(address: emailAddressEntity.emailAddress, displayName: emailAddressEntity.displayName)
        }
    }

    // MARK: - Properties

    /// Utility to transform email message direction entities to result direction outputs of the SDK.
    let directionTransformer = DirectionAPITransformer()

    /// Utility to transform email message state entities to result state outputs of the SDK.
    let stateTransformer = StateAPITransformer()

    /// Utility to transform email message address entities from the core level to output results of the SDK
    let emailAddressAPITransformer = EmailAddressAPITransformer()

    /// Utility to transform email message owner entities from the core level to output results of the SDK
    let ownerTransformer = OwnerEntityTransformer()

    /// Transform a email message entity into an email message result of the SDK.
    ///
    /// If input is `nil`, `nil` will be returned.
    func transform(_ entity: EmailMessageEntity?) -> EmailMessage? {
        guard let entity = entity else {
            return nil
        }
        return transform(entity)
    }

    /// Transform a email message entity into an email message result of the SDK.
    func transform(_ entity: EmailMessageEntity) -> EmailMessage {
        /// Mapping to messageId is correct as the internal `id` is used internally only.
        let id = entity.id
        let clientRefid = entity.clientRefId
        let owner = entity.owner
        let owners = entity.owners.map { ownerTransformer.transform($0) }
        let createdAt = entity.createdAt
        let updatedAt = entity.updatedAt
        let sortDate = entity.sortDate
        let emailAddressId = entity.emailAddressId
        let folderId = entity.folderId
        let previousFolderId = entity.previousFolderId
        let seen = entity.seen
        let direction = directionTransformer.transform(entity.direction)
        let state = stateTransformer.transform(entity.state)
        let version = entity.version
        let size = entity.size
        let from = entity.from.map { emailAddressAPITransformer.transform($0) }
        let replyTo = entity.replyTo.map { emailAddressAPITransformer.transform($0) }
        let to = entity.to.map { emailAddressAPITransformer.transform($0) }
        let cc = entity.cc.map { emailAddressAPITransformer.transform($0) }
        let bcc = entity.bcc.map { emailAddressAPITransformer.transform($0) }
        let subject = entity.subject
        let hasAttachments = entity.hasAttachments
        return EmailMessage(
            id: id,
            clientRefId: clientRefid,
            owner: owner,
            owners: owners,
            emailAddressId: emailAddressId,
            folderId: folderId,
            previousFolderId: previousFolderId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sortDate: sortDate,
            seen: seen,
            direction: direction,
            state: state,
            version: version,
            size: size,
            from: from,
            replyTo: replyTo,
            to: to,
            cc: cc,
            bcc: bcc,
            subject: subject,
            hasAttachments: hasAttachments
        )
    }

    /// Transform a partial email message entity into a partial email message result of the SDK.
    func transform(_ entity: PartialEmailMessageEntity) -> PartialEmailMessage {
        /// Mapping to messageId is correct as the internal `id` is used internally only.
        let id = entity.id
        let clientRefid = entity.clientRefId
        let owner = entity.owner
        let owners = entity.owners.map { ownerTransformer.transform($0) }
        let createdAt = entity.createdAt
        let updatedAt = entity.updatedAt
        let sortDate = entity.sortDate
        let emailAddressId = entity.emailAddressId
        let folderId = entity.folderId
        let previousFolderId = entity.previousFolderId
        let seen = entity.seen
        let direction = directionTransformer.transform(entity.direction)
        let state = stateTransformer.transform(entity.state)
        let version = entity.version
        let size = entity.size
        return PartialEmailMessage(
            id: id,
            clientRefId: clientRefid,
            owner: owner,
            owners: owners,
            emailAddressId: emailAddressId,
            folderId: folderId,
            previousFolderId: previousFolderId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            sortDate: sortDate,
            seen: seen,
            direction: direction,
            state: state,
            version: version,
            size: size
        )
    }

}
