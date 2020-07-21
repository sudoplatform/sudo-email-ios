//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

class FetchEmailMessageUseCase {

    // MARK: - Properties

    let sealedEmailMessageRepository: SealedEmailMessageRepository

    let keyRepository: KeyRepository

    let emailMessageUnsealerService: EmailMessageUnsealerService

    // MARK: - Lifecycle

    init(sealedEmailMessageRepository: SealedEmailMessageRepository, keyRepository: KeyRepository, emailMessageUnsealerService: EmailMessageUnsealerService) {
        self.sealedEmailMessageRepository = sealedEmailMessageRepository
        self.keyRepository = keyRepository
        self.emailMessageUnsealerService = emailMessageUnsealerService
    }

    // MARK: - Methods

    func execute(withMessageId id: String, completion: @escaping ClientCompletion<EmailMessageEntity?>) {
        let publicKey: KeyEntity
        do {
            let keyPair = try keyRepository.getCurrentKeyPair()
            guard let pk = keyPair?.publicKey else {
                throw SudoEmailError.internalError("No public key registered")
            }
            publicKey = pk
        } catch {
            completion(.failure(error))
            return
        }
        sealedEmailMessageRepository.fetchEmailMessageById(id, keyId: publicKey.keyId) { result in
            let result: Result<EmailMessageEntity?, Error> = result.mapThrowingSuccess { sealedMessage in
                guard let sealedMessage = sealedMessage else {
                    return nil
                }
                return try self.emailMessageUnsealerService.unsealEmailMessage(sealedMessage)
            }
            completion(result)
        }
    }
}
