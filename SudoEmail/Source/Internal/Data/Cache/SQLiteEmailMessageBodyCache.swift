//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SQLite3
import SudoLogging

/// Concrete implementation of `EmailMessageBodyCache` using libsqlite3 and filesystem storage.
///
/// All operations are serialized by the actor to ensure thread safety. Large messages (>1 MB)
/// are stored on the filesystem to avoid SQLite performance degradation from large BLOBs.
actor SQLiteEmailMessageBodyCache: EmailMessageBodyCache {

    // MARK: - Schema Constants

    /// Table and column names for the cache entries table.
    private enum CacheTable {
        static let name = "email_message_body_cache"

        enum Column {
            static let messageId = "message_id"
            static let sudoId = "sudo_id"
            static let emailAddressId = "email_address_id"
            static let content = "content"
            static let fsPath = "fs_path"
            static let contentEncoding = "content_encoding"
            static let sizeBytes = "size_bytes"
            static let lastAccessedAt = "last_accessed_at"
        }

        enum Index {
            static let lastAccessed = "idx_cache_last_accessed"
            static let sudoId = "idx_cache_sudo_id"
            static let emailAddressId = "idx_cache_email_address_id"
        }
    }

    /// Table and column names for the settings table.
    private enum SettingsTable {
        static let name = "email_message_cache_settings"

        enum Column {
            static let key = "key"
            static let value = "value"
        }

        enum Key {
            static let cacheSizeLimitBytes = "cache_size_limit_bytes"
        }
    }

    // MARK: - Constants

    /// Default maximum cache size: 300 MB.
    static let defaultCacheSizeLimitBytes: Int64 = 300 * 1024 * 1024

    /// Messages larger than this threshold are stored on the filesystem rather than inline in SQLite.
    static let largeMessageThresholdBytes: Int64 = 1 * 1024 * 1024

    // MARK: - Properties

    /// Path to the SQLite database file.
    private let databasePath: String

    /// Directory path for storing large message blobs on the filesystem.
    private let blobStoragePath: String

    /// Logger for diagnostic and error information.
    private let logger: SudoLogging.Logger

    /// SQLite database handle.
    private var db: OpaquePointer?

    /// Current cache size limit in bytes. Updated via `setCacheSizeLimit`.
    private var cacheSizeLimitBytes: Int64

    /// Whether the database was successfully opened.
    private var isDatabaseOpen: Bool {
        db != nil
    }

    /// All columns in select order for the cache table.
    private static var allColumns: String {
        let c = CacheTable.Column.self
        return "\(c.messageId), \(c.sudoId), \(c.emailAddressId), \(c.content), \(c.fsPath), \(c.contentEncoding), \(c.sizeBytes), \(c.lastAccessedAt)"
    }

    /// Internal row representation for query results.
    private struct CacheRow {
        let messageId: String
        let sudoId: String?
        let emailAddressId: String
        let content: Data?
        let fsPath: String?
        let contentEncoding: String?
        let sizeBytes: Int64
        let lastAccessedAt: Int64
    }

    // MARK: - Lifecycle

    /// Initialize the cache.
    ///
    /// - Parameters:
    ///   - storagePath: Root directory for cache storage. Defaults to `{Application Support}/sudo-email-cache/`.
    ///   - initialCacheSizeLimitBytes: Initial cache size limit used on first run. Ignored if a persisted value exists.
    ///   - logger: Logger instance for diagnostic output.
    init(
        storagePath: String? = nil,
        initialCacheSizeLimitBytes: Int64 = SQLiteEmailMessageBodyCache.defaultCacheSizeLimitBytes,
        logger: SudoLogging.Logger = .emailSDKLogger
    ) {
        let basePath = storagePath ?? Self.defaultStoragePath()
        databasePath = (basePath as NSString).appendingPathComponent("email-cache.db")
        blobStoragePath = (basePath as NSString).appendingPathComponent("blobs")
        self.logger = logger

        // Create directories if needed
        Self.createDirectoryIfNeeded(at: basePath, logger: logger)
        Self.createDirectoryIfNeeded(at: blobStoragePath, logger: logger)

        // Open database, create schema, and load persisted settings
        let (openedDb, resolvedLimit) = Self.openAndInitializeDatabase(
            at: databasePath,
            initialCacheSizeLimitBytes: initialCacheSizeLimitBytes,
            logger: logger
        )
        db = openedDb
        cacheSizeLimitBytes = resolvedLimit
    }

    deinit {
        if let db = db {
            sqlite3_close(db)
        }
    }

    // MARK: - EmailMessageBodyCache Protocol

    func get(messageId: String) async -> CacheItem? {
        guard isDatabaseOpen, cacheSizeLimitBytes > 0 else { return nil }

        guard let row = queryEntry(messageId: messageId) else {
            return nil
        }

        // Resolve the sealed blob data
        let sealedBlob: Data
        if let content = row.content {
            sealedBlob = content
        } else if let fsPath = row.fsPath {
            do {
                sealedBlob = try Data(contentsOf: URL(fileURLWithPath: fsPath))
            } catch {
                // Stale entry: filesystem blob is missing or unreadable
                logger.error("Cache stale entry: failed to read blob at \(fsPath): \(error.localizedDescription)")
                deleteEntry(messageId: messageId)
                return nil
            }
        } else {
            // Both content and fs_path are null — stale entry
            logger.error("Cache stale entry: both content and fs_path are null for messageId=\(messageId)")
            deleteEntry(messageId: messageId)
            return nil
        }

        // Update last accessed timestamp
        updateLastAccessedAt(messageId: messageId)

        return CacheItem(
            messageId: row.messageId,
            sudoId: row.sudoId,
            emailAddressId: row.emailAddressId,
            sealedBlob: sealedBlob,
            contentEncoding: row.contentEncoding
        )
    }

    func put(entry: CacheItem) async {
        guard isDatabaseOpen, cacheSizeLimitBytes > 0 else { return }

        let blobSize = Int64(entry.sealedBlob.count)

        // Never cache oversized messages
        if blobSize > cacheSizeLimitBytes {
            return
        }

        // Run LRU eviction to make space
        evictIfNeeded(forNewEntrySize: blobSize)

        // Determine storage strategy
        let now = currentTimestampMillis()

        if blobSize > Self.largeMessageThresholdBytes {
            // Store on filesystem
            let filePath = blobFilePath(for: entry.messageId)
            do {
                try entry.sealedBlob.write(to: URL(fileURLWithPath: filePath))
            } catch {
                logger.error("Cache: failed to write blob to filesystem at \(filePath): \(error.localizedDescription)")
                return
            }
            insertEntry(
                messageId: entry.messageId, sudoId: entry.sudoId, emailAddressId: entry.emailAddressId,
                content: nil, fsPath: filePath, contentEncoding: entry.contentEncoding,
                sizeBytes: blobSize, lastAccessedAt: now
            )
        } else {
            // Store inline in SQLite
            insertEntry(
                messageId: entry.messageId, sudoId: entry.sudoId, emailAddressId: entry.emailAddressId,
                content: entry.sealedBlob, fsPath: nil, contentEncoding: entry.contentEncoding,
                sizeBytes: blobSize, lastAccessedAt: now
            )
        }
    }

    func deleteMessage(messageId: String) async {
        guard isDatabaseOpen, cacheSizeLimitBytes > 0 else { return }
        deleteEntry(messageId: messageId)
    }

    func flush(input: CacheFlushInput) async {
        guard isDatabaseOpen, cacheSizeLimitBytes > 0 else { return }

        if let sudoId = input.sudoId {
            deleteEntriesBy(column: CacheTable.Column.sudoId, value: sudoId)
        } else if let emailAddressId = input.emailAddressId {
            deleteEntriesBy(column: CacheTable.Column.emailAddressId, value: emailAddressId)
        }
        // If neither is provided, no-op (defensive)
    }

    func flushAll() async {
        guard isDatabaseOpen, cacheSizeLimitBytes > 0 else { return }
        deleteAllEntries()
    }

    func setCacheSizeLimit(bytes: Int64) async throws {
        guard bytes >= 0 else {
            throw SudoEmailError.invalidArgument("Cache size limit must be >= 0")
        }

        cacheSizeLimitBytes = bytes
        persistCacheSizeLimit(bytes)

        if bytes == 0 {
            deleteAllEntries()
        } else {
            evictToFitLimit()
        }
    }

    func getCacheSizeLimit() async -> Int64 {
        return cacheSizeLimitBytes
    }

    // MARK: - Database Setup (static)

    /// Returns the default storage path: `{Application Support}/sudo-email-cache/`.
    private static func defaultStoragePath() -> String {
        let appSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        return appSupport.appendingPathComponent("sudo-email-cache").path
    }

    /// Creates a directory at the given path if it doesn't already exist.
    private static func createDirectoryIfNeeded(at path: String, logger: SudoLogging.Logger) {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path) {
            do {
                try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true)
            } catch {
                logger.error("Cache: failed to create directory at \(path): \(error.localizedDescription)")
            }
        }
    }

    /// Opens the database, creates the schema, and loads persisted settings.
    /// Returns the database pointer (or nil on failure) and the resolved cache size limit.
    private static func openAndInitializeDatabase(
        at databasePath: String,
        initialCacheSizeLimitBytes: Int64,
        logger: SudoLogging.Logger
    ) -> (OpaquePointer?, Int64) {
        // Open database
        var dbPointer: OpaquePointer?
        let result = sqlite3_open(databasePath, &dbPointer)
        guard result == SQLITE_OK, let db = dbPointer else {
            let errMsg = dbPointer.map { String(cString: sqlite3_errmsg($0)) } ?? "unknown error"
            logger.error("Cache: failed to open database at \(databasePath): \(errMsg)")
            if let dbPointer = dbPointer { sqlite3_close(dbPointer) }
            return (nil, initialCacheSizeLimitBytes)
        }

        // Create schema
        createSchema(db: db, logger: logger)

        // Load persisted cache size limit
        let resolvedLimit = loadPersistedCacheSizeLimit(db: db, initialValue: initialCacheSizeLimitBytes, logger: logger)
        return (db, resolvedLimit)
    }

    /// Creates the database schema (tables and indexes).
    private static func createSchema(db: OpaquePointer, logger: SudoLogging.Logger) {
        let t = CacheTable.self; let c = CacheTable.Column.self
        let i = CacheTable.Index.self; let s = SettingsTable.self; let sc = SettingsTable.Column.self

        let sql = """
        CREATE TABLE IF NOT EXISTS \(t.name) (
            \(c.messageId) TEXT PRIMARY KEY, \(c.sudoId) TEXT, \(c.emailAddressId) TEXT NOT NULL,
            \(c.content) BLOB, \(c.fsPath) TEXT, \(c.contentEncoding) TEXT,
            \(c.sizeBytes) INTEGER NOT NULL, \(c.lastAccessedAt) INTEGER NOT NULL
        );
        CREATE INDEX IF NOT EXISTS \(i.lastAccessed) ON \(t.name)(\(c.lastAccessedAt));
        CREATE INDEX IF NOT EXISTS \(i.sudoId) ON \(t.name)(\(c.sudoId));
        CREATE INDEX IF NOT EXISTS \(i.emailAddressId) ON \(t.name)(\(c.emailAddressId));
        CREATE TABLE IF NOT EXISTS \(s.name) (\(sc.key) TEXT PRIMARY KEY, \(sc.value) TEXT NOT NULL);
        """
        if sqlite3_exec(db, sql, nil, nil, nil) != SQLITE_OK {
            logger.error("Cache: failed to create schema: \(String(cString: sqlite3_errmsg(db)))")
        }
    }

    /// Loads the persisted cache size limit from the settings table, or writes the initial value if none exists.
    private static func loadPersistedCacheSizeLimit(db: OpaquePointer, initialValue: Int64, logger: SudoLogging.Logger) -> Int64 {
        let sql = "SELECT \(SettingsTable.Column.value) FROM \(SettingsTable.name) WHERE \(SettingsTable.Column.key) = '\(SettingsTable.Key.cacheSizeLimitBytes)'"
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
            logger.error("Cache: failed to prepare settings query: \(String(cString: sqlite3_errmsg(db)))")
            return initialValue
        }
        defer { sqlite3_finalize(stmt) }

        if sqlite3_step(stmt) == SQLITE_ROW, let cString = sqlite3_column_text(stmt, 0),
           let persisted = Int64(String(cString: cString)) {
            return persisted
        }

        // No persisted value — write the initial value
        persistCacheSizeLimit(db: db, bytes: initialValue, logger: logger)
        return initialValue
    }

    /// Persists the cache size limit to the settings table.
    private static func persistCacheSizeLimit(db: OpaquePointer, bytes: Int64, logger: SudoLogging.Logger) {
        let sql = "INSERT OR REPLACE INTO \(SettingsTable.name) (\(SettingsTable.Column.key), \(SettingsTable.Column.value)) VALUES ('\(SettingsTable.Key.cacheSizeLimitBytes)', ?)"
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
            logger.error("Cache: failed to prepare settings insert: \(String(cString: sqlite3_errmsg(db)))")
            return
        }
        defer { sqlite3_finalize(stmt) }
        sqlite3_bind_text(stmt, 1, (String(bytes) as NSString).utf8String, -1, nil)
        if sqlite3_step(stmt) != SQLITE_DONE {
            logger.error("Cache: failed to persist cache size limit: \(String(cString: sqlite3_errmsg(db)))")
        }
    }

    // MARK: - Query and CRUD Operations

    /// Query a single cache entry by message ID.
    private func queryEntry(messageId: String) -> CacheRow? {
        let sql = "SELECT \(Self.allColumns) FROM \(CacheTable.name) WHERE \(CacheTable.Column.messageId) = ?"
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
            logger.error("Cache: failed to prepare query: \(dbErrorMessage())")
            return nil
        }
        defer { sqlite3_finalize(stmt) }
        sqlite3_bind_text(stmt, 1, (messageId as NSString).utf8String, -1, nil)
        guard sqlite3_step(stmt) == SQLITE_ROW else { return nil }
        return rowFromStatement(stmt)
    }

    /// Update the last_accessed_at timestamp for a given message ID.
    private func updateLastAccessedAt(messageId: String) {
        let sql = "UPDATE \(CacheTable.name) SET \(CacheTable.Column.lastAccessedAt) = ? WHERE \(CacheTable.Column.messageId) = ?"
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
            logger.error("Cache: failed to prepare update: \(dbErrorMessage())")
            return
        }
        defer { sqlite3_finalize(stmt) }
        sqlite3_bind_int64(stmt, 1, currentTimestampMillis())
        sqlite3_bind_text(stmt, 2, (messageId as NSString).utf8String, -1, nil)
        if sqlite3_step(stmt) != SQLITE_DONE {
            logger.error("Cache: failed to update lastAccessedAt: \(dbErrorMessage())")
        }
    }

    /// Insert a cache entry.
    private func insertEntry(
        messageId: String, sudoId: String?, emailAddressId: String,
        content: Data?, fsPath: String?, contentEncoding: String?,
        sizeBytes: Int64, lastAccessedAt: Int64
    ) {
        // First delete any existing entry (to clean up filesystem files)
        deleteEntry(messageId: messageId)

        let sql = "INSERT INTO \(CacheTable.name) (\(Self.allColumns)) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
            logger.error("Cache: failed to prepare insert: \(dbErrorMessage())")
            return
        }
        defer { sqlite3_finalize(stmt) }

        sqlite3_bind_text(stmt, 1, (messageId as NSString).utf8String, -1, nil)
        if let sudoId = sudoId { sqlite3_bind_text(stmt, 2, (sudoId as NSString).utf8String, -1, nil) } else { sqlite3_bind_null(stmt, 2) }
        sqlite3_bind_text(stmt, 3, (emailAddressId as NSString).utf8String, -1, nil)
        if let content = content {
            _ = content.withUnsafeBytes { sqlite3_bind_blob(stmt, 4, $0.baseAddress, Int32(content.count), nil) }
        } else { sqlite3_bind_null(stmt, 4) }
        if let fsPath = fsPath { sqlite3_bind_text(stmt, 5, (fsPath as NSString).utf8String, -1, nil) } else { sqlite3_bind_null(stmt, 5) }
        if let contentEncoding = contentEncoding { sqlite3_bind_text(stmt, 6, (contentEncoding as NSString).utf8String, -1, nil) } else { sqlite3_bind_null(stmt, 6) }
        sqlite3_bind_int64(stmt, 7, sizeBytes)
        sqlite3_bind_int64(stmt, 8, lastAccessedAt)

        if sqlite3_step(stmt) != SQLITE_DONE {
            logger.error("Cache: failed to insert entry: \(dbErrorMessage())")
        }
    }

    /// Delete a single entry by message ID, including its filesystem blob if applicable.
    private func deleteEntry(messageId: String) {
        // First check if there's a filesystem file to delete
        let selectSql = "SELECT \(CacheTable.Column.fsPath) FROM \(CacheTable.name) WHERE \(CacheTable.Column.messageId) = ?"
        var selectStmt: OpaquePointer?
        if sqlite3_prepare_v2(db, selectSql, -1, &selectStmt, nil) == SQLITE_OK {
            sqlite3_bind_text(selectStmt, 1, (messageId as NSString).utf8String, -1, nil)
            if sqlite3_step(selectStmt) == SQLITE_ROW, let cString = sqlite3_column_text(selectStmt, 0) {
                try? FileManager.default.removeItem(atPath: String(cString: cString))
            }
            sqlite3_finalize(selectStmt)
        }

        // Delete the database row
        let deleteSql = "DELETE FROM \(CacheTable.name) WHERE \(CacheTable.Column.messageId) = ?"
        var deleteStmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, deleteSql, -1, &deleteStmt, nil) == SQLITE_OK else {
            logger.error("Cache: failed to prepare delete: \(dbErrorMessage())")
            return
        }
        defer { sqlite3_finalize(deleteStmt) }
        sqlite3_bind_text(deleteStmt, 1, (messageId as NSString).utf8String, -1, nil)
        if sqlite3_step(deleteStmt) != SQLITE_DONE {
            logger.error("Cache: failed to delete entry: \(dbErrorMessage())")
        }
    }

    /// Delete all entries matching a column value, including filesystem blobs.
    private func deleteEntriesBy(column: String, value: String) {
        // Delete filesystem blobs for matching entries
        let selectSql = "SELECT \(CacheTable.Column.fsPath) FROM \(CacheTable.name) WHERE \(column) = ? AND \(CacheTable.Column.fsPath) IS NOT NULL"
        var selectStmt: OpaquePointer?
        if sqlite3_prepare_v2(db, selectSql, -1, &selectStmt, nil) == SQLITE_OK {
            sqlite3_bind_text(selectStmt, 1, (value as NSString).utf8String, -1, nil)
            while sqlite3_step(selectStmt) == SQLITE_ROW {
                if let cString = sqlite3_column_text(selectStmt, 0) {
                    try? FileManager.default.removeItem(atPath: String(cString: cString))
                }
            }
            sqlite3_finalize(selectStmt)
        }

        // Delete the database rows
        let deleteSql = "DELETE FROM \(CacheTable.name) WHERE \(column) = ?"
        var deleteStmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, deleteSql, -1, &deleteStmt, nil) == SQLITE_OK else {
            logger.error("Cache: failed to prepare delete: \(dbErrorMessage())")
            return
        }
        defer { sqlite3_finalize(deleteStmt) }
        sqlite3_bind_text(deleteStmt, 1, (value as NSString).utf8String, -1, nil)
        if sqlite3_step(deleteStmt) != SQLITE_DONE {
            logger.error("Cache: failed to execute delete: \(dbErrorMessage())")
        }
    }

    /// Delete all entries from the cache, including all filesystem blobs.
    private func deleteAllEntries() {
        // Delete all filesystem blobs
        let selectSql = "SELECT \(CacheTable.Column.fsPath) FROM \(CacheTable.name) WHERE \(CacheTable.Column.fsPath) IS NOT NULL"
        var selectStmt: OpaquePointer?
        if sqlite3_prepare_v2(db, selectSql, -1, &selectStmt, nil) == SQLITE_OK {
            while sqlite3_step(selectStmt) == SQLITE_ROW {
                if let cString = sqlite3_column_text(selectStmt, 0) {
                    try? FileManager.default.removeItem(atPath: String(cString: cString))
                }
            }
            sqlite3_finalize(selectStmt)
        }

        // Delete all rows
        if sqlite3_exec(db, "DELETE FROM \(CacheTable.name)", nil, nil, nil) != SQLITE_OK {
            logger.error("Cache: failed to delete all entries: \(dbErrorMessage())")
        }
    }

    // MARK: - LRU Eviction

    /// Evict LRU entries until there is enough space for a new entry of the given size.
    private func evictIfNeeded(forNewEntrySize newSize: Int64) {
        var currentTotal = totalCachedSize()
        while (currentTotal + newSize) > cacheSizeLimitBytes {
            let victims = queryLRUEntries(limit: 10)
            if victims.isEmpty { break }
            for victim in victims {
                if let fsPath = victim.fsPath { try? FileManager.default.removeItem(atPath: fsPath) }
                executeDeleteByMessageId(victim.messageId)
                currentTotal -= victim.sizeBytes
                if (currentTotal + newSize) <= cacheSizeLimitBytes { break }
            }
        }
    }

    /// Evict LRU entries until total cached size is within the current cache size limit.
    private func evictToFitLimit() {
        var currentTotal = totalCachedSize()
        while currentTotal > cacheSizeLimitBytes {
            let victims = queryLRUEntries(limit: 10)
            if victims.isEmpty { break }
            for victim in victims {
                if let fsPath = victim.fsPath { try? FileManager.default.removeItem(atPath: fsPath) }
                executeDeleteByMessageId(victim.messageId)
                currentTotal -= victim.sizeBytes
                if currentTotal <= cacheSizeLimitBytes { break }
            }
        }
    }

    /// Query the total size of all cached entries.
    private func totalCachedSize() -> Int64 {
        let sql = "SELECT COALESCE(SUM(\(CacheTable.Column.sizeBytes)), 0) FROM \(CacheTable.name)"
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
            logger.error("Cache: failed to query total size: \(dbErrorMessage())")
            return 0
        }
        defer { sqlite3_finalize(stmt) }
        return sqlite3_step(stmt) == SQLITE_ROW ? sqlite3_column_int64(stmt, 0) : 0
    }

    /// Query the N least recently used entries.
    private func queryLRUEntries(limit: Int) -> [CacheRow] {
        let sql = "SELECT \(Self.allColumns) FROM \(CacheTable.name) ORDER BY \(CacheTable.Column.lastAccessedAt) ASC LIMIT ?"
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
            logger.error("Cache: failed to prepare LRU query: \(dbErrorMessage())")
            return []
        }
        defer { sqlite3_finalize(stmt) }
        sqlite3_bind_int(stmt, 1, Int32(limit))
        var rows: [CacheRow] = []
        while sqlite3_step(stmt) == SQLITE_ROW {
            if let row = rowFromStatement(stmt) { rows.append(row) }
        }
        return rows
    }

    /// Delete a row by message_id without checking for filesystem files (used during eviction where files are already handled).
    private func executeDeleteByMessageId(_ messageId: String) {
        let sql = "DELETE FROM \(CacheTable.name) WHERE \(CacheTable.Column.messageId) = ?"
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else { return }
        defer { sqlite3_finalize(stmt) }
        sqlite3_bind_text(stmt, 1, (messageId as NSString).utf8String, -1, nil)
        sqlite3_step(stmt)
    }

    // MARK: - Utilities

    /// Instance method to persist cache size limit (delegates to static version).
    private func persistCacheSizeLimit(_ bytes: Int64) {
        guard let db = db else { return }
        Self.persistCacheSizeLimit(db: db, bytes: bytes, logger: logger)
    }

    /// Returns the filesystem path for a large-message blob.
    private func blobFilePath(for messageId: String) -> String {
        return (blobStoragePath as NSString).appendingPathComponent("\(messageId).blob")
    }

    /// Returns the current timestamp in milliseconds since epoch.
    private func currentTimestampMillis() -> Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }

    /// Returns the last SQLite error message.
    private func dbErrorMessage() -> String {
        if let db = db { return String(cString: sqlite3_errmsg(db)) }
        return "database not open"
    }

    /// Parse a CacheRow from the current row of a prepared statement.
    /// Column order must match `allColumns`.
    private func rowFromStatement(_ stmt: OpaquePointer?) -> CacheRow? {
        guard let stmt = stmt else { return nil }
        guard let messageIdCStr = sqlite3_column_text(stmt, 0) else { return nil }
        let messageId = String(cString: messageIdCStr)
        let sudoId: String? = sqlite3_column_text(stmt, 1).map { String(cString: $0) }
        guard let emailAddressIdCStr = sqlite3_column_text(stmt, 2) else { return nil }
        let emailAddressId = String(cString: emailAddressIdCStr)

        let content: Data?
        if sqlite3_column_type(stmt, 3) != SQLITE_NULL,
           let blobPointer = sqlite3_column_blob(stmt, 3) {
            let blobSize = sqlite3_column_bytes(stmt, 3)
            content = blobSize > 0 ? Data(bytes: blobPointer, count: Int(blobSize)) : nil
        } else {
            content = nil
        }

        let fsPath: String? = sqlite3_column_text(stmt, 4).map { String(cString: $0) }
        let contentEncoding: String? = sqlite3_column_text(stmt, 5).map { String(cString: $0) }
        let sizeBytes = sqlite3_column_int64(stmt, 6)
        let lastAccessedAt = sqlite3_column_int64(stmt, 7)

        return CacheRow(
            messageId: messageId, sudoId: sudoId, emailAddressId: emailAddressId,
            content: content, fsPath: fsPath, contentEncoding: contentEncoding,
            sizeBytes: sizeBytes, lastAccessedAt: lastAccessedAt
        )
    }
}
