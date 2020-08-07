//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSAppSync
import AWSS3
import SudoApiClient
import SudoLogging
import SudoOperations
import SudoProfiles
import SudoUser

/// Default Client API Endpoint for interacting with the Email Service.
public class DefaultSudoEmailClient: SudoEmailClient {

    // MARK: - Properties

    /// App sync client for peforming operations against the email service.
    let appSyncClient: AWSAppSyncClient

    /// Used to log diagnostic and error information.
    let logger: Logger

    /// Utility factory class to generate use cases.
    let useCaseFactory: UseCaseFactory

    // MARK: - Properties: Repositories

    let ownershipProofRepository: OwnershipProofRepository

    let keyRepository: KeyRepository & Resetable

    let emailAccountRepository: EmailAccountRepository & Resetable

    let sealedEmailMessageRepository: SealedEmailMessageRepository & Resetable

    let domainRepository: DomainRepository & Resetable

    var allResetables: [Resetable] {
        return [
            keyRepository,
            emailAccountRepository,
            sealedEmailMessageRepository,
            domainRepository
        ]
    }

    // MARK: - Properties: Services

    let emailMessageUnsealerServiceService: EmailMessageUnsealerService

    // MARK: - Lifecycle

    /// Initialize an instance of `DefaultSudoEmailClient`. It uses configuration parameters defined in `sudoplatformconfig.json` file located in the app
    /// bundle.
    /// - Parameters:
    ///   - keyNamespace: Namespace to use for the keys and passwords. Typically this is the application name.
    ///   - userClient: SudoUserClient instance used for authentication.
    ///   - profilesClient: SudoProfilesClient instance used for verifying sudo ownership proof.
    /// Throws:
    ///     - `SudoEmailError` if invalid config.
    public convenience init(keyNamespace: String, userClient: SudoUserClient, profilesClient: SudoProfilesClient) throws {
        guard let appSyncClient = try ApiClientManager.instance?.getClient(sudoUserClient: userClient) else {
            throw SudoEmailError.invalidConfig
        }
        // Setup utility classes / workers
        let deviceKeyWorker = DefaultDeviceKeyWorker(keyNamespace: keyNamespace, userClient: userClient)
        let emailMessageUnsealerService = DefaultEmailMessageUnsealerService(deviceKeyWorker: deviceKeyWorker)
        let identityConfig = try Bundle.main.loadIdentityConfig()
        guard let s3Region = identityConfig.region.string else {
            throw SudoEmailError.invalidConfig
        }
        // Setup Repositories
        let ownershipProofRepository = ProfilesOwnershipProofRepository(profilesClient: profilesClient)
        let keyRepository = DefaultKeyRepository(appSyncClient: appSyncClient, deviceKeyWorker: deviceKeyWorker)
        let emailAccountRepository = DefaultEmailAccountRepository(appSyncClient: appSyncClient)
        let sealedEmailMessageRepository = DefaultSealedEmailMessageRepository(
            unsealer: emailMessageUnsealerService,
            appSyncClient: appSyncClient,
            identityBucket: identityConfig.bucket,
            transientBucket: identityConfig.transientBucket,
            region: s3Region,
            userClient: userClient
        )
        let domainRepository = DefaultDomainRepsitory(appSyncClient: appSyncClient)
        // Setup Services
        let emailMessageUnsealerServiceService = DefaultEmailMessageUnsealerService(deviceKeyWorker: deviceKeyWorker)
        self.init(
            keyNamespace: keyNamespace,
            appSyncClient: appSyncClient,
            userClient: userClient,
            profilesClient: profilesClient,
            ownershipProofRepository: ownershipProofRepository,
            keyRepository: keyRepository,
            emailAccountRepository: emailAccountRepository,
            sealedEmailMessageRepository: sealedEmailMessageRepository,
            domainRepository: domainRepository,
            emailMessageUnsealerServiceService: emailMessageUnsealerServiceService
        )
    }

