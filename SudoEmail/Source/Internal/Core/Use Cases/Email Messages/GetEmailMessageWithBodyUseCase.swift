//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//
import Gzip

/** Content encoding values for email message data. */
let CRYPTO_CONTENT_ENCODING: String = "sudoplatform-crypto"
let BINARY_DATA_CONTENT_ENCODING: String = "sudoplatform-binary-data"
let COMPRESSION_CONTENT_ENCODING: String = "sudoplatform-compression"

class GetEmailMessageWithBodyUseCase {

    // MARK: - Properties

    let emailMessageRepository: EmailMessageRepository

    let emailMessageUnsealerService: EmailMessageUnsealerService

    let emailCryptoService: EmailCryptoService
    
    let rfc822MessageDataProcessor: Rfc822MessageDataProcessor

    // MARK: - Lifecycle

    /// Initialize an instance of `GetEmailMessageWithBodyUseCase`.
    init(
        emailMessageRepository: EmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService,
        emailCryptoService: EmailCryptoService,
        rfc822MessageDataProcessor: Rfc822MessageDataProcessor
    ) {
        self.emailMessageRepository = emailMessageRepository
        self.emailMessageUnsealerService = emailMessageUnsealerService
        self.emailCryptoService = emailCryptoService
        self.rfc822MessageDataProcessor = rfc822MessageDataProcessor
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - id: Identifier of the email message to be accessed.
    ///   - completion: Body of the email message associated with `id`, or error on failure.
    func execute(withInput input: GetEmailMessageWithBodyInput) async throws -> EmailMessageWithBody? {
        let messageId = input.id
        let emailAddressId = input.emailAddressId
        guard let emailMessage = try await emailMessageRepository.fetchEmailMessageById(messageId) else {
            return nil
        }
        guard let rfc822Object = try await self.emailMessageRepository.fetchEmailMessageRFC822Data(messageId, emailAddressId: emailAddressId) else {
            throw SudoEmailError.noEmailMessageRFC822Available
        }

        do {
            let contentEncodingValues = (rfc822Object.contentEncoding?.split(separator: ",") ?? ["\(CRYPTO_CONTENT_ENCODING)", "\(BINARY_DATA_CONTENT_ENCODING)"])
                .reversed()
            var decodedData = rfc822Object.body
            do {
                for (encodingValue) in contentEncodingValues {
                    switch encodingValue.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
                        case COMPRESSION_CONTENT_ENCODING:
                            let base64Decoded = Data(base64Encoded: decodedData)
                            decodedData = try (base64Decoded?.gunzipped())!
                        case CRYPTO_CONTENT_ENCODING:
                            decodedData = try self.emailMessageUnsealerService.unsealEmailMessageRFC822Data(
                                rfc822Object.body,
                                withKeyId: emailMessage.keyId,
                                algorithm: emailMessage.algorithm
                            )
                        case BINARY_DATA_CONTENT_ENCODING:
                            break
                        default:
                            throw SudoEmailError.decodingError
                    }
                }
            } catch {
                throw error
            }

            guard let internetMessageData = String(data: decodedData, encoding: .utf8) else {
                throw SudoEmailError.decodingError
            }
            var parsedMessage = try rfc822MessageDataProcessor.decodeInternetMessageData(input: internetMessageData)

            if emailMessage.encryptionStatus == EncryptionStatus.ENCRYPTED {
                var keyAttachments: Set<EmailAttachment> = []
                var bodyAttachment: EmailAttachment? = nil

                parsedMessage.attachments?.forEach({ attachment in
                    let contentId = attachment.contentId ?? ""
                    let isKeyExchangeType = contentId.contains(SecureEmailAttachmentType.KEY_EXCHANGE.contentId()) ||
                                             contentId.contains(SecureEmailAttachmentType.LEGACY_KEY_EXCHANGE_CONTENT_ID)
                    if isKeyExchangeType {
                        keyAttachments.insert(attachment)
                    } else {
                        let isBodyType = contentId.contains(SecureEmailAttachmentType.BODY.contentId()) ||
                                          contentId.contains(SecureEmailAttachmentType.LEGACY_BODY_CONTENT_ID)
                        if isBodyType {
                            bodyAttachment = attachment
                        }
                    }
                })

                if keyAttachments.isEmpty {
                    throw SudoEmailError.keyAttachmentsNotFound
                }
                guard let bodyAttachment = bodyAttachment else {
                    throw SudoEmailError.bodyAttachmentNotFound
                }

                let securePackage = SecurePackageEntity(keyAttachments: keyAttachments, bodyAttachment: bodyAttachment)
                let unencryptedMessageData = try emailCryptoService.decrypt(securePackage: securePackage)
                guard let unencryptedMessageStr = String(data: unencryptedMessageData, encoding: .utf8) else {
                    throw SudoEmailError.decodingError
                }
                parsedMessage = try rfc822MessageDataProcessor.decodeInternetMessageData(input: unencryptedMessageStr)
            }

            return EmailMessageWithBody(
                id: messageId,
                body: parsedMessage.body ?? "",
                attachments: parsedMessage.attachments ?? [],
                inlineAttachments: parsedMessage.inlineAttachments ?? []
            )
        } catch {
            throw SudoEmailError.internalError("Failed to retrieve message with body: \(error.localizedDescription)")
        }
    }
}
