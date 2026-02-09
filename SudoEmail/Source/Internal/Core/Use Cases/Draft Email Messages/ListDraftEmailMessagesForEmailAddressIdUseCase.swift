//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

class ListDraftEmailMessagesForEmailAddressIdUseCase {

    // MARK: - Properties

    let emailMessageRepository: EmailMessageRepository

    // MARK: - Lifecycle

    init(emailMessageRepository: EmailMessageRepository) {
        self.emailMessageRepository = emailMessageRepository
    }

    // MARK: - Methods

    func execute(emailAddressId: String) async throws -> [DraftEmailMessage] {
        do {
            let metadataResult = try await emailMessageRepository.listDraftsMetadataForEmailAddressId(
                emailAddressId: emailAddressId,
                limit: nil,
                nextToken: nil
            )

            return try await withThrowingTaskGroup(of: DraftEmailMessage?.self) { group -> [DraftEmailMessage] in
                var draftMessages: [DraftEmailMessage] = []

                for m in metadataResult.items {
                    group.addTask {
                        do {
                            return try await self.emailMessageRepository.getDraft(withInput: GetDraftEmailMessageInput(
                                id: m.id,
                                emailAddressId: emailAddressId
                            ))
                        } catch {
                            throw error
                        }
                    }
                }
                for try await draft in group {
                    if let draft = draft {
                        draftMessages.append(draft)
                    }
                }
                return draftMessages
            }
        } catch {
            throw error
        }
    }
}
