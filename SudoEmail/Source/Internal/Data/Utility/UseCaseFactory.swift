//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoLogging
import SudoUser

/// Utility class for generating use cases from the core level of the SDK in the consumer/API level.
class UseCaseFactory {

    func generateProvisionEmailAccountUseCase(
        keyWorker: ServiceKeyWorker,
        emailAccountRepository: EmailAccountRepository,
        keyId: String? = nil,
        logger: Logger
    ) -> ProvisionEmailAccountUseCase {
        return ProvisionEmailAccountUseCase(
            keyWorker: keyWorker,
            emailAccountRepository: emailAccountRepository,
            keyId: keyId,
            logger: logger
        )
    }

    func generateDeprovisionEmailAccountUseCase(emailAccountRepository: EmailAccountRepository) -> DeprovisionEmailAccountUseCase {
        return DeprovisionEmailAccountUseCase(emailAccountRepository: emailAccountRepository)
    }

    func generateUpdateEmailAccountMetadataUseCase(emailAccountRepository: EmailAccountRepository) -> UpdateEmailAccountMetadataUseCase {
        return UpdateEmailAccountMetadataUseCase(emailAccountRepository: emailAccountRepository)
    }

    func generateFetchSupportedDomainsUseCase(domainRepository: DomainRepository) -> FetchSupportedDomainsUseCase {
        return FetchSupportedDomainsUseCase(domainRepository: domainRepository)
    }

    func generateFetchConfiguredDomainsUseCase(domainRepository: DomainRepository) -> FetchConfiguredDomainsUseCase {
        return FetchConfiguredDomainsUseCase(domainRepository: domainRepository)
    }

    func generateSendEmailMessageUseCase(
        emailAccountRepository: EmailAccountRepository,
        emailMessageRepository: EmailMessageRepository,
        emailDomainRepository: DomainRepository,
        emailConfigDataRepository: EmailConfigurationDataRepository,
        emailCryptoService: EmailCryptoService,
        emailMessageUnsealerService: EmailMessageUnsealerService,
        rfc822MessageDataProcessor: Rfc822MessageDataProcessor
    ) -> SendEmailMessageUseCase {
        return SendEmailMessageUseCase(
            emailAccountRepository: emailAccountRepository,
            emailMessageRepository: emailMessageRepository,
            emailDomainRepository: emailDomainRepository,
            emailConfigDataRepository: emailConfigDataRepository,
            emailCryptoService: emailCryptoService,
            emailMessageUnsealerService: emailMessageUnsealerService,
            rfc822MessageDataProcessor: rfc822MessageDataProcessor
        )
    }

    func generateDeleteEmailMessagesUseCase(
        emailMessageRepository: EmailMessageRepository,
        emailConfigRepository: EmailConfigurationDataRepository
    ) -> DeleteEmailMessagesUseCase {
        return DeleteEmailMessagesUseCase(
            emailMessageRepository: emailMessageRepository,
            emailConfigRepository: emailConfigRepository
        )
    }

    func generateUpdateEmailMessagesUseCase(
        emailMessageRepository: EmailMessageRepository,
        emailConfigRepository: EmailConfigurationDataRepository
    ) -> UpdateEmailMessagesUseCase {
        return UpdateEmailMessagesUseCase(
            emailMessageRepository: emailMessageRepository,
            emailConfigRepository: emailConfigRepository
        )
    }

    func generateCreateDraftEmailMessageUseCase(
        emailMessageRepository: EmailMessageRepository,
        emailAccountRepository: EmailAccountRepository
    ) -> CreateDraftEmailMessageUseCase {
        return CreateDraftEmailMessageUseCase(
            emailMessageRepository: emailMessageRepository,
            emailAccountRepository: emailAccountRepository
        )
    }

    func generateUpdateDraftEmailMessageUseCase(
        emailMessageRepository: EmailMessageRepository,
        emailAccountRepository: EmailAccountRepository
    ) -> UpdateDraftEmailMessageUseCase {
        return UpdateDraftEmailMessageUseCase(
            emailMessageRepository: emailMessageRepository,
            emailAccountRepository: emailAccountRepository
        )
    }

    func generateDeleteDraftEmailMessagesUseCase(
        emailMessageRepository: EmailMessageRepository,
        emailAccountRepository: EmailAccountRepository
    ) -> DeleteDraftEmailMessagesUseCase {
        return DeleteDraftEmailMessagesUseCase(
            emailMessageRepository: emailMessageRepository,
            emailAccountRepository: emailAccountRepository
        )
    }

