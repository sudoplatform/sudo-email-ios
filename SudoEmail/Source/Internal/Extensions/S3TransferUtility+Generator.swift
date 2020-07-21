//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSS3
import SudoUser

extension AWSS3TransferUtility {

    /// Strategy generating and removing the instance of the `S3TransferUtility`.
    static var strategy: S3LifecycleStrategy = EmailS3LifecycleStrategy()

    /// Generate an instance of `AWSS3TransferUtility`, using the input `userClient`.
    /// - Throws: `SudoEmailError`.
    static func generateWithUserClient(_ userClient: SudoUserClient) throws -> S3TransferUtility {
        return try strategy.generateWithUserClient(userClient)
    }

    /// Removes the instance of the S3Transfer Utility for email.
    static func removeS3TransferUtilityForEmailSDK() {
        strategy.removeS3TransferUtilityForEmailSDK()
    }

}
