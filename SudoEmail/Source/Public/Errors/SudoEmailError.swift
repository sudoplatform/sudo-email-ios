//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoOperations
import AWSAppSync

/// Errors that occur in SudoEmail.
public enum SudoEmailError: Error, Equatable, LocalizedError {

    // MARK: - Client

    /// Configuration supplied to `DefaultSudoEmailClient` is invalid.
    case invalidConfig
    /// User is not signed in.
    case notSignedIn
    /// Email message RFC822 is not available.
    case noEmailMessageRFC822Available

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

    // MARK: - SudoPlatformError

    /**
      * This section contains wrapped erros from `SudoPlatformError`.
     */

    case serviceError
    case decodingError
    case environmentError
    case policyFailed
    case invalidTokenError
    case accountLockedError
    case identityInsufficient
    case identityNotVerified
    case internalError(_ cause: String?)

    // MARK: - Lifecycle

    /// Initialize a `SudoEmailError` from a `GraphQLError`.
    ///
    /// If the GraphQLError is unsupported, `nil` will be returned instead.
    init?(graphQLError error: GraphQLError) {
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
        default:
            return nil
        }
    }

    /// Initialize a `SudoEmailError` from a `SudoPlatformError`.
    init(platformError error: SudoPlatformError) {
        switch error {
        case .serviceError:
            self = .serviceError
        case .decodingError:
            self = .decodingError
        case .environmentError:
            self = .environmentError
        case .policyFailed:
            self = .policyFailed
        case .invalidTokenError:
            self = .invalidTokenError
        case .accountLockedError:
            self = .accountLockedError
        case .identityInsufficient:
            self = .identityInsufficient
        case .identityNotVerified:
            self = .identityNotVerified
        case let .internalError(cause):
            self = .internalError(cause)
        }
    }

    public var errorDescription: String? {
        switch self {
        case .invalidConfig:
            return L10n.Email.Errors.invalidConfig
        case .notSignedIn:
            return L10n.Email.Errors.notSignedIn
        case .noEmailMessageRFC822Available:
            return L10n.Email.Errors.noEmailMessageRFC822Available
        case .addressNotFound:
            return L10n.Email.Errors.addressNotFound
        case .emailMessageNotFound:
            return L10n.Email.Errors.emailMessageNotFound
        case .unauthorizedAddress:
            return L10n.Email.Errors.unauthorizedAddress
        case .invalidEmailAddressDomain:
            return L10n.Email.Errors.invalidEmailAddressDomain
        case .emailAddressFormatValidationFailed:
            return L10n.Email.Errors.emailAddressFormatValidationFailed
        case .entitlementExceeded:
            return L10n.Email.Errors.entitlementExceeded
        case .serviceError:
            return L10n.Email.Errors.serviceError
        case .decodingError:
            return L10n.Email.Errors.decodingError
        case .environmentError:
            return L10n.Email.Errors.environmentError
        case .policyFailed:
            return L10n.Email.Errors.policyFailed
        case .invalidTokenError:
            return L10n.Email.Errors.invalidTokenError
        case .accountLockedError:
            return L10n.Email.Errors.accountLockedError
        case .identityInsufficient:
            return L10n.Email.Errors.identityInsufficient
        case .identityNotVerified:
            return L10n.Email.Errors.identityNotVerified
        case .emailAddressUnavailable:
            return L10n.Email.Errors.emailAddressUnavailable
        case let .internalError(cause):
            return cause ?? "Internal Error"
        }
    }

}
