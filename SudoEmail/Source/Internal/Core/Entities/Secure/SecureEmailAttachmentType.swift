//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core representation of the types of attachments in an email message that are end-to-end encrypted.
/// - Parameter fileName - Name of the attachment file.
/// - Parameter mimeType - The attachment mimeType.
/// - Parameter contentId - The content identifier associated with the attachment.
enum SecureEmailAttachmentType {

    case keyExchange(fileName: String, mimeType: String, contentId: String)

    case body(fileName: String, mimeType: String, contentId: String)

    static let LEGACY_KEY_EXCHANGE_MIME_TYPE = "application/x-sudomail-key"
    static let LEGACY_KEY_EXCHANGE_CONTENT_ID = "securekeyexhangedata@sudomail.com" // Intentional mispelling of 'exchange' to match legacy system
    static let LEGACY_BODY_MIME_TYPE = "application/x-sudomail-body"
    static let LEGACY_BODY_CONTENT_ID = "securebody@sudomail.com"

    static let KEY_EXCHANGE = SecureEmailAttachmentType.keyExchange(
        fileName: "Secure Data",
        mimeType: "application/x-sudoplatform-key",
        contentId: "securekeyexchangedata@sudoplatform.com"
    )

    static let BODY = SecureEmailAttachmentType.body(
        fileName: "Secure Email",
        mimeType: "application/x-sudoplatform-body",
        contentId: "securebody@sudoplatform.com"
    )

    private func getValues() -> (fileName: String, mimeType: String, contentId: String) {
        switch self {
        case .keyExchange(let fileName, let mimeType, let contentId):
            return (fileName, mimeType, contentId)
        case .body(let fileName, let mimeType, let contentId):
            return (fileName, mimeType, contentId)
        }
    }

    func fileName() -> String { getValues().fileName }

    func mimeType() -> String { getValues().mimeType }

    func contentId() -> String { getValues().contentId }
}
