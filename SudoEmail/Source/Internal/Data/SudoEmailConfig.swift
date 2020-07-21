//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSAppSync

/// Used to decode the file on disk. The config is stored in a nested JSON object `identityService`.
struct FileConfig: Decodable {
    var identityService: IdentityServiceConfig
}

/// Configuration used to configure the client's S3 utility instance.
struct IdentityServiceConfig: Decodable {
    var region: AWSRegionType
    var poolId: String
    var identityPoolId: String
    var bucket: String
    var transientBucket: String
}
