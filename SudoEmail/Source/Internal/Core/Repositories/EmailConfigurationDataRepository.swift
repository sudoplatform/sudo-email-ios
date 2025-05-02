//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of the configuration data repository used in business logic.
/// Used to retrieve configuration data representing various limits imposed by the email service.
protocol EmailConfigurationDataRepository: Repository {

    /// Retrieve the configuration data from the service.
    func getConfigurationData() async throws -> EmailConfigurationDataEntity
}
