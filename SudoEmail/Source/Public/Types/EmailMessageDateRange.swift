//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of an email message date range used in the Sudo Platform Email SDK.
///
/// Note that both timestamps cannot be specified otherwise an `InvalidArgumentError` will occur.
public struct EmailMessageDateRange: Equatable {

    /// The specification of the sortDate timestamp to perform the date range query on.
    public let sortDate: DateRange?

    /// The specification of the updatedAt timestamp to perform the date range query on.
    public let updatedAt: DateRange?

    // MARK: - Lifecycle

    public init(sortDate: DateRange? = nil, updatedAt: DateRange? = nil) {
        self.sortDate = sortDate
        self.updatedAt = updatedAt
    }
    
    // MARK: - Methods: Internal

    func toGraphQL() -> GraphQL.EmailMessageDateRangeInput? {
        return .init(
            sortDateEpochMs: self.sortDate.map {
                GraphQL.DateRangeInput(
                    endDateEpochMs: floor($0.endDate.millisecondsSince1970),
                    startDateEpochMs: floor($0.startDate.millisecondsSince1970)
                )
            },
            updatedAtEpochMs: self.updatedAt.map {
                GraphQL.DateRangeInput(
                    endDateEpochMs: floor($0.endDate.millisecondsSince1970),
                    startDateEpochMs: floor($0.startDate.millisecondsSince1970)
                )
            }
        )
    }
}
