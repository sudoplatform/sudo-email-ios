//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform email service configuration data to / from the Core/Entity level of the SDK.
struct EmailConfigurationDataEntityTransformer {

    /// Transform the success result of `GetEmailConfigurationDataQuery` from the service to an `EmailConfigurationDataEntity`.
    func transform(
        _ graphQLConfigurationData: GraphQL.GetEmailConfigQuery.Data.GetEmailConfig
    ) throws -> EmailConfigurationDataEntity {
        return EmailConfigurationDataEntity(
            deleteEmailMessagesLimit: graphQLConfigurationData.deleteEmailMessagesLimit,
            updateEmailMessagesLimit: graphQLConfigurationData.updateEmailMessagesLimit,
            emailMessageMaxInboundMessageSize: graphQLConfigurationData.emailMessageMaxInboundMessageSize,
            emailMessageMaxOutboundMessageSize: graphQLConfigurationData.emailMessageMaxOutboundMessageSize
        )
    }

    /// Transform an `EmailConfigurationDataEntity` to a `ConfigurationData`
    func transform(_ emailConfigurationDataEntity: EmailConfigurationDataEntity) -> ConfigurationData {
        return ConfigurationData(
            deleteEmailMessagesLimit: emailConfigurationDataEntity.deleteEmailMessagesLimit,
            updateEmailMessagesLimit: emailConfigurationDataEntity.updateEmailMessagesLimit,
            emailMessageMaxInboundMessageSize: emailConfigurationDataEntity.emailMessageMaxInboundMessageSize,
            emailMessageMaxOutboundMessageSize: emailConfigurationDataEntity.emailMessageMaxOutboundMessageSize
        )
    }
}
