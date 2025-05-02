//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Used to decode the file on disk. The config is stored in a nested JSON object `identityService`.
struct FileConfig: Decodable {
    let identityService: IdentityServiceConfig
    let emService: EmailServiceConfig
}

/// Configuration used to configure the client's S3 utility instance.
struct IdentityServiceConfig: Decodable {
    let poolId: String
    let identityPoolId: String
}

struct EmailServiceConfig: Decodable {
    let region: String
    let bucket: String
    let transientBucket: String
}

/// Configuration for connecting to the Sudo Email Service via AppSync.
struct SudoEmailConfig: Equatable {
    let endpoint: String
    let region: String
}
