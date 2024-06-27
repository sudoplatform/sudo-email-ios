//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging
import SudoNotificationExtension

/// SudoNoitifiableClient implementation for decoding Sudo Platform Email service push notifications in a Notification Service Extension
public class DefaultSudoEmailNotifiableClient: SudoNotifiableClient {

    // MARK: - Properties

    private let deviceKeyWorker: DeviceKeyWorker
    private let logger: Logger
    private let decoder: JSONDecoder


    // MARK: - Lifecycle

    /// Construct a new DefaultSudoEmailNotifiableClient
    ///
    /// - Parameters:
    ///   - keyNamespace:
    ///      Namespace in which to find keys required to decrypt sealed notification bodies. Must be
    ///      the same as the namespace used by DefaultSudoEmailClient.
    ///
    public convenience init(keyNamespace: String = Constants.defaultKeyNamespace) {

        let defaultLogger = Logger.emailSDKLogger
        let defaultDeviceKeyWorker = DefaultDeviceKeyWorker(
            keyNamespace: keyNamespace,
            logger: defaultLogger
        )

        self.init(deviceKeyWorker: defaultDeviceKeyWorker, logger: defaultLogger)
    }

    /// Internal constructor to allow for provision of non-default properties for testing
    init(deviceKeyWorker: DeviceKeyWorker, logger: Logger) {
        self.decoder = JSONDecoder()
        self.deviceKeyWorker = deviceKeyWorker
        self.logger = logger
    }

    // MARK: - Conformance: SudoNotifiableClient

    public let serviceName = Constants.serviceName

    /// Decrypt and decode a Sudo Platform Email service push notification
    ///
    /// - Parameters:
    ///   - data: The payload as returned by DefaultSudoNotificationClient's extractData method
    ///
    public func decode(data: String) -> any SudoNotification {
        var type: String = Constants.serviceName

        let sealedNotification: SealedNotification
        do {
            sealedNotification = try decoder.decode(SealedNotification.self, from: data.data(using: .utf8)!)
        }
        catch {
            logger.error("Unable to decode data as SealedNotification: \(error.localizedDescription)")
            return EmailUnknownNotification(type: type)
        }
        type = sealedNotification.type

        let unsealed: String
        do {
            unsealed = try deviceKeyWorker.unsealString(sealedNotification.sealed, withKeyId: sealedNotification.keyId, algorithm: sealedNotification.algorithm)
        }
        catch {
            logger.error("Unable to decrypt sealed data \(error.localizedDescription)")
            return EmailUnknownNotification(type: type)
        }

        guard let emailServiceNotification = try? decoder.decode(EmailServiceNotification.self, from: unsealed.data(using: .utf8)!) else {
            logger.error("Unable to decode unsealed data \(unsealed)")
            return EmailUnknownNotification(type: type)
        }

        return emailServiceNotification.toSudoNotification()
    }
}
