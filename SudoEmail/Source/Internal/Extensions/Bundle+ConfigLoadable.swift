//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

private var cachedConfigFile: FileConfig?

extension Bundle {

    /// Load the identity configuration from file. Caches the file config on first load, so subsequent calls will just read from memory.
    /// - Throws: `SudoEmailError`.
    func loadIdentityConfig() throws -> IdentityServiceConfig {
        if let configFile = cachedConfigFile {
            return configFile.identityService
        }
        guard let fileURL = url(forResource: "sudoplatformconfig", withExtension: "json") else {
            throw SudoEmailError.invalidConfig
        }
        let configData = try Data(contentsOf: fileURL)
        let fileConfig = try JSONDecoder().decode(FileConfig.self, from: configData)
        cachedConfigFile = fileConfig
        return fileConfig.identityService
    }

    /// Load the email configuration from file. Caches the file config on first load, so subsequent calls will just read from memory.
    /// - Throws: `SudoEmailError`.
    func loadEmailConfig() throws -> EmailServiceConfig {
        if let configFile = cachedConfigFile {
            return configFile.emService
        }
        guard let fileURL = url(forResource: "sudoplatformconfig", withExtension: "json") else {
            throw SudoEmailError.invalidConfig
        }
        let configData = try Data(contentsOf: fileURL)
        let fileConfig = try JSONDecoder().decode(FileConfig.self, from: configData)
        cachedConfigFile = fileConfig
        return fileConfig.emService
    }
}
