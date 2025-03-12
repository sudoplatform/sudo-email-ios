//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SudoLogging

internal extension Logger {

    /// Logger used internally in the SudoEmail.
    static let testLogger = Logger(identifier: "Test-SudoEmail", driver: NSLogDriver(level: .debug))
}
