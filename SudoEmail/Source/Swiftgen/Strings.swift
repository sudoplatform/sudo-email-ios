// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen
// Custom template in `swiftgen/strings/template.stencil`

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name

internal enum L10n {

    // MARK: - email
    internal enum Email {
      // MARK: - errors
      internal enum Errors {
        internal static let accountLockedError = L10n.tr("Localizable", "email.errors.accountLockedError")
        internal static let addressNotFound = L10n.tr("Localizable", "email.errors.addressNotFound")
        internal static let decodingError = L10n.tr("Localizable", "email.errors.decodingError")
        internal static let emailAddressFormatValidationFailed = L10n.tr("Localizable", "email.errors.emailAddressFormatValidationFailed")
        internal static let emailAddressUnavailable = L10n.tr("Localizable", "email.errors.emailAddressUnavailable")
        internal static let emailMessageNotFound = L10n.tr("Localizable", "email.errors.emailMessageNotFound")
        internal static let entitlementExceeded = L10n.tr("Localizable", "email.errors.entitlementExceeded")
        internal static let environmentError = L10n.tr("Localizable", "email.errors.environmentError")
        internal static let identityInsufficient = L10n.tr("Localizable", "email.errors.identityInsufficient")
        internal static let identityNotVerified = L10n.tr("Localizable", "email.errors.identityNotVerified")
        internal static let invalidArgument = L10n.tr("Localizable", "email.errors.invalidArgument")
        internal static let invalidConfig = L10n.tr("Localizable", "email.errors.invalidConfig")
        internal static let invalidEmailAddressDomain = L10n.tr("Localizable", "email.errors.invalidEmailAddressDomain")
        internal static let invalidTokenError = L10n.tr("Localizable", "email.errors.invalidTokenError")
        internal static let noEmailMessageRFC822Available = L10n.tr("Localizable", "email.errors.noEmailMessageRFC822Available")
        internal static let notSignedIn = L10n.tr("Localizable", "email.errors.notSignedIn")
        internal static let policyFailed = L10n.tr("Localizable", "email.errors.policyFailed")
        internal static let serviceError = L10n.tr("Localizable", "email.errors.serviceError")
        internal static let unauthorizedAddress = L10n.tr("Localizable", "email.errors.unauthorizedAddress")
        internal static let unknownTimezone = L10n.tr("Localizable", "email.errors.unknownTimezone")
      }
    }
}

// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: .sdkBundle, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
