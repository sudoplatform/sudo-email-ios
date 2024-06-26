//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync

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
        case let .error(error):
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
        case (let .error(lError), let .error(rError)):
            return String(reflecting: lError) == String(reflecting: rError)
        default:
            return false
        }
    }
}
