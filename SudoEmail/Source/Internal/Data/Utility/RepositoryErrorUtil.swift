//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoApiClient
import SudoLogging

enum RepositoryErrorUtil {
    public static func processError(error: Error, logger: Logger) throws {
        switch error {
        case ApiOperationError.graphQLError(let cause):
            guard let sudoEmailError = SudoEmailError(graphQLError: cause) else {
                logger.error("Unexpected error: \(String(describing: error))")
                throw SudoEmailError.internalError("Unexpected error: \(error)")
            }
            throw sudoEmailError
        case ApiOperationError.notSignedIn:
            logger.error("User not logged in")
            throw SudoEmailError.notSignedIn
        default:
            logger.error("Unexpected error: \(String(describing: error))")
            throw SudoEmailError.internalError("Unexpected error: \(error)")
        }
    }
}
