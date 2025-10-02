//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import SudoApiClient
import SudoLogging
import SudoUser

/// Default Client API Endpoint for interacting with the Email Service.
public class DefaultSudoEmailClient: SudoEmailClient {

    private enum Constants {
        static let awsS3WorkerKey = "com.sudoplatform.email.s3"
        static let emailAudience = "sudoplatform.email.email-address"
    }

    // MARK: - Properties

    /// Used to make GraphQL requests to AWS. Injected into operations to delegate the calls.
    let graphQLClient: SudoApiClient

    let userClient: SudoUserClient

    /// Used to log diagnostic and error information.
    let logger: SudoLogging.Logger

    /// Utility factory class to generate use cases.
    let useCaseFactory: UseCaseFactory

    // MARK: - Properties: Workers

    let awsS3Worker: AWSS3Worker

    // MARK: - Properties: Repositories

    let serviceKeyWorker: ServiceKeyWorker

    let emailAccountRepository: EmailAccountRepository

    let emailFolderRepository: EmailFolderRepository

    let emailMessageRepository: EmailMessageRepository

    let blockedAddressRepository: BlockedAddressRepository

    let domainRepository: DomainRepository

    let emailConfigurationDataRepository: EmailConfigurationDataRepository

    // MARK: - Properties: Services

    let emailMessageUnsealerService: EmailMessageUnsealerService

    let emailCryptoService: EmailCryptoService

    // MARK: - Properties: Utility

    let rfc822MessageDataProcessor: Rfc822MessageDataProcessor