    func generateScheduleSendDraftMessageUseCase(
        emailMessageRepository: EmailMessageRepository,
        emailAccountRepository: EmailAccountRepository
    ) -> ScheduleSendDraftMessageUseCase {
        return ScheduleSendDraftMessageUseCase(
            emailMessageRepository: emailMessageRepository,
            emailAccountRepository: emailAccountRepository
        )
    }

    func generateCancelScheduledDraftMessageUseCase(
        emailMessageRepository: EmailMessageRepository,
        emailAccountRepository: EmailAccountRepository
    ) -> CancelScheduledDraftMessageUseCase {
        return CancelScheduledDraftMessageUseCase(
            emailMessageRepository: emailMessageRepository,
            emailAccountRepository: emailAccountRepository
        )
    }

    func generateListScheduledDraftMessagesForEmailAddressIdUseCase(
        emailMessageRepository: EmailMessageRepository
    ) -> ListScheduledDraftMessagesForEmailAddressIdUseCase {
        return ListScheduledDraftMessagesForEmailAddressIdUseCase(
            emailMessageRepository: emailMessageRepository
        )
    }

    func generateCreateCustomEmailFolderUseCase(
        emailFolderRepository: EmailFolderRepository,
        emailAccountRepository: EmailAccountRepository
    ) -> CreateCustomEmailFolderUseCase {
        return CreateCustomEmailFolderUseCase(
            emailAccountRepository: emailAccountRepository,
            emailFolderRepository: emailFolderRepository
        )
    }

    func generateDeleteCustomEmailFolderUseCase(
        emailFolderRepository: EmailFolderRepository
    ) -> DeleteCustomEmailFolderUseCase {
        return DeleteCustomEmailFolderUseCase(emailFolderRepository: emailFolderRepository)
    }

    func generateUpdateCustomEmailFolderUseCase(
        emailFolderRepository: EmailFolderRepository
    ) -> UpdateCustomEmailFolderUseCase {
        return UpdateCustomEmailFolderUseCase(emailFolderRepository: emailFolderRepository)
    }

    func generateCheckEmailAddressAvailabilityUseCase(
        emailAccountRepository: EmailAccountRepository
    ) -> CheckEmailAddressAvailabilityUseCase {
        return CheckEmailAddressAvailabilityUseCase(emailAccountRepository: emailAccountRepository)
    }

    func generateFetchEmailAccountUseCase(emailAccountRepository: EmailAccountRepository) -> FetchEmailAccountUseCase {
        return FetchEmailAccountUseCase(emailAccountRepository: emailAccountRepository)
    }

    func generateListEmailAccountsUseCase(emailAccountRepository: EmailAccountRepository) -> ListEmailAccountsUseCase {
        return ListEmailAccountsUseCase(emailAccountRepository: emailAccountRepository)
    }

    func generateListEmailAccountsForSudoIdUseCase(emailAccountRepository: EmailAccountRepository) -> ListEmailAccountsForSudoIdUseCase {
        return ListEmailAccountsForSudoIdUseCase(emailAccountRepository: emailAccountRepository)
    }

    func generateLookupEmailAddressesPublicInfoUseCase(
        emailAccountRepository: EmailAccountRepository
    ) -> LookupEmailAddressesPublicInfoUseCase {
        return LookupEmailAddressesPublicInfoUseCase(emailAccountRepository: emailAccountRepository)
    }

    func generateBlockEmailAddressesUseCase(
        blockedAddressRepository: BlockedAddressRepository,
        userClient: SudoUserClient,
        log: Logger
    ) -> BlockEmailAddressesUseCase {
        return BlockEmailAddressesUseCase(blockedAddressRepository: blockedAddressRepository, userClient: userClient, log: log)
    }

    func generateUnblockEmailAddressesUseCase(
        blockedAddressRepository: BlockedAddressRepository,
        userClient: SudoUserClient,
        log: Logger
    ) -> UnblockEmailAddressesUseCase {
        return UnblockEmailAddressesUseCase(blockedAddressRepository: blockedAddressRepository, userClient: userClient, log: log)
    }

    func generateUnblockEmailAddressesByHashedValueUseCase(
        blockedAddressRepository: BlockedAddressRepository,
        userClient: SudoUserClient,
        log: Logger
    ) -> UnblockEmailAddressesByHashedValueUseCase {
        return UnblockEmailAddressesByHashedValueUseCase(
            blockedAddressRepository: blockedAddressRepository,
            userClient: userClient,
            log: log
        )
    }

    func generateGetEmailAddressBlocklistUseCase(
        blockedAddressRepository: BlockedAddressRepository,
        userClient: SudoUserClient,
        log: Logger
    ) -> GetEmailAddressBlocklistUseCase {
        return GetEmailAddressBlocklistUseCase(
            blockedAddressRepository: blockedAddressRepository,
            userClient: userClient,
            log: log
        )
    }

