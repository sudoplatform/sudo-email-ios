//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
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
public struct BatchOperationResult<S,F> {

    // MARK: - Supplementary
    public var status: BatchOperationResultStatus
    
    public var successItems: [S]?
    
    public var failureItems: [F]?
    
    public init(status: BatchOperationResultStatus, successItems: [S]? = nil, failureItems: [F]? = nil) {
        self.status = status
        self.successItems = successItems
        self.failureItems = failureItems
    }
}

/// Representation of the result of an unsuccessful operation performed on an email message
public struct EmailMessageOperationFailureResult: Equatable {
    
    /// The unique identifier of the message
    public var id: String
    
    /// Description of the cause of the failure
    public var errorType: String
    
    // MARK: - Conformance: Equatable

    public static func == (lhs: EmailMessageOperationFailureResult, rhs: EmailMessageOperationFailureResult) -> Bool {
        return lhs.id == rhs.id &&
               lhs.errorType == rhs.errorType
    }
}