    let subscriptionManager: SubscriptionManager

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultSudoEmailClient`. It uses configuration parameters defined in `sudoplatformconfig.json` file located in the app
    /// bundle.
    /// - Parameters:
    ///   - keyNamespace: Namespace to use for the keys and passwords. This should be left as the default property.
    ///   - userClient: SudoUserClient instance used for authentication.
    /// Throws:
    ///     - `SudoEmailError` if invalid config.
    public convenience init(keyNamespace: String = SudoEmailCommon.Constants.defaultKeyNamespace, userClient: SudoUserClient) throws {
        try self.init(config: nil, keyNamespace: keyNamespace, userClient: userClient)
    }

    convenience init(
        config: SudoEmailConfig?,
        keyNamespace: String = SudoEmailCommon.Constants.defaultKeyNamespace,
        userClient: SudoUserClient
    ) throws {
        let graphQLClient: SudoApiClient
        if let config {
            let clientConfig = SudoApiClientConfig(apiName: "emService", apiUrl: config.endpoint, region: config.region)
            try graphQLClient = DefaultSudoApiClient(config: clientConfig, sudoUserClient: userClient, logger: .emailSDKLogger)
        } else {
            guard let asClient = try SudoApiClientManager.instance?.getClient(
                sudoUserClient: userClient,
                configNamespace: "emService"
            ) else {
                throw SudoEmailError.invalidConfig
            }
            graphQLClient = asClient
        }

        // Setup utility classes / workers
        let serviceKeyWorker = DefaultServiceKeyWorker(keyNamespace: keyNamespace, userClient: userClient)
        let emailMessageUnsealerService = DefaultEmailMessageUnsealerService(deviceKeyWorker: serviceKeyWorker, logger: Logger.emailSDKLogger)
        let emailConfig = try Bundle.main.loadEmailConfig()
        let s3Region = emailConfig.region
        let rfc822MessageDataProcessor = Rfc822MessageDataProcessor()
        // Setup Services
        let emailCryptoService = DefaultEmailCryptoService(deviceKeyWorker: serviceKeyWorker)
        // Setup Repositories
        let emailAccountRepository = DefaultEmailAccountRepository(appSyncClient: graphQLClient, deviceKeyWorker: serviceKeyWorker)
        let emailFolderRepository = DefaultEmailFolderRepository(appSyncClient: graphQLClient, deviceKeyWorker: serviceKeyWorker)
        let awsS3Worker = try DefaultAWSS3Worker(region: s3Region)
        let emailMessageRepository = DefaultEmailMessageRepository(
            unsealer: emailMessageUnsealerService,
            sudoApiClient: graphQLClient,
            emailBucket: emailConfig.bucket,
            transientBucket: emailConfig.transientBucket,
            region: s3Region,
            userClient: userClient,
            s3Worker: awsS3Worker,
            emailCryptoService: emailCryptoService,
            rfc822MessageDataProcessor: rfc822MessageDataProcessor,
            deviceKeyWorker: serviceKeyWorker
        )
        let blockedAddressRepository = DefaultBlockedAddressRepository(appSyncClient: graphQLClient, keyWorker: serviceKeyWorker)
        let domainRepository = DefaultDomainRepsitory(appSyncClient: graphQLClient)
        let emailConfigurationDataRepository = DefaultEmailConfigurationDataRepository(
            appSyncClient: graphQLClient
        )
        let subscriptionManager = DefaultSubscriptionManager(
            graphQLClient: graphQLClient,
            unsealer: emailMessageUnsealerService,
            logger: .emailSDKLogger
        )
        self.init(
            keyNamespace: keyNamespace,
            graphQLClient: graphQLClient,
            userClient: userClient,
            emailAccountRepository: emailAccountRepository,
            emailFolderRepository: emailFolderRepository,
            emailMessageRepository: emailMessageRepository,
            domainRepository: domainRepository,
            emailConfigurationDataRepository: emailConfigurationDataRepository,
            emailMessageUnsealerService: emailMessageUnsealerService,
            emailCryptoService: emailCryptoService,
            serviceKeyWorker: serviceKeyWorker,
            awsS3Worker: awsS3Worker,
            blockedAddressRepository: blockedAddressRepository,
            rfc822MessageDataProcessor: rfc822MessageDataProcessor,
            subscriptionManager: subscriptionManager
        )
    }

    /// Initialize an instance of `DefaultSudoEmailClient`.
    ///
    /// This is used internally for injection and mock testing.
    init(
        keyNamespace: String,
        graphQLClient: SudoApiClient,
        userClient: SudoUserClient,
        useCaseFactory: UseCaseFactory = UseCaseFactory(),
        emailAccountRepository: EmailAccountRepository,
        emailFolderRepository: EmailFolderRepository,
        emailMessageRepository: EmailMessageRepository,
        domainRepository: DomainRepository,
        emailConfigurationDataRepository: EmailConfigurationDataRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService,
        emailCryptoService: EmailCryptoService,
        serviceKeyWorker: ServiceKeyWorker,
        awsS3Worker: AWSS3Worker,
        logger: SudoLogging.Logger = .emailSDKLogger,
        blockedAddressRepository: BlockedAddressRepository,
        rfc822MessageDataProcessor: Rfc822MessageDataProcessor,
        subscriptionManager: SubscriptionManager
    ) {
        self.graphQLClient = graphQLClient
        self.userClient = userClient
        self.logger = logger
        self.useCaseFactory = useCaseFactory
        self.emailAccountRepository = emailAccountRepository
        self.emailFolderRepository = emailFolderRepository
        self.emailMessageRepository = emailMessageRepository
        self.domainRepository = domainRepository
        self.emailConfigurationDataRepository = emailConfigurationDataRepository
        self.emailMessageUnsealerService = emailMessageUnsealerService
        self.emailCryptoService = emailCryptoService
        self.serviceKeyWorker = serviceKeyWorker
        self.awsS3Worker = awsS3Worker
        self.blockedAddressRepository = blockedAddressRepository
        self.rfc822MessageDataProcessor = rfc822MessageDataProcessor
        self.subscriptionManager = subscriptionManager
    }

    public func reset() async throws {
        logger.info("Resetting client state.")
        try serviceKeyWorker.removeAllKeys()
        await subscriptionManager.unsubscribeAll()
    }

    // MARK: - SudoEmailClient

    public func provisionEmailAddress(
        withInput input: ProvisionEmailAddressInput
    ) async throws -> EmailAddress {
        let provisionEmailAccountUseCase = useCaseFactory.generateProvisionEmailAccountUseCase(
            keyWorker: serviceKeyWorker,
            emailAccountRepository: emailAccountRepository,
            keyId: input.keyId,
            logger: logger
        )
        let emailAddressransformer = EmailAddressEntityTransformer()
        let emailAddressEntity = try emailAddressransformer.transform(input.emailAddress, alias: input.alias)

        let emailAccount = try await provisionEmailAccountUseCase.execute(
            emailAddress: emailAddressEntity,
            ownershipProofToken: input.ownershipProofToken
        )
        let apiTransformer = EmailAddressAPITransformer(deviceKeyWorker: serviceKeyWorker)
        let emailAddress = apiTransformer.transform(emailAccount)
        return emailAddress
    }

    public func deprovisionEmailAddress(_ id: String) async throws -> EmailAddress {
        let useCase = useCaseFactory.generateDeprovisionEmailAccountUseCase(emailAccountRepository: emailAccountRepository)
        let emailAccount = try await useCase.execute(emailAccountId: id)

        let apiTransformer = EmailAddressAPITransformer(deviceKeyWorker: serviceKeyWorker)
        let emailAddress = apiTransformer.transform(emailAccount)
        return emailAddress
    }

    public func updateEmailAddressMetadata(withInput input: UpdateEmailAddressMetadataInput) async throws -> String {
        let useCase = useCaseFactory.generateUpdateEmailAccountMetadataUseCase(
            emailAccountRepository: emailAccountRepository
        )
        let emailAccountId = try await useCase.execute(emailAccountId: input.id, values: input.values)
        return emailAccountId
    }

    public func sendEmailMessage(withInput input: SendEmailMessageInput) async throws -> SendEmailMessageResult {
        let useCase = useCaseFactory.generateSendEmailMessageUseCase(
            emailAccountRepository: emailAccountRepository,
            emailMessageRepository: emailMessageRepository,
            emailDomainRepository: domainRepository,
            emailConfigDataRepository: emailConfigurationDataRepository,
            emailCryptoService: emailCryptoService,
            emailMessageUnsealerService: emailMessageUnsealerService,
            rfc822MessageDataProcessor: rfc822MessageDataProcessor
        )
        return try await useCase.execute(withInput: input)
    }

    public func deleteEmailMessages(withIds ids: [String]) async throws
        -> BatchOperationResult<DeleteEmailMessageSuccessResult, EmailMessageOperationFailureResult> {
        let useCase = useCaseFactory.generateDeleteEmailMessagesUseCase(
            emailMessageRepository: emailMessageRepository,
            emailConfigRepository: emailConfigurationDataRepository
        )
        let deleteResult = try await useCase.execute(withIds: ids)
        let successItems = deleteResult.successItems != nil ? deleteResult.successItems?.map { DeleteEmailMessageSuccessResult(id: $0) } : []
        let result = BatchOperationResult(
            status: deleteResult.status,
            successItems: successItems,
            failureItems: deleteResult.failureItems
        )
        return result
    }

    public func deleteEmailMessage(withId id: String) async throws -> DeleteEmailMessageSuccessResult? {
        let useCase = useCaseFactory.generateDeleteEmailMessagesUseCase(
            emailMessageRepository: emailMessageRepository,
            emailConfigRepository: emailConfigurationDataRepository
        )
        let result = try await useCase.execute(withIds: [id])
        switch result.status {
        case .success:
            return DeleteEmailMessageSuccessResult(id: id)
        default:
            return nil
        }
    }

    public func updateEmailMessages(
        withInput input: UpdateEmailMessagesInput
    ) async throws -> BatchOperationResult<UpdatedEmailMessageSuccess, EmailMessageOperationFailureResult> {
        let useCase = useCaseFactory.generateUpdateEmailMessagesUseCase(
            emailMessageRepository: emailMessageRepository,
            emailConfigRepository: emailConfigurationDataRepository
        )
        return try await useCase.execute(withInput: input)
    }

    public func createDraftEmailMessage(
        withInput input: CreateDraftEmailMessageInput
    ) async throws -> DraftEmailMessageMetadata {
        let useCase = useCaseFactory.generateCreateDraftEmailMessageUseCase(
            emailMessageRepository: emailMessageRepository,
            emailAccountRepository: emailAccountRepository,
            emailDomainRepository: domainRepository,
            emailConfigDataRepository: emailConfigurationDataRepository,
            emailCryptoService: emailCryptoService,
            emailMessageUnsealerService: emailMessageUnsealerService,
            rfc822MessageDataProcessor: rfc822MessageDataProcessor,
            logger: logger
        )
        return try await useCase.execute(withInput: input)
    }

    public func updateDraftEmailMessage(
        withInput input: UpdateDraftEmailMessageInput
    ) async throws -> DraftEmailMessageMetadata {
        let useCase = useCaseFactory.generateUpdateDraftEmailMessageUseCase(
            emailMessageRepository: emailMessageRepository,
            emailAccountRepository: emailAccountRepository,
            emailDomainRepository: domainRepository,
            emailConfigDataRepository: emailConfigurationDataRepository,
            emailCryptoService: emailCryptoService,
            emailMessageUnsealerService: emailMessageUnsealerService,
            rfc822MessageDataProcessor: rfc822MessageDataProcessor,
            logger: logger
        )
        return try await useCase.execute(withInput: input)
    }

    public func deleteDraftEmailMessages(
        withInput input: DeleteDraftEmailMessagesInput
    ) async throws -> BatchOperationResult<DeleteEmailMessageSuccessResult, EmailMessageOperationFailureResult> {
        let useCase = useCaseFactory.generateDeleteDraftEmailMessagesUseCase(
            emailMessageRepository: emailMessageRepository,
            emailAccountRepository: emailAccountRepository
        )

        let deleteResult = try await useCase.execute(withInput: input)
        let successItems = deleteResult.successItems != nil ? deleteResult.successItems?.map { DeleteEmailMessageSuccessResult(id: $0) } : []

        let result = BatchOperationResult(
            status: deleteResult.status,
            successItems: successItems,
            failureItems: deleteResult.failureItems
        )
        return result
    }

    public func scheduleSendDraftMessage(
        withInput input: ScheduleSendDraftMessageInput
    ) async throws -> ScheduledDraftMessage {
        let useCase = useCaseFactory.generateScheduleSendDraftMessageUseCase(
            emailMessageRepository: emailMessageRepository,
            emailAccountRepository: emailAccountRepository
        )
        let result = try await useCase.execute(withInput: input)
        return ScheduledDraftMessageApiTransformer().transform(result)
    }

    public func cancelScheduledDraftMessage(
        withInput input: CancelScheduledDraftMessageInput
    ) async throws -> String {
        let useCase = useCaseFactory.generateCancelScheduledDraftMessageUseCase(
            emailMessageRepository: emailMessageRepository,
            emailAccountRepository: emailAccountRepository
        )
        return try await useCase.execute(withInput: input)
    }

    public func listScheduledDraftMessagesForEmailAddressId(
        withInput input: ListScheduledDraftMessagesForEmailAddressIdInput
    ) async throws -> ListOutput<ScheduledDraftMessage> {
        let useCase = useCaseFactory.generateListScheduledDraftMessagesForEmailAddressIdUseCase(
            emailMessageRepository: emailMessageRepository
        )
        let result = try await useCase.execute(withInput: input)
        let transformer = ListOutputAPITransformer(deviceKeyWorker: serviceKeyWorker)
        return transformer.transformScheduledDraftMessages(result)
    }

    public func createCustomEmailFolder(withInput input: CreateCustomEmailFolderInput) async throws -> EmailFolder {
        let useCase = useCaseFactory.generateCreateCustomEmailFolderUseCase(
            emailFolderRepository: emailFolderRepository,
            emailAccountRepository: emailAccountRepository
        )
        let input = CreateCustomEmailFolderInput(emailAddressId: input.emailAddressId, customFolderName: input.customFolderName)
        let result = try await useCase.execute(withInput: input)
        let apiTransformer = EmailFolderAPITransformer()
        let customFolder = apiTransformer.transform(result)
        return customFolder
    }

    public func deleteCustomEmailFolder(withInput input: DeleteCustomEmailFolderInput) async throws -> EmailFolder? {
        let useCase = useCaseFactory.generateDeleteCustomEmailFolderUseCase(emailFolderRepository: emailFolderRepository)
        let input = DeleteCustomEmailFolderInput(emailFolderId: input.emailFolderId, emailAddressId: input.emailAddressId)
        let result = try await useCase.execute(withInput: input)
        let apiTransformer = EmailFolderAPITransformer()
        let customFolder = apiTransformer.transform(result)
        return customFolder
    }

    public func updateCustomEmailFolder(withInput input: UpdateCustomEmailFolderInput) async throws -> EmailFolder {
        let useCase = useCaseFactory.generateUpdateCustomEmailFolderUseCase(emailFolderRepository: emailFolderRepository)
        let result = try await useCase.execute(withInput: input)
        let apiTransformer = EmailFolderAPITransformer()
        let customFolder = apiTransformer.transform(result)
        return customFolder
    }

    public func importKeys(archiveData: Data) throws {
        if archiveData.isEmpty {
            throw SudoEmailError.invalidArgument("")
        }
        try serviceKeyWorker.importKeys(archiveData: archiveData)
    }

    public func exportKeys() throws -> Data {
        try serviceKeyWorker.exportKeys()
    }

    public func checkEmailAddressAvailability(withInput input: CheckEmailAddressAvailabilityInput) async throws -> [String] {
        let useCase = useCaseFactory.generateCheckEmailAddressAvailabilityUseCase(emailAccountRepository: emailAccountRepository)
        let domainTransformer = DomainEntityTransformer()
        let domainEntities = input.domains.map { $0.map(domainTransformer.transform(_:)) }
        let availableEmailAddresses = try await useCase.execute(withLocalParts: input.localParts, domains: domainEntities)
        return availableEmailAddresses.map(\.emailAddress)
    }

    public func getSupportedEmailDomains() async throws -> [String] {
        let useCase = useCaseFactory.generateFetchSupportedDomainsUseCase(domainRepository: domainRepository)
        let domainEntities = try await useCase.execute()
        return domainEntities.map { String($0.name) }
    }

    public func getConfiguredEmailDomains() async throws -> [String] {
        let useCase = useCaseFactory.generateFetchConfiguredDomainsUseCase(domainRepository: domainRepository)
        let domainEntities = try await useCase.execute()
        return domainEntities.map { String($0.name) }
    }

    public func getEmailAddress(withInput input: GetEmailAddressInput) async throws -> EmailAddress? {
        let useCase = useCaseFactory.generateFetchEmailAccountUseCase(emailAccountRepository: emailAccountRepository)
        let emailAccount = try await useCase.execute(withEmailAddressId: input.id)
        let transformer = EmailAccountEntityTransformer(deviceKeyWorker: serviceKeyWorker)
        return emailAccount != nil ? try transformer.transform(emailAccount!) : nil
    }

    public func listEmailAddresses(withInput input: ListEmailAddressesInput) async throws -> ListOutput<EmailAddress> {
        let useCase = useCaseFactory.generateListEmailAccountsUseCase(emailAccountRepository: emailAccountRepository)
        let emailAccounts = try await useCase.execute(limit: input.limit, nextToken: input.nextToken)
        let transformer = ListOutputAPITransformer(deviceKeyWorker: serviceKeyWorker)
        return transformer.transformEmailAccounts(emailAccounts)
    }

    public func listEmailAddressesForSudoId(withInput input: ListEmailAddressesForSudoIdInput) async throws -> ListOutput<EmailAddress> {
        let useCase = useCaseFactory.generateListEmailAccountsForSudoIdUseCase(emailAccountRepository: emailAccountRepository)
        let emailAccounts = try await useCase.execute(
            sudoId: input.sudoId,
            limit: input.limit,
            nextToken: input.nextToken
        )
        let transformer = ListOutputAPITransformer(deviceKeyWorker: serviceKeyWorker)
        return transformer.transformEmailAccounts(emailAccounts)
    }

    public func lookupEmailAddressesPublicInfo(withInput input: LookupEmailAddressesPublicInfoInput) async throws -> [EmailAddressPublicInfo] {
        let useCase = useCaseFactory.generateLookupEmailAddressesPublicInfoUseCase(emailAccountRepository: emailAccountRepository)
        let publicInfo = try await useCase.execute(emailAddresses: input.emailAddresses)
        let transformer = EmailAddressPublicInfoAPITransformer()
        return transformer.transform(publicInfo)
    }

    public func blockEmailAddresses(
        addresses: [String],
        action: UnsealedBlockedAddress.BlockedAddressAction,
        emailAddressId: String?,
        blockLevel: BlockedEmailAddressLevel,
    ) async throws -> BatchOperationResult<String, String> {
        logger.debug("blockEmailAddresses: \(addresses)")
        let useCase = useCaseFactory.generateBlockEmailAddressesUseCase(
            blockedAddressRepository: blockedAddressRepository,
            userClient: userClient,
            log: logger
        )
        let result = try await useCase.execute(
            addresses: addresses,
            action: action,
            emailAddressId: emailAddressId,
            blockLevel: blockLevel
        )
        return result
    }

    public func unblockEmailAddresses(addresses: [String]) async throws -> BatchOperationResult<String, String> {
        logger.debug("unblockEmailAddresses: \(addresses)")
        let useCase = useCaseFactory.generateUnblockEmailAddressesUseCase(
            blockedAddressRepository: blockedAddressRepository,
            userClient: userClient,
            log: logger
        )
        let result = try await useCase.execute(addresses: addresses)
        return result
    }

    public func unblockEmailAddressesByHashedValue(hashedValues: [String]) async throws -> BatchOperationResult<String, String> {
        logger.debug("unblockEmailAddressesByHashedValue: \(hashedValues)")
        let useCase = useCaseFactory.generateUnblockEmailAddressesByHashedValueUseCase(
            blockedAddressRepository: blockedAddressRepository,
            userClient: userClient,
            log: logger
        )
        let result = try await useCase.execute(hashedValues: hashedValues)
        return result
    }

    public func getEmailAddressBlocklist() async throws -> [UnsealedBlockedAddress] {
        logger.debug("getEmailAddressBlocklist init")
        let useCase = useCaseFactory.generateGetEmailAddressBlocklistUseCase(
            blockedAddressRepository: blockedAddressRepository,
            userClient: userClient,
            log: logger
        )
        let result = try await useCase.execute()
        return result
    }

    public func listEmailFoldersForEmailAddressId(
        withInput input: ListEmailFoldersForEmailAddressIdInput
    ) async throws -> ListOutput<EmailFolder> {
        let useCase = useCaseFactory.generateListEmailFoldersForEmailAddressIdUseCase(
            emailFolderRepository: emailFolderRepository
        )
        let emailFolders = try await useCase.execute(withInput: input)
        let transformer = ListOutputAPITransformer(deviceKeyWorker: serviceKeyWorker)
        return transformer.transformEmailFolders(emailFolders)
    }

    public func getEmailMessage(withInput input: GetEmailMessageInput) async throws -> EmailMessage? {
        let useCase = useCaseFactory.generateFetchEmailMessageUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerService
        )
        let emailMessageEntity = try await useCase.execute(withMessageId: input.id)
        let transformer = EmailMessageAPITransformer()
        return transformer.transform(emailMessageEntity)
    }

    public func listEmailMessages(
        withInput input: ListEmailMessagesInput
    ) async throws -> ListAPIResult<EmailMessage, PartialEmailMessage> {
        let sealedEmailMessageEntityTransformer = SealedEmailMessageEntityTransformer()
        let useCase = useCaseFactory.generateListEmailMessagesUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerService,
            sealedEmailMessageEntityTransformer: sealedEmailMessageEntityTransformer
        )
        let messagesResult = try await useCase.execute(withInput: input)
        let transformer = ListAPIResultTransformer()
        return transformer.transformEmailMessages(messagesResult)
    }

    public func listEmailMessagesForEmailAddressId(
        withInput input: ListEmailMessagesForEmailAddressInput
    ) async throws -> ListAPIResult<EmailMessage, PartialEmailMessage> {
        let sealedEmailMessageEntityTransformer = SealedEmailMessageEntityTransformer()
        let useCase = useCaseFactory.generateListEmailMessagesForEmailAddressIdUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerService,
            sealedEmailMessageEntityTransformer: sealedEmailMessageEntityTransformer
        )
        let messagesResult = try await useCase.execute(withInput: input)
        let transformer = ListAPIResultTransformer()
        return transformer.transformEmailMessages(messagesResult)
    }

    public func listEmailMessagesForEmailFolderId(
        withInput input: ListEmailMessagesForEmailFolderIdInput
    ) async throws -> ListAPIResult<EmailMessage, PartialEmailMessage> {
        let sealedEmailMessageEntityTransformer = SealedEmailMessageEntityTransformer()
        let useCase = useCaseFactory.generateListEmailMessagesForEmailFolderIdUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerService,
            sealedEmailMessageEntityTransformer: sealedEmailMessageEntityTransformer
        )
        let messagesResult = try await useCase.execute(withInput: input)
        let transformer = ListAPIResultTransformer()
        return transformer.transformEmailMessages(messagesResult)
    }

    @available(*, deprecated, message: "Use getEmailMessageWithBody instead to retrieve email message data")
    public func getEmailMessageRfc822Data(withInput input: GetEmailMessageRfc822DataInput) async throws -> Data {
        let useCase = useCaseFactory.generateFetchEmailMessageRFC822DataUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerService
        )
        return try await useCase.execute(withMessageId: input.id, emailAddressId: input.emailAddressId)
    }

    public func getEmailMessageWithBody(withInput input: GetEmailMessageWithBodyInput) async throws -> EmailMessageWithBody? {
        let useCase = useCaseFactory.generateGetEmailMessageWithBodyUseCase(
            emailMessageRepository: emailMessageRepository
        )
        return try await useCase.execute(withInput: input)
    }

    public func listDraftEmailMessages() async throws -> [DraftEmailMessage] {
        let useCase = useCaseFactory.generateListDraftEmailMessagesUseCase(
            emailAccountRepository: emailAccountRepository,
            emailMessageRepository: emailMessageRepository
        )
        return try await useCase.execute()
    }

    public func listDraftEmailMessagesForEmailAddressId(emailAddressId: String) async throws -> [DraftEmailMessage] {
        let useCase = useCaseFactory.generateListDraftEmailMessagesForEmailAddressIdUseCase(
            emailMessageRepository: emailMessageRepository
        )
        return try await useCase.execute(emailAddressId: emailAddressId)
    }

    public func listDraftEmailMessageMetadata() async throws -> [DraftEmailMessageMetadata] {
        let useCase = useCaseFactory.generateListDraftEmailMessageMetadataUseCase(
            emailAccountRepository: emailAccountRepository,
            emailMessageRepository: emailMessageRepository
        )
        return try await useCase.execute()
    }

    public func listDraftEmailMessageMetadataForEmailAddressId(emailAddressId: String) async throws -> [DraftEmailMessageMetadata] {
        let useCase = useCaseFactory.generateListDraftEmailMessageMetadataForEmailAddressIdUseCase(
            emailMessageRepository: emailMessageRepository
        )
        return try await useCase.execute(emailAddressId: emailAddressId)
    }

    public func getDraftEmailMessage(
        withInput input: GetDraftEmailMessageInput
    ) async throws -> DraftEmailMessage? {
        let useCase = useCaseFactory.generateGetDraftEmailMessageUseCase(
            emailMessageRepository: emailMessageRepository
        )
        return try await useCase.execute(withInput: input)
    }

    public func deleteMessagesForFolderId(withInput input: DeleteMessagesForFolderIdInput) async throws -> String {
        let useCase = useCaseFactory.generateDeleteMessagesForFolderIdUseCase(
            emailFolderRepository: emailFolderRepository
        )
        return try await useCase.execute(withInput: input)
    }

    public func getConfigurationData() async throws -> ConfigurationData {
        let useCase = useCaseFactory.generateGetConfigurationDataUseCase(
            emailConfigurationDataRepository: emailConfigurationDataRepository
        )
        let configurationDataEntity = try await useCase.execute()
        let transformer = EmailConfigurationDataEntityTransformer()
        return transformer.transform(configurationDataEntity)
    }

    public func subscribe(id: String, notificationType: SubscriptionNotificationType, subscriber: Subscriber) async throws {
        guard let owner = try? await userClient.getSubject() else {
            throw SudoEmailError.notSignedIn
        }
        await subscriptionManager.subscribe(id: id, notificationType: notificationType, subscriber: subscriber, owner: owner)
    }

    public func unsubscribe(id: String) async {
        await subscriptionManager.unsubscribe(id: id)
    }

    public func unsubscribeAll() async {
        await subscriptionManager.unsubscribeAll()
    }
}
