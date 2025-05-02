//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SudoApiClient

extension SudoEmailError {
    // MARK: - Lifecycle

    /// Initialize a `SudoEmailError` from a `GraphQLError`.
    ///
    /// If the GraphQLError is unsupported, `nil` will be returned instead.
    init?(graphQLError error: GraphQLError) { // swiftlint:disable:this cyclomatic_complexity
        guard let errorType = error.extensions?["errorType"]?.stringValue else {
            return nil
        }
        switch errorType {
        case "sudoplatform.email.AddressNotFound":
            self = .addressNotFound
        case "sudoplatform.email.EmailFolderNotFound":
            self = .emailFolderNotFound
        case "sudoplatform.email.EmailMessageNotFound":
            self = .emailMessageNotFound
        case "sudoplatform.email.EntitlementExceededError":
            self = .entitlementExceeded
        case "sudoplatform.email.UnauthorizedAddress":
            self = .unauthorizedAddress
        case "sudoplatform.email.InvalidEmailDomain":
            self = .invalidEmailAddressDomain
        case "sudoplatform.email.EmailValidation":
            self = .emailAddressFormatValidationFailed
        case "sudoplatform.email.AddressUnavailable":
            self = .emailAddressUnavailable
        case "sudoplatform.email.InvalidEmailContents":
            self = .invalidEmailContents
        case "sudoplatform.AccountLockedError":
            self = .accountLocked
        case "sudoplatform.DecodingError":
            self = .decodingError
        case "sudoplatform.EnvironmentError":
            self = .environmentError
        case "sudoplatform.IdentityVerificationInsufficientError":
            self = .identityInsufficient
        case "sudoplatform.IdentityVerificationNotVerifiedError":
            self = .identityNotVerified
        case "sudoplatform.InsufficientEntitlementsError":
            self = .insufficientEntitlements
        case "sudoplatform.InvalidArgumentError":
            let msg = error.message.isEmpty ? nil : error.message
            self = .invalidArgument(msg)
        case "sudoplatform.InvalidTokenError":
            self = .invalidToken
        case "sudoplatform.LimitExceededError":
            let msg = error.message.isEmpty ? nil : error.message
            self = .limitExceeded(msg)
        case "sudoplatform.NoEntitlementsError":
            self = .noEntitlements
        case "sudoplatform.PolicyFailed":
            self = .policyFailed
        case "sudoplatform.ServiceError":
            self = .serviceError
        case "sudoplatform.ServiceQuotaExceededError":
            self = .serviceQuotaExceeded
        case "sudoplatform.VersionMismatchError":
            self = .versionMismatch
        case "sudoplatform.UnknownTimezoneError":
            self = .unknownTimezone
        default:
            return nil
        }
    }

    enum Constants {
        static let errorType = "errorType"
    }

    static func fromApiOperationError(error: Error) -> SudoEmailError {
        if let sudoEmailError = error as? SudoEmailError {
            return sudoEmailError
        }
        switch error {
        case ApiOperationError.accountLocked:
            return .accountLocked
        case ApiOperationError.notSignedIn:
            return .notSignedIn
        case ApiOperationError.limitExceeded:
            return .limitExceeded(nil)
        case ApiOperationError.insufficientEntitlements:
            return .insufficientEntitlements
        case ApiOperationError.invalidArgument:
            return .invalidArgument(nil)
        case ApiOperationError.serviceError:
            return .serviceError
        case ApiOperationError.versionMismatch:
            return .versionMismatch
        case ApiOperationError.graphQLError(let underlyingError):
            if let graphQLError = underlyingError as? GraphQLError, let sudoEmailError = SudoEmailError(graphQLError: graphQLError) {
                return sudoEmailError
            }
            return .internalError("Unexpected API operation error: \(error))")
        default:
            return .internalError("Unexpected error: \(error)")
        }
    }
}
