//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

class ListDraftEmailMessagesUseCase {

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

    func execute() async throws -> [DraftEmailMessage] {

        var result: [DraftEmailMessage] = []

        var nextToken: String?
        repeat {
            let emailAccounts = try await emailAccountRepository.fetchList(limit: nil, nextToken: nextToken)
            nextToken = emailAccounts.nextToken

            try await withThrowingTaskGroup(of: [DraftEmailMessage].self) { group in
                for account in emailAccounts.items {
                    group.addTask {
                        let metadata = try await self.emailMessageRepository.listDraftsMetadataForEmailAddressId(emailAddressId: account.id)
                        let draftContent = try await withThrowingTaskGroup(of: DraftEmailMessage?.self) { innerGroup in
                            for m in metadata {
                                innerGroup.addTask {
                                    return try await self.emailMessageRepository.getDraft(withInput: GetDraftEmailMessageInput(
                                        id: m.id,
                                        emailAddressId: account.id
                                    ))
                                }
                            }
                            var drafts: [DraftEmailMessage?] = []
                            for try await draft in innerGroup {
                                drafts.append(draft)
                            }
                            return drafts
                        }
                        let draftMessages = draftContent.compactMap { $0 }
                        return draftMessages
                    }
                }
                for try await drafts in group {
                    result.append(contentsOf: drafts)
                }
            }
        } while nextToken != nil

        return result
    }
}
