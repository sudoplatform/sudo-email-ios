//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSAppSync
import AWSS3
import SudoApiClient
import SudoLogging
import SudoUser

/// Default Client API Endpoint for interacting with the Email Service.
public class DefaultSudoEmailClient: SudoEmailClient {

    private struct Constants {
        static let awsS3WorkerKey = "com.sudoplatform.email.s3"
        static let emailAudience = "sudoplatform.email.email-address"
    }

    // MARK: - Properties

    /// Used to make GraphQL requests to AWS. Injected into operations to delegate the calls.
    let graphQLClient: SudoApiClient
    
    let userClient: SudoUserClient

    /// Used to log diagnostic and error information.
    let logger: Logger

    /// Utility factory class to generate use cases.
    let useCaseFactory: UseCaseFactory

    // MARK: - Properties: Workers
    let awsS3Worker: AWSS3Worker & Resetable

    // MARK: - Properties: Repositories

    let deviceKeyWorker: DeviceKeyWorker

    let emailAccountRepository: EmailAccountRepository & Resetable

    let emailFolderRepository: EmailFolderRepository & Resetable

    let emailMessageRepository: EmailMessageRepository & Resetable
    
    let blockedAddressRepository: BlockedAddressRepository & Resetable

    let domainRepository: DomainRepository

    let emailConfigurationDataRepository: EmailConfigurationDataRepository

    var allResetables: [Resetable] {
        return [
            emailAccountRepository,
            emailFolderRepository,
            emailMessageRepository,
            blockedAddressRepository,
            awsS3Worker
        ]
    }

    // MARK: - Properties: Services

    let emailMessageUnsealerServiceService: EmailMessageUnsealerService

    let emailCryptoService: EmailCryptoService
    
