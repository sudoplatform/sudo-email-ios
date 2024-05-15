//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
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

    static let KEY_EXCHANGE = SecureEmailAttachmentType.keyExchange(
        fileName: "Secure Data",
        mimeType: "application/x-sudomail-key",
        contentId: "securekeyexchangedata@sudomail.com"
    )

    static let BODY = SecureEmailAttachmentType.body(
        fileName: "Secure Email",
        mimeType: "application/x-sudomail-body",
        contentId: "securebody@sudomail.com"
    )

    private func getValues() -> (fileName: String, mimeType: String, contentId: String) {
        switch self {
        case .keyExchange(let fileName, let mimeType, let contentId):
            return (fileName, mimeType, contentId)
        case .body(let fileName, let mimeType, let contentId):
            return (fileName, mimeType, contentId)
        }
    }

    func fileName() -> String { self.getValues().fileName }

    func mimeType() -> String { self.getValues().mimeType }

    func contentId() -> String { self.getValues().contentId }
}
