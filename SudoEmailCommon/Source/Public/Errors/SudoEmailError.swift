//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Errors that occur in SudoEmail.
public enum SudoEmailError: Error, Equatable, LocalizedError, Sendable {

    // MARK: - Client

    /// Configuration supplied to `DefaultSudoEmailClient` is invalid, or doesn't support the operation called.
    case invalidConfig
    /// User is not signed in.
    case notSignedIn
    /// Email message RFC822 is not available.
    case noEmailMessageRFC822Available
    /// Device cryptographic key not found
    case keyNotFound
    /// The client enforces a singleton key pair, but it isn't on this device. Create it with
    /// `createSingletonKeysIfAbsent()`, or import the user's key backup.
    case singletonKeyPairNotFound
    /// Indicates that the key archive imported was invalid.
    case invalidKeyArchive
    /// The key archive contains keys this client can't import, usually because they were exported under a different
    /// key namespace, for example by another app or platform. Nothing was imported and the device's keys are
    /// unchanged. The associated value describes the keys that couldn't be imported.
    case keyArchiveNotImportable(_ cause: String?)
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
    /// The email alias supplied could not be found
    case emailAliasNotFound
    /// The email alias address supplied is already provisioned.
    case emailAliasAlreadyExists
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
    case limitExceeded(_ msg: String?)
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
        case .emailAliasNotFound:
            return "Email alias could not be found"
        case .emailAliasAlreadyExists:
            return "Email alias already exists"
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
            return "The client's configuration is invalid or doesn't support this operation. "
                + "Check that a valid configuration file is included in the bundle, and the SudoEmailClientConfig the client was created with"
        case .invalidEmailAddressDomain:
            return "Email address domain is not supported"
        case .invalidToken:
            return "An invalid token error has occurred"
        case .keyAttachmentsNotFound:
            return "Key attachments could not be found"
        case .keyNotFound:
            return "Key not found"
        case .singletonKeyPairNotFound:
            return "The singleton key pair is not on this device"
        case let .limitExceeded(msg):
            return msg ?? "API limit exceeded"
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
        case .keyArchiveNotImportable:
            return "The key backup contains keys this app can't import. No keys were changed."
        case let .messageSizeLimitExceeded(msg):
            return msg ?? "Email message size exceeded"
        case let .inNetworkAddressNotFound(msg):
            return msg ?? "At least one email address does not exist in network"
        }
    }
}
