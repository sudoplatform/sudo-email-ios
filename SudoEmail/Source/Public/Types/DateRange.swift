//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct DateRange: Equatable {

    /// The starting date of the range to query.
    public let startDate: Date

    /// The ending date of the range to query.
    public let endDate: Date

    // MARK: - Lifecycle

    public init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }

    // MARK: - Methods: Internal

    func toGraphQL() -> GraphQL.DateRangeInput {
        return .init(
            endDateEpochMs: floor(self.endDate.millisecondsSince1970),
            startDateEpochMs: floor(self.startDate.millisecondsSince1970)
        )
    }

}
