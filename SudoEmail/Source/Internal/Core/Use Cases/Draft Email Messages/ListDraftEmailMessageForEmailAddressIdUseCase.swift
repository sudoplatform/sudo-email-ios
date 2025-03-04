//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

// swiftlint:disable type_name
class ListDraftEmailMessageMetadataForEmailAddressIdUseCase {

    // MARK: - Properties

    let emailMessageRepository: EmailMessageRepository

    // MARK: - Lifecycle

    init(emailMessageRepository: EmailMessageRepository) {
        self.emailMessageRepository = emailMessageRepository
    }

    // MARK: - Methods

    func execute(emailAddressId: String) async throws -> [DraftEmailMessageMetadata] {
        let draftEmailMessageMetadataEntity = try await emailMessageRepository.listDraftsMetadataForEmailAddressId(
            emailAddressId: emailAddressId
        )
        let transformer = DraftEmailMetadataEntityTransformer()
        return draftEmailMessageMetadataEntity.map(transformer.transform(_:))
    }
}

// swiftlint:enable type_name
