//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoOperations
import SudoLogging

/// Core use case representation of a operation to provision an email account.
///
/// Performs the following operations:
/// - Checks to see if the device key is registered and if not, will register the key.
/// - Gets the user's ownership proof for the account.
/// - Calls the sudo email service provision email api to finish the provision.
class ProvisionEmailAccountUseCase {

    // MARK: - Properties: Repositories

    /// Ownership proof repository to access the ownership proof for the user's account.
    let ownershipProofRepository: OwnershipProofRepository

    /// Key pair repository to access the public key for the user's account.
    let keyRepository: KeyRepository

    /// Email account repository to create the email account.
    let emailAccountRepository: EmailAccountRepository

    // MARK: - Properties

    /// Logs diagnostic and error information.
    let logger: Logger

    /// Queue to load operations onto for the use case.
    var queue: PlatformOperationQueue = PlatformOperationQueue()

    // MARK: - Lifecycle

    /// Initialize an instance of the `ProvisionEmailAccount` use case.
    init(
        ownershipProofRepository: OwnershipProofRepository,
        keyRepository: KeyRepository,
        emailAccountRepository: EmailAccountRepository,
        logger: Logger = .emailSDKLogger
    ) {
        self.ownershipProofRepository = ownershipProofRepository
        self.keyRepository = keyRepository
        self.emailAccountRepository = emailAccountRepository
        self.logger = logger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - emailAddress: Email address to use to provision.
    ///   - sudoId: Identifier of the sudo to provision the email account to.
    ///   - completion: Returns a newly created email account on success, or error on failure.
    func execute(emailAddress: EmailAddressEntity, sudoId: String, completion: @escaping ClientCompletion<EmailAccountEntity>) {
        // Generate operations.
        let getRegisteredKeyPairOperation = GetRegisteredPublicKeyOperation(keyRepository: keyRepository, logger: logger)
        let getOwnershipProofOperation = GetOwnershipProofOperation(sudoId: sudoId, ownershipProofRepository: ownershipProofRepository, logger: logger)
        let createEmailAccountOperation = CreateEmailAccountOperation(
            emailAddress: emailAddress,
            emailAccountRepository: emailAccountRepository,
            logger: logger
        )

        // Setup dependencies.
        createEmailAccountOperation.addDependency(getRegisteredKeyPairOperation)
        createEmailAccountOperation.addDependency(getOwnershipProofOperation)

        // Handle completion.
        let completionObserver = generateCompletionHandler(forOperation: createEmailAccountOperation, completion: completion)
        createEmailAccountOperation.addObserver(completionObserver)
        queue.addOperations([getRegisteredKeyPairOperation, getOwnershipProofOperation, createEmailAccountOperation], waitUntilFinished: false)
    }

    // MARK: - Helpers

    /// Generates the completion handler for the use case. Handles the result from the `CreateEmailAccountOperation`.
    /// - Parameters:
    ///   - operation: The last operation to finish before handing data back to the consumer.
    ///   - completion: Completion passed in by the consumer.
    /// - Returns: The observer to attach to the `CreateEmailAccountOperation`.
    func generateCompletionHandler(
        forOperation operation: CreateEmailAccountOperation,
        completion: @escaping ClientCompletion<EmailAccountEntity>
    ) -> PlatformBlockObserver {
        return PlatformBlockObserver(finishHandler: { [unowned operation] _, errors in
            if let error = errors.first {
                completion(.failure(error))
            }
            guard let account = operation.resultObject else {
                return
            }
            completion(.success(account))
        })
    }

}
