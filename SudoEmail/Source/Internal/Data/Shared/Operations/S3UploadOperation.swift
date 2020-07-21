//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSS3
import SudoLogging
import SudoOperations

/// Object that represents the necessary identifiers to access an S3 Object.
struct S3Object: Equatable {
    /// Key identifier of the S3 Object.
    var key: String
    /// Bucket identifier of the S3 Object.
    var bucket: String
    /// Region identifier of the S3 Object.
    var region: String
}

/// Operation to upload a file to an S3 bucket.
class S3UploadOperation: PlatformOperation {

    // MARK: - Supplementary

    /// Defaults used in `S3UploadOperation`.
    enum Defaults {
        /// Contenty type of the S3 Upload used in this operation.
        static let contentType = "text/plain"
    }

    // MARK: - Properties

    /// Result object of the operation. If the operation is unsuccessful, this will be `nil`.
    var resultObject: S3Object?

    /// Input data to be uploaded to the S3 Bucket.
    let data: Data

    /// Input key to be used to identify and provision the record on the S3 Bucket.
    let key: String

    /// Input bucket identifier to place the object on S3.
    let bucket: String

    /// Input region identifier of where the bucket is located on S3 services.
    let region: String

    /// Instance of the S3 Transfer utility, to perform the upload.
    unowned let s3TransferUtility: S3TransferUtility

    // MARK: - Lifecycle

    /// Initialize an instance of `S3UploadOperation`.
    init(
        data: Data,
        key: String,
        bucket: String,
        region: String,
        s3TransferUtility: S3TransferUtility,
        logger: Logger = .emailSDKLogger
    ) {
        self.data = data
        self.key = key
        self.bucket = bucket
        self.region = region
        self.s3TransferUtility = s3TransferUtility
        super.init(logger: logger)
    }

    // MARK: - PlatformOperation

    override func execute() {
        s3TransferUtility.uploadData(
            data,
            bucket: bucket,
            key: key,
            contentType: Defaults.contentType,
            expression: nil,
            completionHandler: s3UploadDidFinish(task:error:)
        )
    }

    // MARK: - Helpers

    /// Handles a result from the `S3TransferUtility.uploadData(:key:contentType:expression:completionHandler:)` call.
    func s3UploadDidFinish(task: AWSS3TransferUtilityUploadTask, error: Error?) {
        if let error = error {
            finishWithError(error)
            return
        }
        resultObject = S3Object(key: key, bucket: bucket, region: region)
        finish()
    }
}
