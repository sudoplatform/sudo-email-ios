//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSS3
import SudoUser

class EmailS3LifecycleStrategy: S3LifecycleStrategy {

    /// Utility key to register
    private var s3TransferUtilityKey: String = "com.sudoplatform.telephonyclient.s3TransferUtility"

    func generateWithUserClient(_ userClient: SudoUserClient) throws -> S3TransferUtility {
        let config = try Bundle.main.loadIdentityConfig()
        // configure S3TransferUtility
        let region = config.region
        guard let regionString = region.string else {
            throw SudoEmailError.internalError("Region: \(region) in config is not supported")
        }
        let poolId = config.poolId
        let identityPoolId = config.identityPoolId
        let identityProviderManager = IdentityProviderManager(
            client: userClient,
            region: regionString,
            poolId: poolId
        )
        let credentialsProvider = AWSCognitoCredentialsProvider(
            regionType: region,
            identityPoolId: identityPoolId,
            identityProviderManager: identityProviderManager)
        // this constructor always returns a non-nil value
        guard let awsConfig = AWSServiceConfiguration(region: region, credentialsProvider: credentialsProvider) else {
            throw SudoEmailError.invalidConfig
        }
        if let registedUtility = AWSS3TransferUtility.s3TransferUtility(forKey: s3TransferUtilityKey) {
            return registedUtility
        }
        // register and retrieve the utility.
        // this retrieval will always succeed unless another thread calls reset()
        AWSS3TransferUtility.register(with: awsConfig, forKey: s3TransferUtilityKey)
        guard let utility = AWSS3TransferUtility.s3TransferUtility(forKey: s3TransferUtilityKey) else {
            throw SudoEmailError.invalidConfig
        }
        return utility
    }

    func removeS3TransferUtilityForEmailSDK() {
        AWSS3TransferUtility.remove(forKey: s3TransferUtilityKey)
    }

}
