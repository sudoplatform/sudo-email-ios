//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform scheduled draft entities from the core level to output results of the SDK,
struct ScheduledDraftMessageApiTransformer {

    // MARK: - Methods

    func transform(_ entity: ScheduledDraftMessageEntity) -> ScheduledDraftMessage {
        let ownerTransformer = OwnerEntityTransformer()
        return ScheduledDraftMessage(
            id: entity.id,
            emailAddressId: entity.emailAddressId,
            sendAt: entity.sendAt,
            owner: entity.owner,
            owners: entity.owners.map(ownerTransformer.transform(_:)),
            state: transformState(entity.state),
            createdAt: entity.createdAt,
            updatedAt: entity.updatedAt
        )
    }

    // MARK: - Utilities

    private func transformState(_ state: ScheduledDraftMessageStateEntity) -> ScheduledDraftMessageState {
        switch state {
        case .scheduled:
            return .scheduled
        case .cancelled:
            return .cancelled
        case .failed:
            return .failed
        case .sent:
            return .sent
        }
    }
}
