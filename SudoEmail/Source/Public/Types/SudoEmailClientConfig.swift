//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Options for how a `DefaultSudoEmailClient` manages the key pairs that email addresses and email aliases are
/// provisioned with.
public struct SudoEmailClientConfig: Equatable, Sendable {

    // MARK: - Properties

    /// Whether every email address and email alias is provisioned with one shared key pair instead of a key pair of
    /// its own.
    ///
    /// When `true`, every email address and email alias provisioned without a `keyId` is registered with a single key
    /// pair, which the app creates by calling `SudoEmailClient.createSingletonKeysIfAbsent()` before provisioning. The
    /// client never creates it itself: provisioning without it throws `SudoEmailError.singletonKeyPairNotFound`.
    /// Deprovisioning never removes any key pair, and the singleton is never removed when a provisioning fails; only
    /// `reset()` removes it.
    ///
    /// Messages are still sealed, but every address's messages are sealed to the same key, so all of them can be read
    /// with that one key. Apps that don't need addresses kept cryptographically separate from one another can use
    /// this to keep key management and key export / import simple.
    ///
    /// When `false` (the default), each email address and email alias provisioned without a `keyId` gets a key pair of
    /// its own.
    ///
    /// Either way, a `keyId` supplied when provisioning is used instead, if `allowCallerManagedKeys` is `true`.
    public let enforceSingletonKeyPair: Bool

    /// Whether the app may supply the key pair an email address or email alias is provisioned with, through the
    /// `keyId` of `ProvisionEmailAddressInput` or `ProvisionEmailAliasInput`.
    ///
    /// When `true` (the default), the app manages the key pairs it supplies, so the client never removes a key pair
    /// when an email address is deprovisioned. Key pairs the client generated itself are still removed when the
    /// service rejects the provisioning they were generated for.
    ///
    /// When `false`, the client manages every key pair itself: provisioning with a `keyId` throws
    /// `SudoEmailError.invalidArgument`, and deprovisioning an email address removes its key pairs from the device,
    /// except a key pair another email address or email alias still uses, and the singleton key pair. Nothing is
    /// removed while `enforceSingletonKeyPair` is `true`. Email alias key pairs aren't removed on deprovision, because
    /// the service doesn't report which key pair an alias was provisioned with.
    public let allowCallerManagedKeys: Bool

    // MARK: - Lifecycle

    /// Create a client configuration.
    ///
    /// - Parameters:
    ///   - enforceSingletonKeyPair: Whether every email address and email alias shares one key pair. Defaults to
    ///     `false`.
    ///   - allowCallerManagedKeys: Whether the app may supply the key pair to provision with, which stops the client
    ///     from removing key pairs on deprovision. Defaults to `true`.
    public init(enforceSingletonKeyPair: Bool = false, allowCallerManagedKeys: Bool = true) {
        self.enforceSingletonKeyPair = enforceSingletonKeyPair
        self.allowCallerManagedKeys = allowCallerManagedKeys
    }
}
