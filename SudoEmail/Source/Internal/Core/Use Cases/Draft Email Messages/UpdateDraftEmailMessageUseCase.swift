//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging

class UpdateDraftEmailMessageUseCase {

    // MARK: - Properties

    let emailMessageRepository: EmailMessageRepository
    let emailAccountRepository: EmailAccountRepository
    let emailDomainRepository: DomainRepository
    let emailConfigDataRepository: EmailConfigurationDataRepository
    let emailCryptoService: EmailCryptoService
    let emailMessageUnsealerService: EmailMessageUnsealerService
    let rfc822MessageDataProcessor: Rfc822MessageDataProcessor
    var logger: Logger

    // MARK: - Lifecycle

    init(
        emailMessageRepository: EmailMessageRepository,
        emailAccountRepository: EmailAccountRepository,
        emailDomainRepository: DomainRepository,
        emailConfigDataRepository: EmailConfigurationDataRepository,
        emailCryptoService: EmailCryptoService,
        emailMessageUnsealerService: EmailMessageUnsealerService,
        rfc822MessageDataProcessor: Rfc822MessageDataProcessor,
        logger: Logger = .emailSDKLogger
    ) {
        self.emailMessageRepository = emailMessageRepository
        self.emailAccountRepository = emailAccountRepository
        self.emailDomainRepository = emailDomainRepository
        self.emailConfigDataRepository = emailConfigDataRepository
        self.emailCryptoService = emailCryptoService
        self.emailMessageUnsealerService = emailMessageUnsealerService
        self.rfc822MessageDataProcessor = rfc822MessageDataProcessor
        self.logger = logger
    }

    // MARK: - Methods

    func execute(
        withInput input: UpdateDraftEmailMessageInput
    ) async throws -> DraftEmailMessageMetadata {
        guard try (
            await emailAccountRepository.fetchWithEmailAddressId(input.senderEmailAddressId)
        ) != nil else {
            throw SudoEmailError.addressNotFound
        }
        if try !(await emailMessageRepository.draftExists(
            id: input.id,
            emailAddressId: input.senderEmailAddressId
        )) {
            throw SudoEmailError.emailMessageNotFound
        }

        var rfc822Data = input.rfc822Data
        let config = try await emailConfigDataRepository.getConfigurationData()
        let emailMessageUtil = EmailMessageUtil(
            emailAccountRepository: emailAccountRepository,
            emailDomainRepository: emailDomainRepository,
            emailCryptoService: emailCryptoService,
            rfc822MessageDataProcessor: rfc822MessageDataProcessor,
            logger: logger
        )

        rfc822Data = try await emailMessageUtil.processMessageForUpload(data: rfc822Data, config: config)

        let metadata = try await emailMessageRepository.saveDraft(
            rfc822Data: rfc822Data,
            senderEmailAddressId: input.senderEmailAddressId,
            id: input.id
        )
        return DraftEmailMessageMetadata(
            id: metadata.id,
            emailAddressId: metadata.emailAddressId,
            updatedAt: metadata.updatedAt
        )
    }
}
