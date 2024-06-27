//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public final class Constants {

    /// Service name that identifies Sudo Platform Email service. Corresponds to:
    /// * the service name specified in the sudoplatformconfig.json client configuration file
    ///   identifying Email service specific configuration
    /// * the service name specified in push notifications identifying the source of the notification
    public static let serviceName = "emService"

    /// Default namespace to store keys in a SudoKeyManager. DefaultSudoEmailClient and DefaultSudoEmailNotificationClient must
    /// share the same key namespace in order for encrypted notification bodies to be able to be decrypted by a notification extension
    /// DefaultSudoEmailNotificationClient
    public static let defaultKeyNamespace = "com.sudoplatform.email"
}
