//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

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
    /// Indicates that the key archive imported was invalid.
    case invalidKeyArchive
    /// No key attachments were found on message body.
    case keyAttachmentsNotFound
    /// No body attachment was found on message body.
    case bodyAttachmentNotFound
    /// Email message size exceeds configured maximum.
    case messageSizeLimitExceeded(_ msg: String?)
    /// In network recipient email address not found.
    case inNetworkAddressNotFound(_ msg: String?)

    // MARK: - Service

    /// The entitlement for the email is exceeded.
    case entitlementExceeded
    /// The email address supplied could not be found.
    case addressNotFound
    /// The email folder supplied could not be found.
    case emailFolderNotFound
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
    /// Contents of an email message is of an invalid format.
    case invalidEmailContents

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
    case serviceQuotaExceeded
    case unknownTimezone
    case versionMismatch

    public var errorDescription: String? {
        switch self {
        case .accountLocked:
            return "Account is locked"
        case .addressNotFound:
            return "Email address could not be found"
        case .emailFolderNotFound:
            return "Email folder could not be found"
        case .bodyAttachmentNotFound:
            return "Body attachments could not be found"
        case .decodingError:
            return "A decoding error has occurred"
        case .emailAddressFormatValidationFailed:
            return "Input information relating to email address is invalid"
        case .emailAddressUnavailable:
            return "Email address (or id associated with address) supplied is unavailable"
        case .invalidEmailContents:
            return "Invalid email message contents"
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
        case .keyAttachmentsNotFound:
            return "Key attachments could not be found"
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
        case .serviceQuotaExceeded:
            return "Daily message quota limit exceeded"
        case .unauthorizedAddress:
            return "Unauthorized access to email address"
        case .unknownTimezone:
            return "Time zone is not known"
        case .versionMismatch:
            return "The version of the resource being updated does not match the current version"
        case let .fatalError(msg):
            return msg ?? "Unexpected API operation error"
        case .invalidKeyArchive:
            return "The imported key archive is invalid"
        case let .messageSizeLimitExceeded(msg):
            return msg ?? "Email message size exceeded"
        case let .inNetworkAddressNotFound(msg):
            return msg ?? "At least one email address does not exist in network"
        }
    }
}
