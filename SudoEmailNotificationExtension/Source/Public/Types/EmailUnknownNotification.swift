//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoNotificationExtension

/// Catch all notification in case new Sudo Platform Email Service notifications are emitted before an application
/// has updated its Sudo Platform Email Notification Extension SDK
public struct EmailUnknownNotification: SudoNotification, Equatable {

    // MARK: - Conformance

    /// serviceName will always be emService
    public let serviceName = Constants.serviceName

    /// Type of the unknown notification
    public let type: String
}