    func generateListEmailFoldersForEmailAddressIdUseCase(
        emailFolderRepository: EmailFolderRepository
    ) -> ListEmailFoldersForEmailAddressIdUseCase {
        return ListEmailFoldersForEmailAddressIdUseCase(emailFolderRepository: emailFolderRepository)
    }

    func generateFetchEmailMessageUseCase(
        emailMessageRepository: EmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService
    ) -> FetchEmailMessageUseCase {
        return FetchEmailMessageUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerService
        )
    }

    func generateListEmailMessagesUseCase(
        emailMessageRepository: EmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService,
        sealedEmailMessageEntityTransformer: SealedEmailMessageEntityTransformer
    ) -> ListEmailMessagesUseCase {
        return ListEmailMessagesUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerService,
            sealedEmailMessageEntityTransformer: sealedEmailMessageEntityTransformer
        )
    }

    func generateListEmailMessagesForEmailAddressIdUseCase(
        emailMessageRepository: EmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService,
        sealedEmailMessageEntityTransformer: SealedEmailMessageEntityTransformer
    ) -> ListEmailMessagesForEmailAddrIdUseCase {
        return ListEmailMessagesForEmailAddrIdUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerService,
            sealedEmailMessageEntityTransformer: sealedEmailMessageEntityTransformer
        )
    }

    func generateListEmailMessagesForEmailFolderIdUseCase(
        emailMessageRepository: EmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService,
        sealedEmailMessageEntityTransformer: SealedEmailMessageEntityTransformer
    ) -> ListEmailMessagesForEmailFolderIdUseCase {
        return ListEmailMessagesForEmailFolderIdUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerService,
            sealedEmailMessageEntityTransformer: sealedEmailMessageEntityTransformer
        )
    }

    func generateFetchEmailMessageRFC822DataUseCase(
        emailMessageRepository: EmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService
    ) -> FetchEmailMessageRFC822DataUseCase {
        return FetchEmailMessageRFC822DataUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerService
        )
    }

    func generateGetEmailMessageWithBodyUseCase(emailMessageRepository: EmailMessageRepository) -> GetEmailMessageWithBodyUseCase {
        return GetEmailMessageWithBodyUseCase(emailMessageRepository: emailMessageRepository)
    }

    func generateListDraftEmailMessagesUseCase(
        emailAccountRepository: EmailAccountRepository,
        emailMessageRepository: EmailMessageRepository
    ) -> ListDraftEmailMessagesUseCase {
        return ListDraftEmailMessagesUseCase(
            emailAccountRepository: emailAccountRepository,
            emailMessageRepository: emailMessageRepository
        )
    }

    func generateListDraftEmailMessagesForEmailAddressIdUseCase(
        emailMessageRepository: EmailMessageRepository
    ) -> ListDraftEmailMessagesForEmailAddressIdUseCase {
        return ListDraftEmailMessagesForEmailAddressIdUseCase(emailMessageRepository: emailMessageRepository)
    }

    func generateListDraftEmailMessageMetadataUseCase(
        emailAccountRepository: EmailAccountRepository,
        emailMessageRepository: EmailMessageRepository
    ) -> ListDraftEmailMessageMetadataUseCase {
        return ListDraftEmailMessageMetadataUseCase(
            emailAccountRepository: emailAccountRepository,
            emailMessageRepository: emailMessageRepository
        )
    }

    func generateListDraftEmailMessageMetadataForEmailAddressIdUseCase(
        emailMessageRepository: EmailMessageRepository
    ) -> ListDraftEmailMessageMetadataForEmailAddressIdUseCase {
        return ListDraftEmailMessageMetadataForEmailAddressIdUseCase(emailMessageRepository: emailMessageRepository)
    }

    func generateGetDraftEmailMessageUseCase(emailMessageRepository: EmailMessageRepository) -> GetDraftEmailMessageUseCase {
        return GetDraftEmailMessageUseCase(emailMessageRepository: emailMessageRepository)
    }

    func generateDeleteMessagesForFolderIdUseCase(emailFolderRepository: EmailFolderRepository) -> DeleteMessagesForFolderIdUseCase {
        return DeleteMessagesForFolderIdUseCase(emailFolderRepository: emailFolderRepository)
    }

    func generateGetConfigurationDataUseCase(
        emailConfigurationDataRepository: EmailConfigurationDataRepository
    ) -> GetEmailConfigurationDataUseCase {
        return GetEmailConfigurationDataUseCase(emailConfigurationDataRepository: emailConfigurationDataRepository)
    }
}
