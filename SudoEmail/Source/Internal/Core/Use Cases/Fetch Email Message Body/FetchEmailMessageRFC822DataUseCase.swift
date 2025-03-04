//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Gzip

/// Core use case representation of a operation to fetch the RFC 6854 (supersedes RFC 822) data of the email message remotely.
class FetchEmailMessageRFC822DataUseCase {

    // MARK: - Properties

    /// Email message repository used to access email message records and the RFC 6854 (supersedes RFC 822) data of the message.
    let emailMessageRepository: EmailMessageRepository

    let emailMessageUnsealerService: EmailMessageUnsealerService

    // MARK: - Lifecycle

    /// Initialize an instance of `FetchEmailMessageRFC822DataUseCase`.
    init(
        emailMessageRepository: EmailMessageRepository,
        emailMessageUnsealerService: EmailMessageUnsealerService
    ) {
        self.emailMessageRepository = emailMessageRepository
        self.emailMessageUnsealerService = emailMessageUnsealerService
    }

    // MARK: - Methods

    /// Execute the use case.
    /// - Parameters:
    ///   - id: Identifier of the email message to be accessed.
    ///   - completion: Body of the email message associated with `id`, or error on failure.
    func execute(withMessageId id: String, emailAddressId: String) async throws -> Data {
        guard let emailMessage = try await emailMessageRepository.fetchEmailMessageById(id) else {
            throw SudoEmailError.noEmailMessageRFC822Available
        }
        guard let rfc822Object = try await emailMessageRepository.fetchEmailMessageRFC822Data(id, emailAddressId: emailAddressId) else {
            throw SudoEmailError.noEmailMessageRFC822Available
        }
        let contentEncodingValues = (rfc822Object.contentEncoding?.split(separator: ",") ?? ["sudoplatform-crypto", "sudoplatform-binary-data"]).reversed()
        var decodedData = rfc822Object.body
        do {
            for encodingValue in contentEncodingValues {
                switch encodingValue.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
                case "sudoplatform-compression":
                    let base64Decoded = Data(base64Encoded: decodedData)
                    decodedData = try (base64Decoded?.gunzipped())!
                case "sudoplatform-crypto":
                    decodedData = try emailMessageUnsealerService.unsealEmailMessageRFC822Data(
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
        return decodedData
    }
}
