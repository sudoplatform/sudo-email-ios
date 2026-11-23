//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SudoApiClient

extension SudoEmailError {

    /// Whether an error from `SudoApiClient` proves the service did not carry out the request.
    ///
    /// Decided from the raw error, before `fromApiOperationError(error:)` maps it. Only typed failures qualify: those
    /// `SudoApiClient` classifies itself, and GraphQL errors whose `errorType` is a service rejection. Anything that
    /// could follow a request the service accepted (a transport failure, an internal, environment or unclassified
    /// service error) doesn't, so callers keep state such as a provisioning key rather than discard it for an email
    /// address that may exist.
    ///
    /// - Parameter error: The error thrown by `SudoApiClient`, before mapping.
    /// - Returns: `true` if the service, or the client before sending, refused the request.
    static func isDefinitiveRejection(_ error: Error) -> Bool {
        guard let apiError = error as? ApiOperationError else {
            return false
        }
        switch apiError {
        case .notSignedIn,
             .notAuthorized,
             .insufficientEntitlements,
             .invalidArgument,
             .invalidRequest,
             .limitExceeded,
             .rateLimitExceeded,
             .accountLocked,
             .versionMismatch:
            return true
        case .graphQLError(let cause):
            guard let graphQLError = cause as? GraphQLError, let rejection = SudoEmailError(graphQLError: graphQLError) else {
                return false
            }
            switch rejection {
            case .serviceError, .environmentError:
                return false
            default:
                return true
            }
        default:
            return false
        }
    }
}
