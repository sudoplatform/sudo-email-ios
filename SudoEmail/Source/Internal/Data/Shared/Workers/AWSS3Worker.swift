//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoUser
import SudoLogging
import AWSS3

/// List of possible errors thrown by `AWSS3Worker` implementation.
///
public enum AWSS3WorkerError: Error {
    /// Indicates that a fatal error occurred. This could be due to coding error, out-of-memory
    /// condition or other conditions that is beyond control of `AWSS3Worker` implementation.
    case fatalError(description: String)
    /// Backed service is temporarily unavailable due to network or service availability issues.
    case serviceError(cause: Error)
    /// Attempted to access a non-existent S3 key
    case noSuchKey(description: String)
}

struct S3ObjectEntity: Equatable {
    /// The date / time of the last time this entity was modified
    public var lastModified: Date

    /// The body of the object
    public var body: Data

    /// The metadata associated with the
    public var metadata: [String: String]?
    
    // The content encoding value for the data
    public var contentEncoding: String?
}

/// S3 client wrapper protocol mainly used for providing an abstraction layer on top of
/// AWS S3 SDK.
protocol AWSS3Worker: AnyObject {

    /// Uploads a blob to AWS S3.
    ///
    /// - Parameters:
    ///   - data: Blob to upload.
    ///   - contentType: Content type of the blob.
    ///   - bucket: Name of S3 bucket to store the blob.
    ///   - key: S3 key to be associated with the blob.
    /// - Throws: `AWSS3WorkerError`
    func upload(
        data: Data,
        contentType: String,
        bucket: String,
        key: String,
        metadata: DraftEmailMessageEncryptionMetadata?
    ) async throws

    /// Downloads a blob from AWS S3.
    ///
    /// - Parameters:
    ///   - bucket: Name of S3 bucket to storing the blob.
    ///   - key: S3 key associated with the blob.
    /// - Returns: The data in the bucket
    /// - Throws: `AWSS3WorkerError`
    func download(bucket: String, key: String) async throws -> Data

    /// Gets an object (data + metadata) from AWS S3
    /// - Parameters:
    ///   - bucket: Name of S3 bucket to storing the blob.
    ///   - key: S3 key associated with the blob.
    /// - Returns: The data and metadata of the object
    /// - Throws: `AWSS3WorkerError`
    func getObject(bucket: String, key: String) async throws -> S3ObjectEntity

    /// Checks if an object exists.
    ///  - Parameters:
    ///    - bucket: The identifier of the bucket holding the object.
    ///    - key: The key of the object to check.
    ///  - Returns: true if the object exists, false otherwise.
    func objectExists(bucket: String, key: String) async throws -> Bool

    /// List the objects' metadata.
    ///  - Parameters:
    ///    - bucket: Name of S3 bucket containing the objects to list.
    ///    - key: The key or key prefix of the objects to list.
    ///  - Returns:
    ///    - The list of S3 objects matching key or empty if no objects match.
    func list(bucket: String, key: String) async throws -> [AWSS3Object]

    /// Deletes n object (data + metadata) from AWS S3
    /// - Parameters:
    ///   - bucket: Name of S3 bucket to storing the blob.
    ///   - key: S3 key associated with the blob.
    /// - Returns: The S3 key of the deleted object
    /// - Throws: `AWSS3WorkerError`
    func deleteObject(bucket: String, key: String) async throws -> String
}

/// Default S3 client implementation.
public class DefaultAWSS3Worker: AWSS3Worker & Resetable {

    // MARK: - Supplementary

    enum RequestHeaderNames {
        static let algorithm = "x-amz-meta-algorithm"
        static let keyId = "x-amz-meta-key-id"
    }

    // MARK: - Properties

    /// unique key for the AWSS3TransferUtility
    private let awsS3WorkerKey: String

    /// AWSCognitoCredentialsProvider instance for use with AWS3TransferUtility
    private let awsCredentialsProvider: AWSCognitoCredentialsProvider

    /// AWS S3 Client
    private let s3Client: AWSS3

