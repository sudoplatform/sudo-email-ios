//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
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

    // MARK: - Properties

    /// Utility to transform email message direction entities to result direction outputs of the SDK.
    let directionTransformer = DirectionAPITransformer()

    /// Utility to transform email message state entities to result state outputs of the SDK.
    let stateTransformer = StateAPITransformer()

    /// Transform a email message entity into an email message result of the SDK.
    ///
    /// If input is `nil`, `nil` will be returned.
    func transform(_ entity: EmailMessageEntity?) -> EmailMessage? {
        guard let entity = entity else {
            return nil
        }
        return transform(entity)
    }

    /// Transform a email message state entity into an email message state result of the SDK.
    func transform(_ entity: EmailMessageEntity) -> EmailMessage {
        let id = entity.id
        let clientRefid = entity.clientRefId
        let owner = entity.owner
        let created = entity.created
        let updated = entity.updated
        let address = entity.accountAddress.address
        let seen = entity.seen
        let direction = directionTransformer.transform(entity.direction)
        let state = stateTransformer.transform(entity.state)
        let from = entity.from.map { $0.address }
        let to = entity.to.map { $0.address }
        let cc = entity.cc.map { $0.address }
        let bcc = entity.bcc.map { $0.address }
        let subject = entity.subject

        return EmailMessage(
            id: id,
            clientRefId: clientRefid,
            owner: owner,
            created: created,
            updated: updated,
            address: address,
            seen: seen,
            direction: direction,
            state: state,
            from: from,
            to: to,
            cc: cc,
            bcc: bcc,
            subject: subject
        )
    }
}
