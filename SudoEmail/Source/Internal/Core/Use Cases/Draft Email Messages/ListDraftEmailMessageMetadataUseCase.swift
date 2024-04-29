//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

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

    func execute() async throws -> [DraftEmailMessageMetadata] {
        
        var result: [DraftEmailMessageMetadataEntity] = []

        var nextToken: String? = nil
        repeat {
            do {
                let emailAccounts = try await self.emailAccountRepository.list(limit: nil, nextToken: nextToken)
                nextToken = emailAccounts.nextToken
                
                try await withThrowingTaskGroup(of: [DraftEmailMessageMetadataEntity].self) { group in
                    for account in emailAccounts.items {
                        group.addTask {
                            do {
                                let metadata = try await self.emailMessageRepository.listDraftsMetadataForEmailAddressId(emailAddressId: account.id)
                                return metadata
                            } catch {
                                throw error
                            }
                        }
                    }
                    for try await localMetadata in group {
                        result.append(contentsOf: localMetadata)
                    }
                }
            } catch {
                throw error
            }
        } while nextToken != nil

        let transformer = DraftEmailMetadataEntityTransformer()
        return result.map(transformer.transform(_:))
    }
}
