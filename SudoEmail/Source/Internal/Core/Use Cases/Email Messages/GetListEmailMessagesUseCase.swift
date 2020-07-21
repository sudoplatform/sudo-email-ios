//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core use case representation of a operation to fetch a list of email messages.
///
/// Gets the list of email messages from the device cache locally.
class GetListEmailMessagesUseCase {

    // MARK: - Properties

    /// Email message repository used to access the email messages.
    let sealedEmailMessageRepository: SealedEmailMessageRepository

    let emailMessageUnsealerService: EmailMessageUnsealerService

    // MARK: - Lifecycle

    /// Initialize an instance of `FetchListEmailMessagesUseCase`.
    init(sealedEmailMessageRepository: SealedEmailMessageRepository, emailMessageUnsealerService: EmailMessageUnsealerService) {
        self.sealedEmailMessageRepository = sealedEmailMessageRepository
        self.emailMessageUnsealerService = emailMessageUnsealerService
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - filter: Filter rules to be applied to the list.
    ///   - limit: Limit of the results to return.
    ///   - nextToken: Next token to be used when accessing the next page of information.
    ///   - completion: Returns a list of results with a next token is there if more results to fetch, or error on failure.
    func execute(
        withFilter filter: EmailMessageFilterEntity?,
        limit: Int?,
        nextToken: String?,
        completion: @escaping ClientCompletion<ListOutputEntity<EmailMessageEntity>>
    ) {
        sealedEmailMessageRepository.getListEmailMessagesByFilter(filter, limit: limit, nextToken: nextToken) { result in
            let result: Result<ListOutputEntity<EmailMessageEntity>, Error> = result.mapThrowingSuccess { output in
                let items = try output.items.map(self.emailMessageUnsealerService.unsealEmailMessage(_:))
                let nextToken = output.nextToken
                return ListOutputEntity(items: items, nextToken: nextToken)
            }
            completion(result)
        }
    }

}
