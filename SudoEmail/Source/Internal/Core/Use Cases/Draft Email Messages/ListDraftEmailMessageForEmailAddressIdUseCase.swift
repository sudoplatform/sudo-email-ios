//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Internal input for `ListDraftEmailMessageMetadataForEmailAddressIdUseCase`.
struct ListDraftEmailMessageMetadataForEmailAddressIdUseCaseInput {
    /// Identifier of the email address associated with the draft email messages.
    let emailAddressId: String

    /// Maximum number of results to return. If omitted, the limit defaults to 10.
    let limit: Int?

    /// Token to retrieve the next page of results. If omitted, returns the first page.
    let nextToken: String?
}

/// Internal output for `ListDraftEmailMessageMetadataForEmailAddressIdUseCase`.
struct ListDraftEmailMessageMetadataForEmailAddressIdUseCaseOutput {
    /// List of draft email message metadata.
    let metadata: [DraftEmailMessageMetadata]

    /// Token to retrieve the next page of results, or nil if no more results.
    let nextToken: String?
}

// swiftlint:disable type_name
class ListDraftEmailMessageMetadataForEmailAddressIdUseCase {

    // MARK: - Properties

    let emailMessageRepository: EmailMessageRepository

    // MARK: - Lifecycle

    init(emailMessageRepository: EmailMessageRepository) {
        self.emailMessageRepository = emailMessageRepository
    }

    // MARK: - Methods

    func execute(
        withInput input: ListDraftEmailMessageMetadataForEmailAddressIdUseCaseInput
    ) async throws -> ListDraftEmailMessageMetadataForEmailAddressIdUseCaseOutput {
        let result = try await emailMessageRepository.listDraftsMetadataForEmailAddressId(
            emailAddressId: input.emailAddressId,
            limit: input.limit,
            nextToken: input.nextToken
        )
        let transformer = DraftEmailMetadataEntityTransformer()
        let metadata = result.items.map(transformer.transform(_:))
        return ListDraftEmailMessageMetadataForEmailAddressIdUseCaseOutput(
            metadata: metadata,
            nextToken: result.nextToken
        )
    }
}

// swiftlint:enable type_name
