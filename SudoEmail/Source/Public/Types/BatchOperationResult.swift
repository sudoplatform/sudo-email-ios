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

public struct BatchOperationPartialResult<P> {
    public var partial: P
    public var error: Error

    public init(partial: P, error: Error) {
        self.partial = partial
        self.error = error
    }
}

/// Result type of an API that returns multiple records. Supports partial results.
public enum BatchOperationResult<T> {

    // MARK: - Supplementary

    public struct BatchOperationPartialResult {
        public var status = BatchOperationResultStatus.partial
        public var successItems: [T]
        public var failureItems: [T]

        public init (successItems: [T], failureItems: [T]) {
            self.successItems = successItems
            self.failureItems = failureItems
        }
    }

    /// Result is successful
    case success
    /// Result is partial, returning a list of mixed success and partial results.
    case partial(BatchOperationPartialResult)
    /// Result is failed
    case failure
}
