//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct PartialResult<P> {
    public var partial: P
    public var error: Error

    public init(partial: P, error: Error) {
        self.partial = partial
        self.error = error
    }
}

/// Result type of an API that returns multiple records. Supports partial results.
public enum ListAPIResult<T, P> {

    // MARK: - Supplementary

    public struct ListSuccessResult {
        public var items: [T]
        public var nextToken: String?

        public init(items: [T], nextToken: String? = nil) {
            self.items = items
            self.nextToken = nextToken
        }
    }

    public struct ListPartialResult {
        public var items: [T]
        public var failed: [PartialResult<P>]
        public var nextToken: String?

        public init(items: [T], failed: [PartialResult<P>], nextToken: String?) {
            self.items = items
            self.failed = failed
            self.nextToken = nextToken
        }
    }

    /// Result is successful, returning a list of all results.
    case success(ListSuccessResult)
    /// Result is partial, returning a list of mixed success and partial results.
    case partial(ListPartialResult)
}
