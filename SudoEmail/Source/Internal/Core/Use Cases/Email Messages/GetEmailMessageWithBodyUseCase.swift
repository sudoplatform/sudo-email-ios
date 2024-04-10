//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//
import Gzip

class GetEmailMessageWithBodyUseCase {

    // MARK: - Properties

    let emailMessageRepository: EmailMessageRepository

    let emailMessageUnsealerService: EmailMessageUnsealerService

    let emailCryptoService: EmailCryptoService

    // MARK: - Lifecycle

    /// Initialize an instance of `GetEmailMessageWithBodyUseCase`.
    init(
        emailMessageRepository: EmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService,
        emailCryptoService: EmailCryptoService
    ) {
        self.emailMessageRepository = emailMessageRepository
        self.emailMessageUnsealerService = emailMessageUnsealerService
        self.emailCryptoService = emailCryptoService
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
            let contentEncodingValues = (rfc822Object.contentEncoding?.split(separator: ",") ?? ["sudoplatform-crypto", "sudoplatform-binary-data"])
                .reversed()
            var decodedData = rfc822Object.body
            do {
                for (encodingValue) in contentEncodingValues {
                    switch encodingValue.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
                        case "sudoplatform-compression":
                            let base64Decoded = Data(base64Encoded: decodedData)
                            decodedData = try (base64Decoded?.gunzipped())!
                        case "sudoplatform-crypto":
                            decodedData = try self.emailMessageUnsealerService.unsealEmailMessageRFC822Data(
                                rfc822Object.body,
                                withKeyId: emailMessage.keyId,
                                algorithm: emailMessage.algorithm
                            )
                        case "sudoplatform-binary-data":
                            break
                        default:
                            throw SudoEmailError.decodingError
                    }
                }
            } catch {
                throw error
            }

            guard let decodedDataStr = String(data: decodedData, encoding: .utf8) else {
                throw SudoEmailError.decodingError
            }
            var parsedMessage = try Rfc822MessageDataProcessor.decodeInternetMessageData(input: decodedDataStr)

            if emailMessage.encryptionStatus == EncryptionStatus.ENCRYPTED {
                let keyExchangeAttachmentTypeValues = SecureEmailAttachmentType.KEY_EXCHANGE.getValues()
                let bodyAttachmentTypeValues = SecureEmailAttachmentType.BODY.getValues()
                var keyAttachments: Set<EmailAttachment> = []
                var bodyAttachment: EmailAttachment? = nil

                parsedMessage.attachments?.forEach({ attachment in
                    let contentId = attachment.contentId ?? ""
                    let mimetype = attachment.mimetype
                    let isKeyExchangeType = contentId.contains(keyExchangeAttachmentTypeValues.contentId) && mimetype.contains(keyExchangeAttachmentTypeValues.mimeType)
                    if isKeyExchangeType {
                        keyAttachments.insert(attachment)
                    } else {
                        let isBodyType = contentId.contains(bodyAttachmentTypeValues.contentId) && mimetype.contains(bodyAttachmentTypeValues.mimeType)
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
                parsedMessage = try Rfc822MessageDataProcessor.decodeInternetMessageData(input: unencryptedMessageStr)
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