    /// Initialize an instance of `DefaultSudoEmailClient`.
    ///
    /// This is used internally for injection and mock testing.
    init(
        keyNamespace: String,
        appSyncClient: AWSAppSyncClient,
        userClient: SudoUserClient,
        profilesClient: SudoProfilesClient,
        useCaseFactory: UseCaseFactory = UseCaseFactory(),
        ownershipProofRepository: OwnershipProofRepository,
        keyRepository: KeyRepository & Resetable,
        emailAccountRepository: EmailAccountRepository & Resetable,
        sealedEmailMessageRepository: SealedEmailMessageRepository & Resetable,
        domainRepository: DomainRepository & Resetable,
        emailMessageUnsealerServiceService: EmailMessageUnsealerService,
        logger: Logger = .emailSDKLogger
    ) {
        self.appSyncClient = appSyncClient
        self.logger = logger
        self.useCaseFactory = useCaseFactory
        self.ownershipProofRepository = ownershipProofRepository
        self.keyRepository = keyRepository
        self.emailAccountRepository = emailAccountRepository
        self.sealedEmailMessageRepository = sealedEmailMessageRepository
        self.domainRepository = domainRepository
        self.emailMessageUnsealerServiceService = emailMessageUnsealerServiceService
    }

    public func reset() throws {
        allResetables.forEach { $0.reset() }
        try self.appSyncClient.clearCaches(options: .init(clearQueries: true, clearMutations: true, clearSubscriptions: true))
        AWSS3TransferUtility.removeS3TransferUtilityForEmailSDK()
    }

    // MARK: - SudoEmailClient

    public func provisionEmailAddress(_ emailAddress: String, sudoId: String, completion: @escaping ClientCompletion<EmailAddress>) {
        let provisionEmailAccountUseCase = useCaseFactory.generateProvisionEmailAccountUseCase(
            ownershipProofRepository: ownershipProofRepository,
            keyRepository: keyRepository,
            emailAccountRepository: emailAccountRepository
        )
        let emailAddressEntity: EmailAddressEntity
        do {
            let transformer = EmailAddressEntityTransformer()
            emailAddressEntity = try transformer.transform(emailAddress)
        } catch {
            completion(.failure(error))
            return
        }
        provisionEmailAccountUseCase.execute(emailAddress: emailAddressEntity, sudoId: sudoId) { result in
            let transformer = EmailAddressAPITransformer()
            let result = result.map(transformer.transform(_:))
            completion(result)
        }
    }

    public func deprovisionEmailAddress(_ emailAddress: String, completion: @escaping ClientCompletion<EmailAddress>) {
        let useCase = useCaseFactory.generateDeprovisionEmailAccountUseCase(emailAccountRepository: emailAccountRepository)
        let transformer = EmailAddressEntityTransformer()
        let entity: EmailAddressEntity
        do {
            entity = try transformer.transform(emailAddress)
        } catch {
            completion(.failure(error))
            return
        }
        useCase.execute(emailAddress: entity) { result in
            let transformer = EmailAddressAPITransformer()
            let result = result.map(transformer.transform(_:))
            completion(result)
        }
    }

    public func sendEmailMessage(withRFC822Data data: Data, senderEmailAddress: String, completion: @escaping ClientCompletion<String>) {
        let useCase = useCaseFactory.generateSendEmailMessageUseCase(
            emailAccountRepository: emailAccountRepository,
            sealedEmailMessageRepository: sealedEmailMessageRepository
        )
        let emailAddressEntity: EmailAddressEntity
        do {
            let transformer = EmailAddressEntityTransformer()
            emailAddressEntity = try transformer.transform(senderEmailAddress)
        } catch {
            completion(.failure(error))
            return
        }
        useCase.execute(withRFC822Data: data, emailAddress: emailAddressEntity, completion: completion)
    }

    public func deleteEmailMessage(withId id: String, completion: @escaping ClientCompletion<String>) {
        let useCase = useCaseFactory.generateDeleteEmailMessageUseCase(sealedEmailMessageRepository: sealedEmailMessageRepository)
        useCase.execute(withId: id, completion: completion)
    }

