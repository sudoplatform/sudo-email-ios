//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSAppSync
import Foundation

/// Status of a `PlatformSubscriptionStatus`.
public enum PlatformSubscriptionStatus: Equatable {
    case initialized
    case connecting
    case connected
    case disconnected
    case error(Error)

    init(status: AWSAppSyncSubscriptionWatcherStatus) {
        switch status {
        case .connecting:
            self = .connecting
        case .connected:
            self = .connected
        case .disconnected:
            self = .disconnected
        case .error(let error):
            self = .error(error)
        }
    }

    // MARK: - Conformance: Equatable

    public static func == (lhs: PlatformSubscriptionStatus, rhs: PlatformSubscriptionStatus) -> Bool {
        switch (lhs, rhs) {
        case (.initialized, .initialized):
            return true
        case (.connecting, .connecting):
            return true
        case (.connected, .connected):
            return true
        case (.disconnected, .disconnected):
            return true
        case (let .error(lError), .error(let rError)):
            return String(reflecting: lError) == String(reflecting: rError)
        default:
            return false
        }
    }
}