    /// Initializes a `DefaultAWSS3Worker`.
    ///
    /// - Parameters:
    ///   - userClient: Logged in SudoUser client instance.
    ///   - AWSS3WorkerKey: Key used for locating AWS S3 SDK clients in the shared service registry.
    init(userClient: SudoUserClient, awsS3WorkerKey: String) throws {
        self.awsS3WorkerKey = awsS3WorkerKey
        let userClient = userClient
        let emailConfig = try Bundle.main.loadEmailConfig()
        let identityConfig = try Bundle.main.loadIdentityConfig()
        let s3Region = emailConfig.region
        guard let s3RegionType = AWSRegionType(string: s3Region) else {
            throw SudoEmailError.invalidConfig
        }
        let idProviderManager = IdentityProviderManager(client: userClient, region: s3Region, poolId: identityConfig.poolId)
        self.awsCredentialsProvider = AWSCognitoCredentialsProvider(
            regionType: s3RegionType,
            identityPoolId: identityConfig.identityPoolId,
            identityProviderManager: idProviderManager
        )
        guard let configuration = AWSServiceConfiguration(
            region: s3RegionType,
            credentialsProvider: awsCredentialsProvider
        ) else {
            throw SudoEmailError.invalidConfig
        }
        AWSS3TransferUtility.register(with: configuration, forKey: self.awsS3WorkerKey)
        AWSS3.register(with: configuration, forKey: self.awsS3WorkerKey)
        self.s3Client = AWSS3.s3(forKey: self.awsS3WorkerKey)
    }

    func reset() {
        self.awsCredentialsProvider.clearKeychain()
        self.awsCredentialsProvider.invalidateCachedTemporaryCredentials()
    }