    public func getSupportedEmailDomainsWithCachePolicy(_ cachePolicy: CachePolicy, completion: @escaping ClientCompletion<[String]>) {
        let useCaseCompletion: ClientCompletion<[DomainEntity]> = { result in
            let result = result.map { $0.map { String($0.name) }}
            completion(result)
        }
        switch cachePolicy {
        case .cacheOnly:
            let useCase = useCaseFactory.generateGetSupportedDomainsUseCase(domainRepository: domainRepository)
            useCase.execute(completion: useCaseCompletion)
        case .remoteOnly:
            let useCase = useCaseFactory.generateFetchSupportedDomainsUseCase(domainRepository: domainRepository)
            useCase.execute(completion: useCaseCompletion)
        }
    }

    public func getEmailAddressWithAddress(_ address: String, cachePolicy: CachePolicy, completion: @escaping ClientCompletion<EmailAddress?>) {
        /// Setup completion for either use case.
        let useCaseCompletion: ClientCompletion<EmailAccountEntity?> = { result in
            let transformer = EmailAddressAPITransformer()
            let result = result.map(transformer.transform(_:))
            completion(result)
        }
        let emailAddressEntity: EmailAddressEntity
        do {
            let emailAddressTransformer = EmailAddressEntityTransformer()
            emailAddressEntity = try emailAddressTransformer.transform(address)
        } catch {
            completion(.failure(error))
            return
        }
        /// Execute use case based on cache policy.
        switch cachePolicy {
        case .cacheOnly:
            let useCase = useCaseFactory.generateGetEmailAccountUseCase(emailAccountRepository: emailAccountRepository)
            useCase.execute(withEmailAddress: emailAddressEntity, completion: useCaseCompletion)
        case .remoteOnly:
            let useCase = useCaseFactory.generateFetchEmailAccountUseCase(emailAccountRepository: emailAccountRepository)
            useCase.execute(withEmailAddress: emailAddressEntity, completion: useCaseCompletion)
        }
    }

    public func listEmailAddressesWithFilter(
        _ filter: EmailAddressFilter?,
        limit: Int?,
        nextToken: String?,
        cachePolicy: CachePolicy,
        completion: @escaping ClientCompletion<ListOutput<EmailAddress>>
    ) {
        /// Setup completion for either use case.
        let useCaseCompletion: ClientCompletion<ListOutputEntity<EmailAccountEntity>> = { result in
            let transformer = ListOutputAPITransformer()
            let result = result.map(transformer.transformEmailAccounts(_:))
            completion(result)
        }
        /// Transform filter to core entity type if possible.
        var entityFilter: EmailAccountFilterEntity?
        if let filter = filter {
            let filterTransformer = EmailAccountFilterEntityTransformer()
            entityFilter = filterTransformer.transform(filter)
        }
        /// Execute use case based on cache policy.
        switch cachePolicy {
        case .cacheOnly:
            let useCase = useCaseFactory.generateListEmailAccountsUseCase(emailAccountRepository: emailAccountRepository)
            useCase.execute(withFilter: entityFilter, limit: limit, nextToken: nextToken, completion: useCaseCompletion)
        case .remoteOnly:
            let useCase = useCaseFactory.generateFetchListEmailAccountsUseCase(emailAccountRepository: emailAccountRepository)
            useCase.execute(withFilter: entityFilter, limit: limit, nextToken: nextToken, completion: useCaseCompletion)
        }
    }

