//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync
import SudoApiClient

/// Errors that occur in SudoEmail.
public enum SudoEmailError: Error, Equatable, LocalizedError {

    // MARK: - Client

    /// Configuration supplied to `DefaultSudoEmailClient` is invalid.
    case invalidConfig
    /// User is not signed in.
    case notSignedIn
    /// Email message RFC822 is not available.
    case noEmailMessageRFC822Available
    /// Device cryptographic key not found
    case keyNotFound

    // MARK: - Service

    /// The entitlement for the email is exceeded.
    case entitlementExceeded
    /// The email address supplied could not be found.
    case addressNotFound
    /// The email message supplied could not be found.
    case emailMessageNotFound
    /// The email address supplied is not authorized to perform the operation.
    case unauthorizedAddress
    /// The email address domain specified is invalid.
    case invalidEmailAddressDomain
    /// Input information relating to email address is invalid.
    case emailAddressFormatValidationFailed
    /// Email address (or id associated with address) supplied is unavailable.
    case emailAddressUnavailable

    // MARK: - Service

    case accountLocked
    case decodingError
    case environmentError
    case fatalError(_ msg: String?)
    case identityInsufficient
    case identityNotVerified
    case invalidToken
    case insufficientEntitlements
    case internalError(_ cause: String?)
    case invalidArgument(_ msg: String?)
    case limitExceeded
    case noEntitlements
    case policyFailed
    case serviceError
    case unknownTimezone
    case versionMismatch

    // MARK: - Lifecycle

    /// Initialize a `SudoEmailError` from a `GraphQLError`.
    ///
    /// If the GraphQLError is unsupported, `nil` will be returned instead.
    init?(graphQLError error: GraphQLError) { // swiftlint:disable:this cyclomatic_complexity
        guard let errorType = error["errorType"] as? String else {
            return nil
        }
        switch errorType {
        case "sudoplatform.email.AddressNotFound":
            self = .addressNotFound
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
            self = .limitExceeded
        case "sudoplatform.NoEntitlementsError":
            self = .noEntitlements
        case "sudoplatform.PolicyFailed":
            self = .policyFailed
        case "sudoplatform.ServiceError":
            self = .serviceError
        case "sudoplatform.VersionMismatchError":
            self = .versionMismatch
        case "sudoplatform.UnknownTimezoneError":
            self = .unknownTimezone

        default:
            return nil
        }
    }

    public var errorDescription: String? {
        switch self {
        case .accountLocked:
            return "Account is locked"
        case .addressNotFound:
            return "Email address could not be found"
        case .decodingError:
            return "A decoding error has occurred"
        case .emailAddressFormatValidationFailed:
            return "Input information relating to email address is invalid"
        case .emailAddressUnavailable:
            return "Email address (or id associated with address) supplied is unavailable"
        case .emailMessageNotFound:
            return "Email message could not be found"
        case .entitlementExceeded:
            return "Entitlement exceeded"
        case .environmentError:
            return "An environment error has occurred"
        case .identityInsufficient:
            return "Identity is insufficient"
        case .identityNotVerified:
            return "Identity is not verified"
        case .insufficientEntitlements:
            return "Insufficient entitlements for requested operation"
        case let .internalError(cause):
            return cause ?? "Internal Error"
        case let .invalidArgument(msg):
            return msg ?? "An invalid argument has been provided"
        case .invalidConfig:
            return "There was an issue with the configuration file. Please check that a valid configuration is included in the bundle"
        case .invalidEmailAddressDomain:
            return "Email address domain is not supported"
        case .invalidToken:
            return "An invalid token error has occurred"
        case .keyNotFound:
            return "Key not found"
        case .limitExceeded:
            return "API limit exceeded"
        case .noEmailMessageRFC822Available:
            return "No RFC822 data is available for this message"
        case .noEntitlements:
            return "User has no entitlements associated with them"
        case .notSignedIn:
            return "Not signed in"
        case .policyFailed:
            return "A policy has failed"
        case .serviceError:
            return "Service error has occurred"
        case .unauthorizedAddress:
            return "Unauthorized access to email address"
        case .unknownTimezone:
            return "Time zone is not known"
        case .versionMismatch:
            return "The version of the resource being updated does not match the current version"
        case let .fatalError(msg):
            return msg ?? "Unexpected API operation error"
        }
    }
}

extension SudoEmailError {

    struct Constants {
        static let errorType = "errorType"
    }

    static func fromApiOperationError(error: Error) -> SudoEmailError {
        switch error {
        case ApiOperationError.accountLocked:
            return .accountLocked
        case ApiOperationError.notSignedIn:
            return .notSignedIn
        case ApiOperationError.limitExceeded:
            return .limitExceeded
        case ApiOperationError.insufficientEntitlements:
            return .insufficientEntitlements
        case ApiOperationError.serviceError:
            return .serviceError
        case ApiOperationError.versionMismatch:
            return .versionMismatch
        default:
            return .fatalError("Unexpected API operation error: \(error)")
        }
    }
}
