//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
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
            return L10n.Email.Errors.accountLockedError
        case .addressNotFound:
            return L10n.Email.Errors.addressNotFound
        case .decodingError:
            return L10n.Email.Errors.decodingError
        case .emailAddressFormatValidationFailed:
            return L10n.Email.Errors.emailAddressFormatValidationFailed
        case .emailAddressUnavailable:
            return L10n.Email.Errors.emailAddressUnavailable
        case .emailMessageNotFound:
            return L10n.Email.Errors.emailMessageNotFound
        case .entitlementExceeded:
            return L10n.Email.Errors.entitlementExceeded
        case .environmentError:
            return L10n.Email.Errors.environmentError
        case .identityInsufficient:
            return L10n.Email.Errors.identityInsufficient
        case .identityNotVerified:
            return L10n.Email.Errors.identityNotVerified
        case .insufficientEntitlements:
            return L10n.Email.Errors.insufficientEntitlementsError
        case let .internalError(cause):
            return cause ?? "Internal Error"
        case let .invalidArgument(msg):
            return msg ?? L10n.Email.Errors.invalidArgument
        case .invalidConfig:
            return L10n.Email.Errors.invalidConfig
        case .invalidEmailAddressDomain:
            return L10n.Email.Errors.invalidEmailAddressDomain
        case .invalidToken:
            return L10n.Email.Errors.invalidTokenError
        case .keyNotFound:
            return "Key not found"
        case .limitExceeded:
            return L10n.Email.Errors.limitExceededError
        case .noEmailMessageRFC822Available:
            return L10n.Email.Errors.noEmailMessageRFC822Available
        case .noEntitlements:
            return L10n.Email.Errors.noEntitlementsError
        case .notSignedIn:
            return L10n.Email.Errors.notSignedIn
        case .policyFailed:
            return L10n.Email.Errors.policyFailed
        case .serviceError:
            return L10n.Email.Errors.serviceError
        case .unauthorizedAddress:
            return L10n.Email.Errors.unauthorizedAddress
        case .unknownTimezone:
            return L10n.Email.Errors.unknownTimezone
        case .versionMismatch:
            return L10n.Email.Errors.versionMismatch
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
