//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Internal input for `ListDraftEmailMessageMetadataUseCase`.
struct ListDraftEmailMessageMetadataUseCaseInput {
    /// Maximum number of results to return. If omitted, the limit defaults to 10.
    let limit: Int?

    /// Token to retrieve the next page of results. If omitted, returns the first page.
    let nextToken: String?
}

/// Internal output for `ListDraftEmailMessageMetadataUseCase`.
struct ListDraftEmailMessageMetadataUseCaseOutput {
    /// List of draft email message metadata.
    let metadata: [DraftEmailMessageMetadata]

    /// Token to retrieve the next page of results, or nil if no more results.
    let nextToken: String?
}

class ListDraftEmailMessageMetadataUseCase {

    // MARK: - Properties

    let emailAccountRepository: EmailAccountRepository
    let emailMessageRepository: EmailMessageRepository

    // MARK: - Lifecycle

    init(
        emailAccountRepository: EmailAccountRepository,
        emailMessageRepository: EmailMessageRepository
    ) {
        self.emailAccountRepository = emailAccountRepository
        self.emailMessageRepository = emailMessageRepository
    }

    // MARK: - Methods

    func execute(withInput input: ListDraftEmailMessageMetadataUseCaseInput) async throws -> ListDraftEmailMessageMetadataUseCaseOutput {
        var allMetadata: [DraftEmailMessageMetadata] = []
        var currentNextToken = input.nextToken
        let limit = input.limit ?? 10
        var remainingLimit = limit

        var accountsNextToken: String?
        repeat {
            let emailAccounts = try await emailAccountRepository.list(limit: nil, nextToken: accountsNextToken)
            accountsNextToken = emailAccounts.nextToken

            for account in emailAccounts.items {
                guard remainingLimit > 0 else { break }

                let result = try await emailMessageRepository.listDraftsMetadataForEmailAddressId(
                    emailAddressId: account.id,
                    limit: remainingLimit,
                    nextToken: currentNextToken
                )

                let transformer = DraftEmailMetadataEntityTransformer()
                let metadata = result.items.map(transformer.transform(_:))
                allMetadata.append(contentsOf: metadata)

                remainingLimit -= metadata.count
                currentNextToken = result.nextToken

                // If we have a nextToken, we have more results for this account
                if currentNextToken != nil {
                    // Return what we have so far with the nextToken
                    return ListDraftEmailMessageMetadataUseCaseOutput(
                        metadata: allMetadata,
                        nextToken: currentNextToken
                    )
                }
            }

            if remainingLimit <= 0 {
                break
            }
        } while accountsNextToken != nil

        return ListDraftEmailMessageMetadataUseCaseOutput(
            metadata: allMetadata,
            nextToken: currentNextToken
        )
    }
}