    func upload(
        data: Data,
        contentType: String,
        bucket: String,
        key: String,
        metadata: DraftEmailMessageEncryptionMetadata?
    ) async throws {
        guard let awsS3Worker = AWSS3TransferUtility.s3TransferUtility(forKey: self.awsS3WorkerKey) else {
            throw AWSS3WorkerError.fatalError(description: "Cannot find S3 client registered with key: \(self.awsS3WorkerKey).")
        }

        do {
            var updateExpression: AWSS3TransferUtilityUploadExpression?
            if let draftMetadata = metadata {
                updateExpression = AWSS3TransferUtilityUploadExpression()
                updateExpression?.setValue(draftMetadata.algorithm, forRequestHeader: RequestHeaderNames.algorithm)
                updateExpression?.setValue(draftMetadata.keyId, forRequestHeader: RequestHeaderNames.keyId)
            }
            try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
                awsS3Worker.uploadData(
                    data,
                    bucket: bucket,
                    key: key,
                    contentType: contentType,
                    expression: updateExpression,
                    completionHandler: { task, error in
                        if let error = error {
                            continuation.resume(throwing: AWSS3WorkerError.serviceError(cause: error))
                            return
                        } else {
                            continuation.resume(returning: ())
                        }
                    }
                )
            }
        } catch {
            throw error
        }
    }

    func download(bucket: String, key: String) async throws -> Data {
        guard let awsS3Worker = AWSS3TransferUtility.s3TransferUtility(forKey: self.awsS3WorkerKey) else {
            throw AWSS3WorkerError.fatalError(description: "Cannot find S3 client registered with key: \(self.awsS3WorkerKey).")
        }

        let downloadExpression = AWSS3TransferUtilityDownloadExpression()
        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<Data, Error>) in
            awsS3Worker.downloadData(
                fromBucket: bucket,
                key: key,
                expression: downloadExpression,
                completionHandler: { (_, _, data, error) in
                    if let error = error {
                        continuation.resume(throwing: AWSS3WorkerError.serviceError(cause: error))
                        return
                    }
                    guard let data = data else {
                        continuation.resume(throwing: AWSS3WorkerError.fatalError(description: "Result did not contain JSON data."))
                        return
                    }
                    continuation.resume(returning: data)
                }
            )
            .continueWith { (task) -> AnyObject? in
                if let error = task.error {
                    continuation.resume(throwing: error)
                }
                return nil
            }
        })
    }

    func getObject(bucket: String, key: String) async throws -> S3ObjectEntity {
        guard let request = AWSS3GetObjectRequest() else {
            throw AWSS3WorkerError.fatalError(description: "Failed to instantiate S3 get object request.")
        }

        request.bucket = bucket
        request.key = key

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<S3ObjectEntity, Error>) in
            self.s3Client.getObject(request).continueWith { (task) -> AnyObject? in
                if let error = task.error {
                    if error._userInfo?["Code"] == "NoSuchKey" {
                        continuation.resume(throwing: AWSS3WorkerError.noSuchKey(description: "S3 key does not exist"))
                        return nil
                    }
                    continuation.resume(throwing: AWSS3WorkerError.serviceError(cause: error))
                    return nil
                }

                guard let body = task.result?.body as? Data else {
                    continuation.resume(
                        throwing: AWSS3WorkerError.fatalError(description: "Result did not contain any data.")
                    )
                    return nil
                }
                guard let lastModified = task.result?.lastModified else {
                    continuation.resume(
                        throwing: AWSS3WorkerError.fatalError(description: "Result did not contain lastModified field")
                    )
                    return nil
                }
                let s3ObjectEntity = S3ObjectEntity(
                    lastModified: lastModified,
                    body: body,
                    metadata: task.result?.metadata,
                    contentEncoding: task.result?.contentEncoding
                )
                continuation.resume(returning: s3ObjectEntity)
                return nil
            }
        })
    }

    func objectExists(bucket: String, key: String) async throws -> Bool {
        guard let request = AWSS3ListObjectsV2Request() else {
            throw AWSS3WorkerError.fatalError(description: "Failed to instantiate S3 get object request.")
        }
        request.bucket = bucket
        request.prefix = key
        request.maxKeys = 1

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<Bool, Error>) in
            self.s3Client.listObjectsV2(request).continueWith { (task) -> AnyObject? in
                if let error = task.error {
                    if error._userInfo?["Code"] == "NoSuchKey" {
                        continuation.resume(returning: false)
                        return nil
                    }
                    continuation.resume(throwing: AWSS3WorkerError.serviceError(cause: error))
                    return nil
                }

                if task.result?.contents?.first?.key != nil {
                    continuation.resume(returning: true)
                    return nil
                } else {
                    continuation.resume(returning: false)
                    return nil
                }
            }
        })
    }

    func list(bucket: String, key: String) async throws -> [AWSS3Object] {
        guard let request = AWSS3ListObjectsV2Request() else {
            throw AWSS3WorkerError.fatalError(description: "Failed to instantiate S3 get object request.")
        }
        request.bucket = bucket
        request.prefix = key

        return try await withCheckedThrowingContinuation({(continuation: CheckedContinuation<[AWSS3Object], Error>) in
            self.s3Client.listObjectsV2(request).continueWith { (task) -> AnyObject? in
                if let error = task.error {
                    if error._userInfo?["Code"] == "NoSuchKey" {
                        continuation.resume(returning: [])
                        return nil
                    }
                    continuation.resume(throwing: AWSS3WorkerError.serviceError(cause: error))
                    return nil
                }

                guard let listS3ObjectResult = task.result?.contents else {
                    continuation.resume(returning: [])
                    return nil
                }
                continuation.resume(returning: listS3ObjectResult)
                return nil
            }
        })
    }

    func deleteObject(bucket: String, key: String) async throws -> String {
        guard let request = AWSS3DeleteObjectRequest() else {
            throw AWSS3WorkerError.fatalError(description: "Failed to instantiate S3 get object request.")
        }
        request.bucket = bucket
        request.key = key

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<String, Error>) in
            self.s3Client.deleteObject(request).continueWith { (task) -> AnyObject? in
                if let error = task.error {
                    if error._userInfo?["Code"] == "NoSuchKey" {
                        continuation.resume(returning: key)
                        return nil
                    }
                    continuation.resume(throwing: AWSS3WorkerError.serviceError(cause: error))
                    return nil
                }

                continuation.resume(returning: key)
                return nil
            }
        })
    }
}
