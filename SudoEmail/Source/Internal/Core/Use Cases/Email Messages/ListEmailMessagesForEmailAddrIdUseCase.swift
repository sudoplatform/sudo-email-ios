//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Gets the list of email messages from the device cache locally.
class ListEmailMessagesForEmailAddrIdUseCase {

    // MARK: - Properties

    /// Email message repository used to access the email messages.
    let emailMessageRepository: EmailMessageRepository

    let emailMessageUnsealerService: EmailMessageUnsealerService

    let sealedEmailMessageEntityTransformer: SealedEmailMessageEntityTransformer

    // MARK: - Lifecycle

    /// Initialize an instance of `ListEmailMessagesUseCase`.
    init(
        emailMessageRepository: EmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService,
        sealedEmailMessageEntityTransformer: SealedEmailMessageEntityTransformer
    ) {
        self.emailMessageRepository = emailMessageRepository
        self.emailMessageUnsealerService = emailMessageUnsealerService
        self.sealedEmailMessageEntityTransformer = sealedEmailMessageEntityTransformer
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - input: Parameters used to retrieve a list of email messages.
    func execute(
        withInput input: ListEmailMessagesForEmailAddressInput
    ) async throws -> ListAPIResult<EmailMessageEntity, PartialEmailMessageEntity> {
        let sealedEmailMessages = try await emailMessageRepository.listEmailMessagesForEmailAddressId(
            withInput: input
        )
        var successMessages: [EmailMessageEntity] = []
        var partialResults: [PartialResult<PartialEmailMessageEntity>] = []
        for message in sealedEmailMessages.items {
            do {
                let unsealedMessage = try emailMessageUnsealerService.unsealEmailMessage(message)
                successMessages.append(unsealedMessage)
            } catch {
                let partialMessage = self.sealedEmailMessageEntityTransformer.transform(sealedEmailMessage: message)
                let partialResult = PartialResult(partial: partialMessage, error: error)
                partialResults.append(partialResult)
            }
        }
        if !partialResults.isEmpty {
            let listPartialResult = ListAPIResult.ListPartialResult(
                items: successMessages,
                failed: partialResults,
                nextToken: sealedEmailMessages.nextToken
            )
            return ListAPIResult.partial(listPartialResult)
        }
        let listSuccessResult = ListAPIResult<EmailMessageEntity, PartialEmailMessageEntity>.ListSuccessResult(
            items: successMessages,
            nextToken: sealedEmailMessages.nextToken
        )
        return ListAPIResult.success(listSuccessResult)
    }

}
