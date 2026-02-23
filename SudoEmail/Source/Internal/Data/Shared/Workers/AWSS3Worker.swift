//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import AWSS3
import Foundation
import SudoLogging
import SudoUser

/// List of possible errors thrown by `AWSS3Worker` implementation.
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
    var lastModified: Date

    /// The body of the object
    var body: Data

    /// The metadata associated with the
    var metadata: [String: String]?

    // The content encoding value for the data
    var contentEncoding: String?
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
    ///   - metadata: Optional metadata.
    /// - Throws: `AWSS3WorkerError`
    func upload(
        data: Data,
        contentType: String,
        bucket: String,
        key: String,
        metadata: [String: String]?
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
    ///    - limit: Maximum number of objects to return. If nil, returns all objects.
    ///    - nextToken: Token to retrieve the next page of results. If nil, returns the first page.
    ///  - Returns:
    ///    - A tuple containing the list of S3 objects matching key and the next token for pagination.
    func list(bucket: String, key: String, limit: Int?, nextToken: String?) async throws -> (objects: [S3ClientTypes.Object], nextToken: String?)

    /// Deletes n object (data + metadata) from AWS S3
    /// - Parameters:
    ///   - bucket: Name of S3 bucket to storing the blob.
    ///   - key: S3 key associated with the blob.
    /// - Returns: The S3 key of the deleted object
    /// - Throws: `AWSS3WorkerError`
    func deleteObject(bucket: String, key: String) async throws -> String
}

/// Default S3 client implementation.
class DefaultAWSS3Worker: AWSS3Worker {

    // MARK: - Properties

    /// The AWS region.
    let region: String

    /// Provides AWS credentials to the S3Client.
    let credentialIdentityResolver: CredentialIdentityResolver

    /// AWS S3 Client
    let s3Client: S3Client

    /// Initializes a `DefaultAWSS3Worker`.
    /// - Parameter region: The AWS region.
    init(region: String) throws {
        self.region = region
        credentialIdentityResolver = CredentialIdentityResolver()
        let config = try S3Client.S3ClientConfiguration(awsCredentialIdentityResolver: credentialIdentityResolver, region: region)
        s3Client = S3Client(config: config)
    }

    // MARK: - Conformance: AWSS3Worker

    func upload(
        data: Data,
        contentType: String,
        bucket: String,
        key: String,
        metadata: [String: String]?
    ) async throws {
        let input = PutObjectInput(
            body: .data(data),
            bucket: bucket,
            contentType: contentType,
            key: key,
            metadata: metadata
        )
        do {
            _ = try await s3Client.putObject(input: input)
        } catch {
            throw AWSS3WorkerError.serviceError(cause: error)
        }
    }

    func download(bucket: String, key: String) async throws -> Data {
        let object = try await getObject(bucket: bucket, key: key)
        return object.body
    }

    func getObject(bucket: String, key: String) async throws -> S3ObjectEntity {
        let input = GetObjectInput(bucket: bucket, key: key)
        do {
            let output = try await s3Client.getObject(input: input)
            let data = try await output.body?.readData()
            guard let data else {
                throw SudoEmailError.fatalError("Result did not contain any data.")
            }
            guard let lastModified = output.lastModified else {
                throw SudoEmailError.fatalError("Result did not contain lastModified field")
            }
            return S3ObjectEntity(
                lastModified: lastModified,
                body: data,
                metadata: output.metadata,
                contentEncoding: output.contentEncoding
            )
        } catch is NoSuchKey {
            throw AWSS3WorkerError.noSuchKey(description: "S3 key does not exist")

        } catch let workerError as AWSS3WorkerError {
            throw workerError

        } catch {
            throw AWSS3WorkerError.serviceError(cause: error)
        }
    }

    func objectExists(bucket: String, key: String) async throws -> Bool {
        let input = ListObjectsV2Input(bucket: bucket, maxKeys: 1, prefix: key)
        do {
            let output = try await s3Client.listObjectsV2(input: input)
            if let objects = output.contents, objects.contains(where: { $0.key == key }) {
                return true
            } else {
                return false
            }
        } catch is NoSuchKey {
            return false
        } catch {
            throw AWSS3WorkerError.serviceError(cause: error)
        }
    }

    func list(bucket: String, key: String, limit: Int?, nextToken: String?) async throws -> (objects: [S3ClientTypes.Object], nextToken: String?) {
        let input = ListObjectsV2Input(
            bucket: bucket,
            continuationToken: nextToken,
            maxKeys: limit ?? 10,
            prefix: key
        )
        do {
            let output = try await s3Client.listObjectsV2(input: input)
            return (objects: output.contents ?? [], nextToken: output.nextContinuationToken)
        } catch is NoSuchKey {
            return (objects: [], nextToken: nil)
        } catch {
            throw AWSS3WorkerError.serviceError(cause: error)
        }
    }

    func deleteObject(bucket: String, key: String) async throws -> String {
        let input = DeleteObjectInput(bucket: bucket, key: key)
        do {
            _ = try await s3Client.deleteObject(input: input)
            return key
        } catch is NoSuchKey {
            return key
        } catch {
            throw AWSS3WorkerError.serviceError(cause: error)
        }
    }
}
