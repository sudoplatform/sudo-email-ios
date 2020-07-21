//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

// swiftlint:disable type_name

import AWSAppSync
import SudoLogging
import SudoOperations

class SendEmailMessageOperationDependencyCondition: PlatformOperationCondition {
    static var name: String = "SendEmailMessageOperationDependencyCondition"

    func dependencyForOperation(_ operation: PlatformOperation) -> Operation? {
        nil
    }

    func evaluateForOperation(_ operation: PlatformOperation, completion: (PlatformOperationConditionResult) -> Void) {
        guard let operation = operation as? SendEmailMessageOperation else {
            let cause = "Only `SendEmailMessageOperation` can be assigned with a \(type(of: self).name) condition"
            let error = SudoEmailError.internalError(cause)
            completion(.failure(error))
            return
        }
        guard let s3UploadOperation = operation.dependencies.first(whereType: S3UploadOperation.self) else {
            let cause = "Required `S3UploadOperation` dependency is missing"
            let error = SudoEmailError.internalError(cause)
            completion(.failure(error))
            return
        }
        if let error = s3UploadOperation.errors.first {
            completion(.failure(error))
            return
        }
        guard let s3Object = s3UploadOperation.resultObject else {
            let cause = "Unable to resolve `s3Object` from `S3UploadOperation` dependency"
            let error = SudoEmailError.internalError(cause)
            completion(.failure(error))
            return
        }
        let injectables = SendEmailMessageOperation.Injectables(s3UploadResult: s3Object)
        operation.injectables = injectables
        completion(.success(()))
    }

}

// swiftlint:enable type_name

class SendEmailMessageOperation: PlatformOperation {

    // MARK: - Supplementary

    struct Injectables {
        let s3UploadResult: S3Object
    }

    // MARK: - Properties

    var resultObject: String?

    var injectables: Injectables!

    var emailAddress: EmailAddressEntity

    var queue: PlatformOperationQueue = PlatformOperationQueue()

    unowned let appSyncClient: AWSAppSyncClient

    unowned let operationFactory: OperationFactory

    // MARK: - Lifecycle

    init(emailAddress: EmailAddressEntity, appSyncClient: AWSAppSyncClient, operationFactory: OperationFactory, logger: Logger) {
        self.emailAddress = emailAddress
        self.appSyncClient = appSyncClient
        self.operationFactory = operationFactory
        super.init(logger: logger)
        addCondition(SendEmailMessageOperationDependencyCondition())
    }

    // MARK: - PlatformOperation

    override func execute() {
        let s3Result = injectables.s3UploadResult
        let s3Input = S3EmailObjectInput(key: s3Result.key, bucket: s3Result.bucket, region: s3Result.region)
        let input = SendEmailMessageInput(address: emailAddress.address, message: s3Input)
        let mutation = SendEmailMessageMutation(input: input)
        let operation = operationFactory.generateMutationOperation(mutation: mutation, appSyncClient: appSyncClient, logger: logger)
        let completionObserver = PlatformBlockObserver(finishHandler: { [unowned operation, weak self] _, errors in
            guard let weakSelf = self else { return }
            if let error = errors.first {
                weakSelf.finishWithError(error)
            }
            guard let result = operation.result?.sendEmailMessage else {
                return
            }
            weakSelf.resultObject = result
            weakSelf.finish()
        })
        operation.addObserver(completionObserver)
        queue.addOperation(operation)
    }

}