    let rfc822MessageDataProcessor: Rfc822MessageDataProcessor

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultSudoEmailClient`. It uses configuration parameters defined in `sudoplatformconfig.json` file located in the app
    /// bundle.
    /// - Parameters:
    ///   - keyNamespace: Namespace to use for the keys and passwords. This should be left as the default property.
    ///   - userClient: SudoUserClient instance used for authentication.
    /// Throws:
    ///     - `SudoEmailError` if invalid config.
    public convenience init(keyNamespace: String = "com.sudoplatform.email", userClient: SudoUserClient) throws {
        try self.init(config: nil, keyNamespace: keyNamespace, userClient: userClient)
    }
    
    convenience init(
        config: SudoEmailConfig?,
        keyNamespace: String = "com.sudoplatform.email",
        userClient: SudoUserClient
    ) throws {
        let graphQLClient: SudoApiClient
        if let config = config {
            let authProvider = GraphQLAuthProvider(client: userClient)
            let cacheConfiguration = try AWSAppSyncCacheConfiguration()
            let appSyncConfig = try AWSAppSyncClientConfiguration(
                appSyncServiceConfig: config,
                userPoolsAuthProvider: authProvider,
                cacheConfiguration: cacheConfiguration)
            let appSyncClient = try AWSAppSyncClient(appSyncConfig: appSyncConfig)
            try graphQLClient = SudoApiClient(
                configProvider: config,
                sudoUserClient: userClient,
                logger: Logger.sudoApiClientLogger,
                appSyncClient: appSyncClient
            )
        } else {
            guard let asClient = try SudoApiClientManager.instance?.getClient(sudoUserClient: userClient) else {
                throw SudoEmailError.invalidConfig
            }
            graphQLClient = asClient
        }

        // Setup utility classes / workers
        let deviceKeyWorker = DefaultDeviceKeyWorker(keyNamespace: keyNamespace, userClient: userClient)
        let emailMessageUnsealerService = DefaultEmailMessageUnsealerService(deviceKeyWorker: deviceKeyWorker)
        let emailConfig = try Bundle.main.loadEmailConfig()
        let s3Region = emailConfig.region
        // Setup Repositories
        let emailAccountRepository = DefaultEmailAccountRepository(appSyncClient: graphQLClient, deviceKeyWorker: deviceKeyWorker)
        let emailFolderRepository = DefaultEmailFolderRepository(appSyncClient: graphQLClient)
        let awsS3Worker = try DefaultAWSS3Worker(userClient: userClient, awsS3WorkerKey: Constants.awsS3WorkerKey)
        let emailMessageRepository = DefaultEmailMessageRepository(
            unsealer: emailMessageUnsealerService,
            appSyncClient: graphQLClient,
            emailBucket: emailConfig.bucket,
            transientBucket: emailConfig.transientBucket,
            region: s3Region,
            userClient: userClient,
            s3Worker: awsS3Worker,
            deviceKeyWorker: deviceKeyWorker
        )
        let blockedAddressRepository = DefaultBlockedAddressRepository(appSyncClient: graphQLClient, keyWorker: deviceKeyWorker)
        let domainRepository = DefaultDomainRepsitory(appSyncClient: graphQLClient)
        let emailConfigurationDataRepository = DefaultEmailConfigurationDataRepository(
            appSyncClient: graphQLClient
        )
        // Setup Services
        let emailMessageUnsealerServiceService = DefaultEmailMessageUnsealerService(deviceKeyWorker: deviceKeyWorker)
        let emailCryptoService = DefaultEmailCryptoService(deviceKeyWorker: deviceKeyWorker)
        let rfc822MessageDataProcessor = Rfc822MessageDataProcessor()
        self.init(
            keyNamespace: keyNamespace,
            graphQLClient: graphQLClient,
            userClient: userClient,
            emailAccountRepository: emailAccountRepository,
            emailFolderRepository: emailFolderRepository,
            emailMessageRepository: emailMessageRepository,
            domainRepository: domainRepository,
            emailConfigurationDataRepository: emailConfigurationDataRepository,
            emailMessageUnsealerServiceService: emailMessageUnsealerServiceService,
            emailCryptoService: emailCryptoService,
            deviceKeyWorker: deviceKeyWorker,
            awsS3Worker: awsS3Worker,
            blockedAddressRepository: blockedAddressRepository,
            rfc822MessageDataProcessor: rfc822MessageDataProcessor
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
        emailAccountRepository: EmailAccountRepository & Resetable,
        emailFolderRepository: EmailFolderRepository & Resetable,
        emailMessageRepository: EmailMessageRepository & Resetable,
        domainRepository: DomainRepository,
        emailConfigurationDataRepository: EmailConfigurationDataRepository,
        emailMessageUnsealerServiceService: EmailMessageUnsealerService,
        emailCryptoService: EmailCryptoService,
        deviceKeyWorker: DeviceKeyWorker,
        awsS3Worker: AWSS3Worker & Resetable,
        logger: Logger = .emailSDKLogger,
        blockedAddressRepository: BlockedAddressRepository & Resetable,
        rfc822MessageDataProcessor: Rfc822MessageDataProcessor
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
        self.emailMessageUnsealerServiceService = emailMessageUnsealerServiceService
        self.emailCryptoService = emailCryptoService
        self.deviceKeyWorker = deviceKeyWorker
        self.awsS3Worker = awsS3Worker
        self.blockedAddressRepository = blockedAddressRepository
        self.rfc822MessageDataProcessor = rfc822MessageDataProcessor
    }

    public func reset() throws {
        self.logger.info("Resetting client state.")
        try allResetables.forEach { try $0.reset() }
        try self.graphQLClient.clearCaches(options: .init(clearQueries: true, clearMutations: true, clearSubscriptions: true))
        try self.deviceKeyWorker.removeAllKeys()
    }

    // MARK: - SudoEmailClient

    public func provisionEmailAddress(
        withInput input: ProvisionEmailAddressInput
    ) async throws -> EmailAddress {
        let provisionEmailAccountUseCase = useCaseFactory.generateProvisionEmailAccountUseCase(
            keyWorker: deviceKeyWorker,
            emailAccountRepository: emailAccountRepository,
            keyId: input.keyId,
            logger: self.logger
        )
        let emailAddressransformer = EmailAddressEntityTransformer()
        let emailAddressEntity = try emailAddressransformer.transform(input.emailAddress, alias: input.alias)

        let emailAccount = try await provisionEmailAccountUseCase.execute(
            emailAddress: emailAddressEntity,
            ownershipProofToken: input.ownershipProofToken
        )
        let apiTransformer = EmailAddressAPITransformer()
        let emailAddress = apiTransformer.transform(emailAccount)
        return emailAddress
    }

    public func deprovisionEmailAddress(_ id: String) async throws -> EmailAddress {
        let useCase = useCaseFactory.generateDeprovisionEmailAccountUseCase(emailAccountRepository: emailAccountRepository)
        let emailAccount = try await useCase.execute(emailAccountId: id)

        let apiTransformer = EmailAddressAPITransformer()
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
            emailMessageRepository: emailMessageRepository,
            emailAccountRepository: emailAccountRepository,
            emailCryptoService: emailCryptoService,
            emailConfigDataRepository: emailConfigurationDataRepository,
            rfc822MessageDataProcessor: rfc822MessageDataProcessor
        )
        return try await useCase.execute(withInput: input)
    }

    public func deleteEmailMessages(withIds ids: [String]) async throws -> BatchOperationResult<String> {
        let useCase = useCaseFactory.generateDeleteEmailMessagesUseCase(emailMessageRepository: emailMessageRepository)
        return try await useCase.execute(withIds: ids)
    }

    public func deleteEmailMessage(withId id: String) async throws -> String? {
        let useCase = useCaseFactory.generateDeleteEmailMessagesUseCase(emailMessageRepository: emailMessageRepository)
        let result = try await useCase.execute(withIds: [id])
        switch result {
        case .success:
            return id
        default:
            return nil
        }
    }

    public func updateEmailMessages(
        withInput input: UpdateEmailMessagesInput
    ) async throws -> BatchOperationResult<String> {
        let useCase = useCaseFactory.generateUpdateEmailMessagesUseCase(emailMessageRepository: emailMessageRepository)
        return try await useCase.execute(withInput: input)
    }

    public func createDraftEmailMessage(
        withInput input: CreateDraftEmailMessageInput
    ) async throws -> DraftEmailMessageMetadata {
        let useCase = useCaseFactory.generateCreateDraftEmailMessageUseCase(
            emailMessageRepository: emailMessageRepository,
            emailAccountRepository: emailAccountRepository
        )
        return try await useCase.execute(withInput: input)
    }

    public func updateDraftEmailMessage(
        withInput input: UpdateDraftEmailMessageInput
    ) async throws -> DraftEmailMessageMetadata {
        let useCase = useCaseFactory.generateUpdateDraftEmailMessageUseCase(
            emailMessageRepository: emailMessageRepository,
            emailAccountRepository: emailAccountRepository
        )
        return try await useCase.execute(withInput: input)
    }

    public func deleteDraftEmailMessages(
        withInput input: DeleteDraftEmailMessagesInput
    ) async throws -> BatchOperationResult<String> {
        let useCase = useCaseFactory.generateDeleteDraftEmailMessagesUseCase(
            emailMessageRepository: emailMessageRepository,
            emailAccountRepository: emailAccountRepository
        )
        return try await useCase.execute(withInput: input)
    }

    public func importKeys(archiveData: Data) throws {
        if archiveData.isEmpty {
            throw SudoEmailError.invalidArgument("")
        }
        try deviceKeyWorker.importKeys(archiveData: archiveData)
    }

    public func exportKeys() throws -> Data {
        try deviceKeyWorker.exportKeys()
    }

    public func checkEmailAddressAvailability(withInput input: CheckEmailAddressAvailabilityInput) async throws -> [String] {
        let useCase = useCaseFactory.generateCheckEmailAddressAvailabilityUseCase(emailAccountRepository: emailAccountRepository)
        let domainTransformer = DomainEntityTransformer()
        let domainEntities = input.domains.map { $0.map(domainTransformer.transform(_:)) }
        let availableEmailAddresses = try await useCase.execute(withLocalParts: input.localParts, domains: domainEntities)
        return availableEmailAddresses.map { $0.emailAddress }
    }

    public func getSupportedEmailDomains(_ cachePolicy: CachePolicy) async throws -> [String] {
        var domainEntities: [DomainEntity]
        switch cachePolicy {
        case .cacheOnly:
            let useCase = useCaseFactory.generateGetSupportedDomainsUseCase(domainRepository: domainRepository)
            domainEntities = try await useCase.execute()
        case .remoteOnly:
            let useCase = useCaseFactory.generateFetchSupportedDomainsUseCase(domainRepository: domainRepository)
            domainEntities = try await useCase.execute()
        }
        return domainEntities.map { String($0.name) }
    }

    public func getEmailAddress(withInput input: GetEmailAddressInput) async throws -> EmailAddress? {
        var emailAccount: EmailAccountEntity?
        /// Execute use case based on cache policy.
        switch input.cachePolicy {
        case .cacheOnly:
            let useCase = useCaseFactory.generateGetEmailAccountUseCase(emailAccountRepository: emailAccountRepository)
            emailAccount = try await useCase.execute(withEmailAddressId: input.id)
        case .remoteOnly,
             nil:
            let useCase = useCaseFactory.generateFetchEmailAccountUseCase(emailAccountRepository: emailAccountRepository)
            emailAccount = try await useCase.execute(withEmailAddressId: input.id)
        }
        let transformer = EmailAccountEntityTransformer(deviceKeyWorker: deviceKeyWorker)
        return emailAccount != nil ? try transformer.transform(emailAccount!) : nil
    }

    public func listEmailAddresses(withInput input: ListEmailAddressesInput) async throws -> ListOutput<EmailAddress> {
        var emailAccounts: ListOutputEntity<EmailAccountEntity>
        /// Execute use case based on cache policy.
        switch input.cachePolicy {
        case .cacheOnly:
            let useCase = useCaseFactory.generateListEmailAccountsUseCase(emailAccountRepository: emailAccountRepository)
            emailAccounts = try await useCase.execute(limit: input.limit, nextToken: input.nextToken)
        case .remoteOnly,
             nil:
            let useCase = useCaseFactory.generateFetchListEmailAccountsUseCase(emailAccountRepository: emailAccountRepository)
            emailAccounts = try await useCase.execute(limit: input.limit, nextToken: input.nextToken)
        }
        let transformer = ListOutputAPITransformer()
        return transformer.transformEmailAccounts(emailAccounts)
    }

    public func listEmailAddressesForSudoId(
        withInput input: ListEmailAddressesForSudoIdInput
    ) async throws -> ListOutput<EmailAddress> {
        let useCase = useCaseFactory.generateListEmailAccountsForSudoIdUseCase(
            emailAccountRepository: emailAccountRepository
        )
        let emailAccounts = try await useCase.execute(
            sudoId: input.sudoId,
            cachePolicy: input.cachePolicy,
            limit: input.limit,
            nextToken: input.nextToken
        )
        let transformer = ListOutputAPITransformer()
        return transformer.transformEmailAccounts(emailAccounts)
    }

    public func lookupEmailAddressesPublicInfo(withInput input: LookupEmailAddressesPublicInfoInput) async throws -> [EmailAddressPublicInfo] {
        let useCase = useCaseFactory.generateLookupEmailAddressesPublicInfoUseCase(emailAccountRepository: emailAccountRepository)
        let publicInfo = try await useCase.execute(emailAddresses: input.emailAddresses, cachePolicy: input.cachePolicy)
        let transformer = EmailAddressPublicInfoAPITransformer()
        return transformer.transform(publicInfo)
    }
    
    
    public func blockEmailAddresses(addresses: [String]) async throws -> BatchOperationResult<String> {
        self.logger.debug("blockEmailAddresses: \(addresses)")
        let useCase = useCaseFactory.generateBlockEmailAddressesUseCase(
            blockedAddressRepository: blockedAddressRepository,
            userClient: userClient,
            log: self.logger
        )
        let result = try await useCase.execute(addresses: addresses)
        return result
    }
    
    public func unblockEmailAddresses(addresses: [String]) async throws -> BatchOperationResult<String> {
        self.logger.debug("unblockEmailAddresses: \(addresses)")
        let useCase = useCaseFactory.generateUnblockEmailAddressesUseCase(
            blockedAddressRepository: blockedAddressRepository,
            userClient: userClient,
            log: self.logger
        )
        let result = try await useCase.execute(addresses: addresses)
        return result
    }
    
    public func unblockEmailAddressesByHashedValue(hashedValues: [String]) async throws -> BatchOperationResult<String> {
        self.logger.debug("unblockEmailAddressesByHashedValue: \(hashedValues)")
        let useCase = useCaseFactory.generateUnblockEmailAddressesByHashedValueUseCase(
            blockedAddressRepository: blockedAddressRepository,
            userClient: userClient,
            log: self.logger
        )
        let result = try await useCase.execute(hashedValues: hashedValues)
        return result
    }
    
    public func getEmailAddressBlocklist() async throws -> [UnsealedBlockedAddress] {
        self.logger.debug("getEmailAddressBlocklist init")
        let useCase = useCaseFactory.generateGetEmailAddressBlocklistUseCase(
            blockedAddressRepository: blockedAddressRepository,
            userClient: userClient,
            log: self.logger
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
        let transformer = ListOutputAPITransformer()
        return transformer.transformEmailFolders(emailFolders)
    }

    public func getEmailMessage(withInput input: GetEmailMessageInput) async throws -> EmailMessage? {
        var emailMessageEntity: EmailMessageEntity?
        /// Execute use case based on cache policy.
        switch input.cachePolicy {
        case .cacheOnly:
            let useCase = useCaseFactory.generateGetEmailMessageUseCase(
                emailMessageRepository: emailMessageRepository,
                emailMessageUnsealerService: emailMessageUnsealerServiceService
            )
            emailMessageEntity = try await useCase.execute(withMessageId: input.id)
        case .remoteOnly,
            nil:
            let useCase = useCaseFactory.generateFetchEmailMessageUseCase(
                emailMessageRepository: emailMessageRepository,
                emailMessageUnsealerService: emailMessageUnsealerServiceService
            )
            emailMessageEntity = try await useCase.execute(withMessageId: input.id)
        }
        let transformer = EmailMessageAPITransformer()
        return transformer.transform(emailMessageEntity)
    }
    
    public func listEmailMessages(
        withInput input: ListEmailMessagesInput
    ) async throws -> ListAPIResult<EmailMessage, PartialEmailMessage> {
        let sealedEmailMessageEntityTransformer = SealedEmailMessageEntityTransformer()
        let useCase = useCaseFactory.generateListEmailMessagesUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerServiceService,
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
            emailMessageUnsealerService: emailMessageUnsealerServiceService,
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
            emailMessageUnsealerService: emailMessageUnsealerServiceService,
            sealedEmailMessageEntityTransformer: sealedEmailMessageEntityTransformer
        )
        let messagesResult = try await useCase.execute(withInput: input)
        let transformer = ListAPIResultTransformer()
        return transformer.transformEmailMessages(messagesResult)
    }

    public func getEmailMessageRfc822Data(withInput input: GetEmailMessageRfc822DataInput) async throws -> Data {
        let useCase = useCaseFactory.generateFetchEmailMessageRFC822DataUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerServiceService
        )
        return try await useCase.execute(withMessageId: input.id, emailAddressId: input.emailAddressId)
    }

    public func getEmailMessageWithBody(withInput input: GetEmailMessageWithBodyInput) async throws -> EmailMessageWithBody? {
        let useCase = useCaseFactory.generateGetEmailMessageWithBodyUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerServiceService,
            emailCryptoService: emailCryptoService,
            rfc822MessageDataProcessor: rfc822MessageDataProcessor
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

    public func getConfigurationData() async throws -> ConfigurationData {
        let useCase = useCaseFactory.generateGetConfigurationDataUseCase(
            emailConfigurationDataRepository: emailConfigurationDataRepository
        )
        let configurationDataEntity = try await useCase.execute()
        let transformer = EmailConfigurationDataEntityTransformer()
        return transformer.transform(configurationDataEntity)
    }

    public func subscribeToEmailMessageCreated(
        withDirection direction: EmailMessage.Direction? = nil,
        resultHandler: @escaping ClientCompletion<EmailMessage>
    ) async throws -> SubscriptionToken? {
        let useCase = useCaseFactory.generateSubscribeToEmailMessageCreatedUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerServiceService
        )
        let directionTransformer = EmailMessageDirectionEntityTransformer()
        let directionEntity = directionTransformer.transform(direction)
        let token = try await useCase.execute(
            withDirection: directionEntity,
            resultHandler: resultHandler
        )
        return token
    }

    public func subscribeToEmailMessageDeleted(
        withId id: String? = nil,
        resultHandler: @escaping ClientCompletion<EmailMessage>
    ) async throws -> SubscriptionToken? {
        let useCase = useCaseFactory.generateSubscribeToEmailMessageDeletedUseCase(
            emailMessageRepository: emailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerServiceService
        )
        let token = try await useCase.execute(id: id) { result in
            let transformer = EmailMessageAPITransformer()
            let result = result.map(transformer.transform(_:))
            resultHandler(result)
        }
        return token
    }

    public func unsubscribeAll() {
        let useCase = useCaseFactory.generateUnsubscribeAllUseCase(
            emailMessageRepository: emailMessageRepository
        )
        useCase.execute()
    }

}