    public func getEmailMessageWithId(_ messageId: String, cachePolicy: CachePolicy, completion: @escaping ClientCompletion<EmailMessage?>) {
        /// Setup completion for either use case.
        let useCaseCompletion: ClientCompletion<EmailMessageEntity?> = { result in
            let transformer = EmailMessageAPITransformer()
            let result = result.map(transformer.transform(_:))
            completion(result)
        }
        /// Execute use case based on cache policy.
        switch cachePolicy {
        case .cacheOnly:
            let useCase = useCaseFactory.generateGetEmailMessageUseCase(
                sealedEmailMessageRepository:
                sealedEmailMessageRepository,
                keyRepository: keyRepository,
                emailMessageUnsealerService: emailMessageUnsealerServiceService
            )
            useCase.execute(withMessageId: messageId, completion: useCaseCompletion)
        case .remoteOnly:
            let useCase = useCaseFactory.generateFetchEmailMessageUseCase(
                sealedEmailMessageRepository: sealedEmailMessageRepository,
                keyRepository: keyRepository,
                emailMessageUnsealerService: emailMessageUnsealerServiceService
            )
            useCase.execute(withMessageId: messageId, completion: useCaseCompletion)
        }
    }

    public func listEmailMessagesWithFilter(
        _ filter: EmailMessageFilter?,
        limit: Int?,
        nextToken: String?,
        cachePolicy: CachePolicy,
        completion: @escaping ClientCompletion<ListOutput<EmailMessage>>
    ) {
        /// Setup completion for either use case.
        let useCaseCompletion: ClientCompletion<ListOutputEntity<EmailMessageEntity>> = { result in
            let transformer = ListOutputAPITransformer()
            let result = result.map(transformer.transformEmailMessages(_:))
            completion(result)
        }
        /// Transform filter to core entity type if possible.
        var entityFilter: EmailMessageFilterEntity?
        if let filter = filter {
            let filterTransformer = EmailMessageFilterEntityTransformer()
            entityFilter = filterTransformer.transform(filter)
        }
        /// Execute use case based on cache policy.
        switch cachePolicy {
        case .cacheOnly:
            let useCase = useCaseFactory.generateGetListEmailMessagesUseCase(
                sealedEmailMessageRepository: sealedEmailMessageRepository,
                emailMessageUnsealerService: emailMessageUnsealerServiceService
            )
            useCase.execute(withFilter: entityFilter, limit: limit, nextToken: nextToken, completion: useCaseCompletion)
        case .remoteOnly:
            let useCase = useCaseFactory.generateFetchListEmailMessagesUseCase(
                sealedEmailMessageRepository: sealedEmailMessageRepository,
                emailMessageUnsealerService: emailMessageUnsealerServiceService
            )
            useCase.execute(withFilter: entityFilter, limit: limit, nextToken: nextToken, completion: useCaseCompletion)
        }
    }

    public func getEmailMessageRFC822DataWithId(_ messageId: String, completion: @escaping ClientCompletion<Data>) {
        let useCase = useCaseFactory.generateFetchEmailMessageRFC822DataUseCase(
            sealedEmailMessageRepository: sealedEmailMessageRepository,
            keyRepository: keyRepository,
            emailMessageUnsealerService: emailMessageUnsealerServiceService
        )
        useCase.execute(withMessageId: messageId, completion: completion)
    }

    public func subscribeToEmailMessageCreated(resultHandler: @escaping ClientCompletion<EmailMessage>) throws -> SubscriptionToken {
        let useCase = useCaseFactory.generateSubscribeToEmailMessageCreatedUseCase(
            sealedEmailMessageRepository: sealedEmailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerServiceService
        )
//        let directionTransformer = EmailMessageDirectionEntityTransformer()
//        let directionEntity = directionTransformer.transform(direction)
        let token = try useCase.execute(withDirection: nil) { result in
            let transformer = EmailMessageAPITransformer()
            let result = result.map(transformer.transform(_:))
            resultHandler(result)
        }
        return token
    }

    public func subscribeToEmailMessageDeleted(resultHandler: @escaping ClientCompletion<EmailMessage>) throws -> SubscriptionToken {
        let useCase = useCaseFactory.generateSubscribeToEmailMessageDeletedUseCase(
            sealedEmailMessageRepository: sealedEmailMessageRepository,
            emailMessageUnsealerService: emailMessageUnsealerServiceService
        )
        let token = try useCase.execute { result in
            let transformer = EmailMessageAPITransformer()
            let result = result.map(transformer.transform(_:))
            resultHandler(result)
        }
        return token
    }

}
