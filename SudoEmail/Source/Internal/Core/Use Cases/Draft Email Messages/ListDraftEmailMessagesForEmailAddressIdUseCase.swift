//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
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
            let metadata = try await self.emailMessageRepository.listDraftsMetadataForEmailAddressId(emailAddressId: emailAddressId)
            
            let result = try await withThrowingTaskGroup(of: DraftEmailMessage?.self) { group -> [DraftEmailMessage] in
                var draftMessages: [DraftEmailMessage] = []
                
                for m in metadata {
                    group.addTask {
                        do {
                            let draft = try await self.emailMessageRepository.getDraft(withInput: GetDraftEmailMessageInput(id: m.id, emailAddressId: emailAddressId))
                            return draft
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
            return result
        } catch {
            throw error
        }
    }
}
