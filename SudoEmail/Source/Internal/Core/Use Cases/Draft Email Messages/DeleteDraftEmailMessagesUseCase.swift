//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

class DeleteDraftEmailMessagesUseCase {

    // MARK: - Properties

    let emailMessageRepository: EmailMessageRepository
    let emailAccountRepository: EmailAccountRepository
    let logger: Logger

    // MARK: - Lifecycle

    init(
        emailMessageRepository: EmailMessageRepository,
        emailAccountRepository: EmailAccountRepository
    ) {
        self.emailMessageRepository = emailMessageRepository
        self.emailAccountRepository = emailAccountRepository
        logger = .emailSDKLogger
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - withInput: Input containing `ids` list and `emailAddressId` of the draft email messages to be deleted.
    /// - Returns: The results of the delete operation:
    ///     - status:
    ///         - Success - All email messages succeeded to delete.
    ///         - Partial - Only a partial amount of draft messages succeeded to delete. Result includes two lists;
    ///           one containing success results and the other containing failure results.
    ///         - Failure - All email messages failed to delete. Result contains a list of identifiers of email messages
    ///           that failed to delete.
    ///     - successItems - A list of the identifiers of the email messages that were successfully deleted.
    ///     - failureItems - A list of the id and errorType of each email message that failed to be deleted.
    func execute(
        withInput input: DeleteDraftEmailMessagesInput
    ) async throws -> BatchOperationResult<String, EmailMessageOperationFailureResult> {
        guard try (await emailAccountRepository.fetchWithEmailAddressId(input.emailAddressId)) != nil else {
            throw SudoEmailError.addressNotFound
        }
        guard !input.ids.isEmpty else {
            return BatchOperationResult(status: .success)
        }
        let result = await deleteDraftEmailMessages(withIds: input.ids, emailAddressId: input.emailAddressId)
        Task {
            await cancelScheduledDraftMessages(withIds: result.successItems, emailAddressId: input.emailAddressId)
        }
        return result
    }

    // MARK: - Helpers

    func deleteDraftEmailMessages(
        withIds ids: [String],
        emailAddressId: String
    ) async -> BatchOperationResult<String, EmailMessageOperationFailureResult> {
        return await withTaskGroup(of: Result<String, EmailMessageOperationFailureResult>.self) { taskGroup in
            for id in ids {
                taskGroup.addTask {
                    do {
                        let deletedId = try await self.emailMessageRepository.deleteDraft(id: id, emailAddressId: emailAddressId)
                        return .success(deletedId)
                    } catch {
                        self.logger.error("Failed to delete draft \(id) with \(error)")
                        return .failure(EmailMessageOperationFailureResult(id: id, errorType: error.localizedDescription))
                    }
                }
            }
            var results: [Result<String, EmailMessageOperationFailureResult>] = []
            for await result in taskGroup {
                results.append(result)
            }
            let deletedIds = results.compactMap(\.value)
            let failures = results.compactMap(\.error)

            let status: BatchOperationResultStatus = switch ids.count {
            case deletedIds.count:
                .success
            case failures.count:
                .failure
            default:
                .partial
            }
            return BatchOperationResult(status: status, successItems: deletedIds, failureItems: failures)
        }
    }

    func cancelScheduledDraftMessages(withIds ids: [String]?, emailAddressId: String) async {
        guard let ids, !ids.isEmpty else {
            return
        }
        return await withTaskGroup(of: Void.self) { taskGroup in
            for id in ids {
                taskGroup.addTask {
                    do {
                        let input = CancelScheduledDraftMessageInput(id: id, emailAddressId: emailAddressId)
                        _ = try await self.emailMessageRepository.cancelScheduledDraftMessage(withInput: input)
                        self.logger.debug("Successfully cancelled scheduled draft \(id) if it existed")
                    } catch {
                        self.logger.error("Failed to cancel scheduled draft \(id) with \(error)")
                    }
                }
            }
        }
    }
}
