//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of a operation to fetch the RFC 6854 (supersedes RFC 822) data of the email message remotely.
class FetchEmailMessageRFC822DataUseCase {

    // MARK: - Properties

    /// Email message repository used to access email message records and the RFC 6854 (supersedes RFC 822) data of the message.
    let sealedEmailMessageRepository: SealedEmailMessageRepository

    /// Key repository to access the device key to use to query the email message record.
    let keyRepository: KeyRepository

    let emailMessageUnsealerService: EmailMessageUnsealerService

    // MARK: - Lifecycle

    /// Initialize an instance of `FetchEmailMessageRFC822DataUseCase`.
    init(sealedEmailMessageRepository: SealedEmailMessageRepository, keyRepository: KeyRepository, emailMessageUnsealerService: EmailMessageUnsealerService) {
        self.sealedEmailMessageRepository = sealedEmailMessageRepository
        self.keyRepository = keyRepository
        self.emailMessageUnsealerService = emailMessageUnsealerService
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - id: Identifier of the email message to be accessed.
    ///   - completion: Body of the email message associated with `id`, or error on failure.
    func execute(withMessageId id: String, completion: @escaping ClientCompletion<Data>) {
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
            switch result {
            case let .failure(error):
                completion(.failure(error))
                return
            case let .success(emailMessage):
                guard let emailMessage = emailMessage else {
                    completion(.failure(SudoEmailError.noEmailMessageRFC822Available))
                    return
                }
                self.sealedEmailMessageRepository.fetchEmailMessageRFC822DataWithId(emailMessage.id) { result in
                    let result = result.mapThrowingSuccess {
                        return try self.emailMessageUnsealerService.unsealEmailMessageRFC822Data(
                            $0,
                            withKeyId: emailMessage.keyId,
                            algorithm: emailMessage.algorithm
                        )
                    }
                    completion(result)
                }
            }
        }
    }
}
