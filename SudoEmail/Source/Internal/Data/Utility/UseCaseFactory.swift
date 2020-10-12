//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class for generating use cases from the core level of the SDK in the consumer/API level.
class UseCaseFactory {

    func generateProvisionEmailAccountUseCase(
        ownershipProofRepository: OwnershipProofRepository,
        keyRepository: KeyRepository,
        emailAccountRepository: EmailAccountRepository
    ) -> ProvisionEmailAccountUseCase {
        return ProvisionEmailAccountUseCase(
            ownershipProofRepository: ownershipProofRepository,
            keyRepository: keyRepository,
            emailAccountRepository: emailAccountRepository
        )
    }

    func generateDeprovisionEmailAccountUseCase(emailAccountRepository: EmailAccountRepository) -> DeprovisionEmailAccountUseCase {
        return DeprovisionEmailAccountUseCase(emailAccountRepository: emailAccountRepository)
    }

    func generateFetchSupportedDomainsUseCase(domainRepository: DomainRepository) -> FetchSupportedDomainsUseCase {
        return FetchSupportedDomainsUseCase(domainRepository: domainRepository)
    }

    func generateGetSupportedDomainsUseCase(domainRepository: DomainRepository) -> GetSupportedDomainsUseCase {
        return GetSupportedDomainsUseCase(domainRepository: domainRepository)
    }

    func generateSendEmailMessageUseCase(
        sealedEmailMessageRepository: SealedEmailMessageRepository
    ) -> SendEmailMessageUseCase {
        return SendEmailMessageUseCase(sealedEmailMessageRepository: sealedEmailMessageRepository)
    }

    func generateDeleteEmailMessageUseCase(sealedEmailMessageRepository: SealedEmailMessageRepository) -> DeleteEmailMessageUseCase {
        return DeleteEmailMessageUseCase(sealedEmailMessageRepository: sealedEmailMessageRepository)
    }

    func generateCheckEmailAddressAvailabilityUseCase(emailAccountRepository: EmailAccountRepository) -> CheckEmailAddressAvailabilityUseCase {
        return CheckEmailAddressAvailabilityUseCase(emailAccountRepository: emailAccountRepository)
    }

    func generateGetEmailAccountUseCase(emailAccountRepository: EmailAccountRepository) -> GetEmailAccountUseCase {
        return GetEmailAccountUseCase(emailAccountRepository: emailAccountRepository)
    }

    func generateFetchEmailAccountUseCase(emailAccountRepository: EmailAccountRepository) -> FetchEmailAccountUseCase {
        return FetchEmailAccountUseCase(emailAccountRepository: emailAccountRepository)
    }

    func generateFetchListEmailAccountsUseCase(emailAccountRepository: EmailAccountRepository) -> FetchListEmailAccountsUseCase {
        return FetchListEmailAccountsUseCase(emailAccountRepository: emailAccountRepository)
    }

    func generateListEmailAccountsUseCase(emailAccountRepository: EmailAccountRepository) -> ListEmailAccountsUseCase {
        return ListEmailAccountsUseCase(emailAccountRepository: emailAccountRepository)
    }

    func generateFetchEmailMessageUseCase(
        sealedEmailMessageRepository: SealedEmailMessageRepository,
        keyRepository: KeyRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService
    ) -> FetchEmailMessageUseCase {
        return FetchEmailMessageUseCase(
            sealedEmailMessageRepository: sealedEmailMessageRepository,
            keyRepository: keyRepository,
            emailMessageUnsealerService: emailMessageUnsealerService
        )
    }

    func generateGetEmailMessageUseCase(
        sealedEmailMessageRepository: SealedEmailMessageRepository,
        keyRepository: KeyRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService
    ) -> GetEmailMessageUseCase {
        return GetEmailMessageUseCase(
            sealedEmailMessageRepository: sealedEmailMessageRepository,
            keyRepository: keyRepository,
            emailMessageUnsealerService: emailMessageUnsealerService
        )
    }

    func generateGetListEmailMessagesUseCase(
        sealedEmailMessageRepository: SealedEmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService
    ) -> GetListEmailMessagesUseCase {
        return GetListEmailMessagesUseCase(sealedEmailMessageRepository: sealedEmailMessageRepository, emailMessageUnsealerService: emailMessageUnsealerService)
    }

    func generateFetchListEmailMessagesUseCase(
        sealedEmailMessageRepository: SealedEmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService
    ) -> FetchListEmailMessagesUseCase {
        return FetchListEmailMessagesUseCase(
            sealedEmailMessageRepository: sealedEmailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerService
        )
    }

    func generateFetchEmailMessageRFC822DataUseCase(
        sealedEmailMessageRepository: SealedEmailMessageRepository,
        keyRepository: KeyRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService
    ) -> FetchEmailMessageRFC822DataUseCase {
        return FetchEmailMessageRFC822DataUseCase(
            sealedEmailMessageRepository: sealedEmailMessageRepository,
            keyRepository: keyRepository,
            emailMessageUnsealerService: emailMessageUnsealerService
        )
    }

    func generateSubscribeToEmailMessageCreatedUseCase(
        sealedEmailMessageRepository: SealedEmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService
    ) -> SubscribeToEmailMessageCreatedUseCase {
        return SubscribeToEmailMessageCreatedUseCase(
            sealedEmailMessageRepository: sealedEmailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerService
        )
    }

    func generateSubscribeToEmailMessageDeletedUseCase(
        sealedEmailMessageRepository: SealedEmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService
    ) -> SubscribeToEmailMessageDeletedUseCase {
        return SubscribeToEmailMessageDeletedUseCase(
            sealedEmailMessageRepository: sealedEmailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerService
        )
    }

}
