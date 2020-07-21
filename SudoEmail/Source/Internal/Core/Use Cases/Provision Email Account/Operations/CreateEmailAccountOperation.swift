//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

// swiftlint:disable type_name

import Foundation
import SudoOperations
import SudoLogging

/// Dependency condition for the `CreateEmailAccountOperation`.
///
/// Ensures that dependencies for the `CreateEmailAccountOperation` are met and extracts the dependency results an injects them into the operation.
class CreateEmailAccountOperationDependencyCondition: PlatformOperationCondition {

    static var name: String = "CreateEmailAccountOperationDependencyCondition"

    func dependencyForOperation(_ operation: PlatformOperation) -> Operation? {
        return nil
    }

    func evaluateForOperation(_ operation: PlatformOperation, completion: (PlatformOperationConditionResult) -> Void) {
        guard let operation = operation as? CreateEmailAccountOperation else {
            let cause = "Only `CreateEmailAccountOperation` can be assigned with a \(type(of: self).name) condition"
            let error = SudoEmailError.internalError(cause)
            completion(.failure(error))
            return
        }
        guard let getRegisteredKeyOperation = operation.dependencies.first(whereType: GetRegisteredPublicKeyOperation.self) else {
            let cause = "Required `GetRegisteredKeyPairOperation` dependency is missing"
            let error = SudoEmailError.internalError(cause)
            completion(.failure(error))
            return
        }
        if let error = getRegisteredKeyOperation.errors.first {
            completion(.failure(error))
            return
        }
        guard let publicKey = getRegisteredKeyOperation.resultObject else {
            let cause = "Unable to resolve `publicKey` from `GetRegisteredKeyPairOperation` dependency"
            let error = SudoEmailError.internalError(cause)
            completion(.failure(error))
            return
        }
        guard let getOwnershipProofOperation = operation.dependencies.first(whereType: GetOwnershipProofOperation.self) else {
            let cause = "Required `GetOwnershipProofOperation` dependency is missing"
            let error = SudoEmailError.internalError(cause)
            completion(.failure(error))
            return
        }
        if let error = getOwnershipProofOperation.errors.first {
            completion(.failure(error))
            return
        }
        guard let ownershipProof = getOwnershipProofOperation.resultObject else {
            let cause = "Unable to resolve `ownershipProof` from `getOwnershipProofOperation` dependency"
            let error = SudoEmailError.internalError(cause)
            completion(.failure(error))
            return
        }
        let injectables = CreateEmailAccountOperation.Injectables(publicKey: publicKey, ownershipProof: ownershipProof)
        operation.injectables = injectables
        completion(.success(()))
    }

}

// swiftlint:enable type_name

/// Create an email account.
class CreateEmailAccountOperation: PlatformOperation {

    // MARK: - Supplementary

    /// Data from dependencies that is injected into this operation.
    struct Injectables {
        /// Public key data from the `GetRegisteredKeyOperation`.
        let publicKey: KeyEntity
        /// Ownership proof from the `GetOwnershipProofOperation`.
        let ownershipProof: String
    }

    // MARK: - Properties

    /// Result object of the operation. The newly created email account.
    var resultObject: EmailAccountEntity?

    /// Input email address to be used when creating the account.
    let emailAddress: EmailAddressEntity

    /// Injected data.
    var injectables: Injectables!

    /// Key pair repository to create the account.
    unowned let emailAccountRepository: EmailAccountRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `CreateEmailAccountOperation`.
    init(emailAddress: EmailAddressEntity, emailAccountRepository: EmailAccountRepository, logger: Logger) {
        self.emailAddress = emailAddress
        self.emailAccountRepository = emailAccountRepository
        super.init(logger: logger)
        addCondition(CreateEmailAccountOperationDependencyCondition())
    }

    // MARK: - PlatformOperation

    override func execute() {
        emailAccountRepository.createWithEmailAddress(
            emailAddress,
            publicKey: injectables.publicKey,
            ownershipProof: injectables.ownershipProof
        ) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case let .success(emailAccount):
                weakSelf.resultObject = emailAccount
                weakSelf.finish()
            case let .failure(error):
                weakSelf.finishWithError(error)
            }
        }
    }

}
