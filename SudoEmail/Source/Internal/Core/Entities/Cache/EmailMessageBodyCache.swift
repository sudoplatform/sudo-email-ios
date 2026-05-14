//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Internal protocol defining the email message body cache operations.
///
/// The cache stores sealed email message blobs locally to avoid redundant S3 downloads.
/// All operations are async. Implementations (actors) automatically satisfy the Sendable requirement.
protocol EmailMessageBodyCache: Sendable {

    /// Retrieve a sealed blob from the cache.
    ///
    /// Returns `nil` on a miss or if the entry is stale/unreadable (stale entry is removed).
    /// Updates `lastAccessedAt` on hit.
    ///
    /// - Parameter messageId: Identifier of the email message to retrieve.
    /// - Returns: The cached result, or `nil` if not found or stale.
    func get(messageId: String) async -> CacheItem?

    /// Store a sealed blob in the cache.
    ///
    /// No-ops if the blob is larger than the configured cache size limit.
    /// Evicts LRU entries as needed before inserting.
    ///
    /// - Parameter entry: The cache entry to store.
    func put(entry: CacheItem) async

    /// Remove a single entry by message ID.
    ///
    /// No-op if not present.
    ///
    /// - Parameter messageId: Identifier of the message to remove from the cache.
    func deleteMessage(messageId: String) async

    /// Remove all entries matching the given scope.
    ///
    /// - Parameter input: The flush scope (sudo ID or email address ID).
    func flush(input: CacheFlushInput) async

    /// Remove all entries from the cache.
    func flushAll() async

    /// Update the cache size limit.
    ///
    /// Triggers immediate LRU eviction if current usage exceeds the new limit.
    /// Persists the new limit in the settings table.
    ///
    /// - Parameter bytes: The new cache size limit in bytes. Must be >= 0.
    /// - Throws: `SudoEmailError.invalidArgument` if `bytes` is negative.
    func setCacheSizeLimit(bytes: Int64) async throws

    /// Returns the current persisted cache size limit in bytes.
    func getCacheSizeLimit() async -> Int64
}
