//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync
import AWSS3

/// Used to decode the file on disk. The config is stored in a nested JSON object `identityService`.
struct FileConfig: Decodable {
    var identityService: IdentityServiceConfig
    var emService: EmailServiceConfig
}

/// Configuration used to configure the client's S3 utility instance.
struct IdentityServiceConfig: Decodable {
    var poolId: String
    var identityPoolId: String
}

struct EmailServiceConfig: Decodable {
    var region: String
    var bucket: String
    var transientBucket: String
}

/// Configuration for connecting to the Sudo Email Service via AppSync.
struct SudoEmailConfig: AWSAppSyncServiceConfigProvider {

    // MARK: - Conformance: AWSAppSyncServiceConfigProvider

    public var endpoint: URL

    public var region: AWSRegionType

    public var authType: AWSAppSyncAuthType = .amazonCognitoUserPools

    public var apiKey: String?

    public var clientDatabasePrefix: String?

    // MARK: - Lifecycle

    /// Initialize an instance of `SudoEmailConfig`.
    public init(
        endpoint: URL,
        region: AWSRegionType,
        authType: AWSAppSyncAuthType = .amazonCognitoUserPools,
        apiKey: String? = nil,
        clientDatabasePrefix: String? = nil
    ) {
        self.endpoint = endpoint
        self.region = region
        self.authType = authType
        self.apiKey = apiKey
        self.clientDatabasePrefix = clientDatabasePrefix
    }
}
