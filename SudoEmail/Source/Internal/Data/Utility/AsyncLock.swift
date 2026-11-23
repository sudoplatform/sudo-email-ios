//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import Synchronization

/// Runs async work one piece at a time: work passed to `withLock(_:)` starts only once earlier work has finished,
/// including across suspension points. Waiters run in the order they arrived.
final class AsyncLock: Sendable {

    // MARK: - Supplementary

    /// Whether the lock is held, and the tasks waiting for it.
    struct State {
        var isLocked = false
        var waiters: [CheckedContinuation<Void, Never>] = []
    }

    // MARK: - Properties

    /// Guards `State`. Never held across a suspension point.
    let state = Mutex(State())

    // MARK: - Methods

    /// Runs `body` once every earlier caller's `body` has finished.
    /// - Parameter body: The work to run while holding the lock.
    /// - Returns: The result of `body`.
    func withLock<Result>(_ body: () async throws -> Result) async rethrows -> Result {
        await acquire()
        defer { release() }
        return try await body()
    }

    // MARK: - Helpers

    /// Takes the lock, waiting for it if another caller holds it.
    func acquire() async {
        await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
            let acquired = state.withLock { state in
                guard state.isLocked else {
                    state.isLocked = true
                    return true
                }
                state.waiters.append(continuation)
                return false
            }
            if acquired {
                continuation.resume()
            }
        }
    }

    /// Hands the lock to the next waiter, or frees it if nobody is waiting.
    func release() {
        let next = state.withLock { state -> CheckedContinuation<Void, Never>? in
            guard !state.waiters.isEmpty else {
                state.isLocked = false
                return nil
            }
            return state.waiters.removeFirst()
        }
        next?.resume()
    }
}
