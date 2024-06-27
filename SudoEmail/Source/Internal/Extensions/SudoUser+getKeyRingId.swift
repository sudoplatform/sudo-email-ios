//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoUser

extension SudoUserClient {
    /// Key ring service name used for the key manager initialization.
    static var keyRingServiceName: String { get { return "sudo-email" } }

    /// Get the user's key ring id. If the user is not signed in, this will fail.
    /// - Throws: `SudoEmailError.notSignedIn`.
    /// - Returns: Key ring id of the user.
    func getKeyRingId() throws -> String {
        guard let userId = try getSubject() else {
            throw SudoEmailError.notSignedIn
        }
        return "\(Self.keyRingServiceName).\(userId)"
    }

}
