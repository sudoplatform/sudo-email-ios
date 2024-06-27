//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoNotification

public class DefaultSudoEmailNotificationFilterClient: SudoNotificationFilterClient {
    
    public let serviceName = Constants.serviceName
    
    static let schema = NotificationMetaData(serviceName: Constants.serviceName, schema: [
        NotificationSchemaEntry(
            description: "Type of notification message",
            fieldName: "meta.type",
            type: "string"
        ),
        NotificationSchemaEntry(
            description: "ID of email address to match",
            fieldName: "meta.emailAddressId",
            type: "string"
        ),
        NotificationSchemaEntry(
            description: "ID of Sudo owning the email address",
            fieldName: "meta.sudoId",
            type: "string"
        ),
        NotificationSchemaEntry(
            description: "ID of folder into which message was received",
            fieldName: "meta.folderId",
            type: "string"
        ),
        NotificationSchemaEntry(
            description: "ID of key pair used to seal notification content",
            fieldName: "meta.keyId",
            type: "string"
        )
    ])

    public init() {}

    public func getSchema() -> NotificationMetaData { return DefaultSudoEmailNotificationFilterClient.schema }
}
