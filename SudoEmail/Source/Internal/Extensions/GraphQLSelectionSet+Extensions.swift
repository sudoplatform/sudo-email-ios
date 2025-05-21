//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SudoApiClient

/// Note: there is a bug with the Amplify codegen types where enum properties cannot be accessed directly or it will cause a crash.
/// These extension methods have been added to provide an alternate way to fetch the enum properties in the short term
/// until the bug is fixed.
/// https://github.com/aws-amplify/amplify-swift/issues/3953
extension GraphQLSelectionSet {

    // MARK: - Helpers

    func getEnumValue<T: GraphQLEnum>(_ type: T.Type) -> T {
        if let typedValue = snapshot[type.key] as? T {
            return typedValue
        } else if let rawValue = snapshot[type.key] as? T.RawValue {
            return T(rawValue: rawValue) ?? type.getDefaultValue(from: rawValue)
        } else {
            return type.getDefaultValue(from: nil)
        }
    }

    func getOptionalEnumValue<T: GraphQLEnum>(_ type: T.Type) -> T? {
        if let typedValue = snapshot[type.key] as? T {
            return typedValue
        } else if let rawValue = snapshot[type.key] as? T.RawValue {
            return T(rawValue: rawValue) ?? type.getDefaultValue(from: rawValue)
        } else {
            return nil
        }
    }

    func getDoubleOptionalEnumValue<T: GraphQLEnum>(_ type: T.Type) -> T? {
        if let typedValue = snapshot[type.key] as? T {
            return typedValue
        }
        guard let optionalRawValue = snapshot[type.key] as? T.RawValue? else {
            return nil
        }
        guard let rawValue = optionalRawValue else {
            return nil
        }
        guard let value = T(rawValue: rawValue) else {
            return type.getDefaultValue(from: rawValue)
        }
        return value
    }

    func getEnumArrayValue<T: GraphQLEnum>(_ type: T.Type) -> [T] {
        guard let rawValues = snapshot[type.key] as? [T.RawValue] else {
            return []
        }
        return rawValues.map { T(rawValue: $0) ?? type.getDefaultValue(from: $0) }
    }

    // MARK: - Getters

    func getHashAlgorithm() -> GraphQL.BlockedAddressHashAlgorithm {
        getEnumValue(GraphQL.BlockedAddressHashAlgorithm.self)
    }

    func getBlockedAddressAction() -> GraphQL.BlockedAddressAction? {
        getOptionalEnumValue(GraphQL.BlockedAddressAction.self)
    }

    func getBlockedAddressesStatus() -> GraphQL.UpdateBlockedAddressesStatus {
        getEnumValue(GraphQL.UpdateBlockedAddressesStatus.self)
    }

    func getKeyFormat() -> GraphQL.KeyFormat {
        getEnumValue(GraphQL.KeyFormat.self)
    }

    func getOptionalKeyFormat() -> GraphQL.KeyFormat? {
        getOptionalEnumValue(GraphQL.KeyFormat.self)
    }

    func getDoubleOptionalKeyFormat() -> GraphQL.KeyFormat? {
        getDoubleOptionalEnumValue(GraphQL.KeyFormat.self)
    }

    func getEmailMessageDirection() -> GraphQL.EmailMessageDirection {
        getEnumValue(GraphQL.EmailMessageDirection.self)
    }

    func getEmailMessageState() -> GraphQL.EmailMessageState {
        getEnumValue(GraphQL.EmailMessageState.self)
    }

    func getEncryptionStatus() -> GraphQL.EmailMessageEncryptionStatus? {
        getOptionalEnumValue(GraphQL.EmailMessageEncryptionStatus.self)
    }

    func getUpdateEmailMessagesStatus() -> GraphQL.UpdateEmailMessagesStatus {
        getEnumValue(GraphQL.UpdateEmailMessagesStatus.self)
    }

    func getSortOrder() -> GraphQL.SortOrder? {
        getDoubleOptionalEnumValue(GraphQL.SortOrder.self)
    }

    func getScheduledDraftMessageState() -> GraphQL.ScheduledDraftMessageState {
        getEnumValue(GraphQL.ScheduledDraftMessageState.self)
    }
}

protocol GraphQLEnum: RawRepresentable {
    static var key: String { get }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self
}

extension GraphQL.BlockedAddressHashAlgorithm: GraphQLEnum {
    static var key: String { "hashAlgorithm" }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self {
        .unknown(rawValue ?? "")
    }
}

extension GraphQL.BlockedAddressAction: GraphQLEnum {
    static var key: String { "action" }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self {
        .unknown(rawValue ?? "")
    }
}

extension GraphQL.UpdateBlockedAddressesStatus: GraphQLEnum {
    static var key: String { "status" }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self {
        .unknown(rawValue ?? "")
    }
}

extension GraphQL.KeyFormat: GraphQLEnum {
    static var key: String { "keyFormat" }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self {
        .unknown(rawValue ?? "")
    }
}

extension GraphQL.EmailMessageDirection: GraphQLEnum {
    static var key: String { "direction" }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self {
        .unknown(rawValue ?? "")
    }
}

extension GraphQL.EmailMessageState: GraphQLEnum {
    static var key: String { "state" }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self {
        .unknown(rawValue ?? "")
    }
}

extension GraphQL.EmailMessageEncryptionStatus: GraphQLEnum {
    static var key: String { "encryptionStatus" }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self {
        .unknown(rawValue ?? "")
    }
}

extension GraphQL.UpdateEmailMessagesStatus: GraphQLEnum {
    static var key: String { "status" }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self {
        .unknown(rawValue ?? "")
    }
}

extension GraphQL.SortOrder: GraphQLEnum {
    static var key: String { "status" }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self {
        .unknown(rawValue ?? "")
    }
}

extension GraphQL.ScheduledDraftMessageState: GraphQLEnum {
    static var key: String { "state" }
    static func getDefaultValue(from rawValue: Self.RawValue?) -> Self {
        .unknown(rawValue ?? "")
    }
}
