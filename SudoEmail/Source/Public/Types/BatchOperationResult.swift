//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public enum BatchOperationResultStatus {
    case success
    case partial
    case failure
}

/// Result type of an API that returns multiple records. Supports partial results.
public struct BatchOperationResult<S, F> {

    // MARK: - Properties

    /// The result status of the operation
    public var status: BatchOperationResultStatus

    /// List of items with successful operations
    public var successItems: [S]?

    /// List of items with failed operations
    public var failureItems: [F]?

    // MARK: - Lifecycle

    public init(status: BatchOperationResultStatus, successItems: [S]? = nil, failureItems: [F]? = nil) {
        self.status = status
        self.successItems = successItems
        self.failureItems = failureItems
    }
}

/// Representation of the result of an unsuccessful operation performed on an email message
public struct EmailMessageOperationFailureResult: Error, Equatable {

    // MARK: - Properties

    /// The unique identifier of the message
    public let id: String

    /// Description of the cause of the failure
    public let errorType: String

    // MARK: - Lifecycle

    /// Initialize an instance of `EmailMessageOperationFailureResult`
    public init(id: String, errorType: String) {
        self.id = id
        self.errorType = errorType
    }

    // MARK: - Conformance: Equatable

    public static func == (lhs: EmailMessageOperationFailureResult, rhs: EmailMessageOperationFailureResult) -> Bool {
        return lhs.id == rhs.id &&
            lhs.errorType == rhs.errorType
    }
}
