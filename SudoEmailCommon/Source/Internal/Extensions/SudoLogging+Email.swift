//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

public extension Logger {

    /// Logger used internally in the SudoEmail.
    static let emailSDKLogger = Logger(identifier: "SudoEmail", driver: NSLogDriver(level: .debug))
}
