//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

// swiftlint:disable type_name

/// Utility class to transform Input `EmailMessageDirectionFilters` to `EmailMessageDirectionFilterEntity`.
struct EmailMessageDirectionFilterEntityTransformer {

    // MARK: - Properties

    /// Utility to transform `EmailMessage.Direction` to `DirectionEntity`.
    let directionTransformer = EmailMessageDirectionEntityTransformer()

    // MARK: - Methods

    /// Transform a input `EmailMessageDirectionFilter` into a `EmailMessageDirectionFilterEntity`.
    func transform(_ filter: EmailMessageDirectionFilter) -> EmailMessageDirectionFilterEntity {
        switch filter {
        case let .equals(direction):
            let direction = directionTransformer.transform(direction)
            return .equals(direction)
        case let .notEquals(direction):
            let direction = directionTransformer.transform(direction)
            return .notEquals(direction)
        }
    }

}

// swiftlint:enable type_name
