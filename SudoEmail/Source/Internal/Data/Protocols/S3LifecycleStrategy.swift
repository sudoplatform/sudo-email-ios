//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import SudoUser

/// Strategy generating and removing the instance of the `S3TransferUtility`.
protocol S3LifecycleStrategy {

    /// Generate an instance of `AWSS3TransferUtility`, using the input `userClient`.
    /// - Throws: `SudoEmailError`.
    func generateWithUserClient(_ userClient: SudoUserClient) throws -> S3TransferUtility

    /// Removes the instance of the S3Transfer Utility for email.
    func removeS3TransferUtilityForEmailSDK()

}
