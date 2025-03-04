//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import MailCore
import SudoLogging

let EMAIL_HEADER_NAME_ENCRYPTION = "X-Sudoplatform-Encryption"
let PLATFORM_ENCRYPTION = "sudoplatform"
let CANNED_TEXT_BODY = "Encrypted message attached"

let ENCODED_WORD_REGEX_PATTERN = "(?:=\\?([\\w-]+)\\?([A-Z])\\?([a-zA-Z0-9+\\/=_]*)\\?=)"
let HTML_TAG_BODY_REGEX = "(?s)<html.*</html>"

struct EmailMessageDetails {
    var from: [EmailAddressAndName]
    var to: [EmailAddressAndName]?
    var cc: [EmailAddressAndName]?
    var bcc: [EmailAddressAndName]?
    var replyTo: [EmailAddressAndName]?
    var subject: String?
    var body: String?
    var attachments: [EmailAttachment]?
    var inlineAttachments: [EmailAttachment]?
    var isHtml: Bool = false
    var encryptionStatus: EncryptionStatus = EncryptionStatus.UNENCRYPTED
    var forwardMessageId: String?
    var replyMessageId: String?
}

/// A class which handles the parsing of RFC822 compliant email messages in the Platform SDK
class Rfc822MessageDataProcessor {

    // MARK: - Rfc822MessageDataProcessor

    /// Encodes the given email into an RFC822 compliant string
    /// - Parameters:
    ///   - message: The email to be encoded
    /// - Returns: The encoded email as RFC data
    func encodeToInternetMessageData(message: EmailMessageDetails) throws -> Data {
        let builder = MCOMessageBuilder()

        builder.header.from = MCOAddress(
            displayName: message.from[0].displayName,
            mailbox: message.from[0].address
        )

        var toList = [MCOAddress]()
        message.to?.forEach { to in
            toList.append(MCOAddress(
                displayName: to.displayName,
                mailbox: to.address
            ))
        }
        builder.header.to = toList

        var ccList = [MCOAddress]()
        message.cc?.forEach { cc in
            ccList.append(MCOAddress(
                displayName: cc.displayName,
                mailbox: cc.address
            ))
        }
        builder.header.cc = ccList

        var bccList = [MCOAddress]()
        message.bcc?.forEach { bcc in
            bccList.append(MCOAddress(
                displayName: bcc.displayName,
                mailbox: bcc.address
            ))
        }
        builder.header.bcc = bccList

        var replyToList = [MCOAddress]()
        message.replyTo?.forEach { replyTo in
            replyToList.append(MCOAddress(
                displayName: replyTo.displayName,
                mailbox: replyTo.address
            ))
        }
        builder.header.replyTo = replyToList

        builder.header.subject = message.subject
        var body = message.body

        if message.encryptionStatus == EncryptionStatus.ENCRYPTED {
            body = CANNED_TEXT_BODY
            builder.header.setExtraHeaderValue(PLATFORM_ENCRYPTION, forName: EMAIL_HEADER_NAME_ENCRYPTION)
        }

        if let replyMessageId = message.replyMessageId {
            builder.header.setExtraHeaderValue("<\(replyMessageId)>", forName: "In-Reply-To")
        } else if let forwardMessageId = message.forwardMessageId {
            builder.header.setExtraHeaderValue("<\(forwardMessageId)>", forName: "References")
        }

        if message.isHtml {
            // Mailcore handles creating a multipart message to ensure mail client compatibility,
            // so by setting the body as html and formatting correctly here, the final message
            // will contain this html part and a plain text part.
            builder.htmlBody = body
        } else {
            builder.textBody = body
        }

        // Build Mailcore attachments from provided message attachments
        let allAttachments = (message.attachments ?? []) + (message.inlineAttachments ?? [])
        try allAttachments.forEach { attachment in
            guard let mcoAttachment = MCOAttachment(data: attachment.data, filename: attachment.filename) else {
                throw SudoEmailError.internalError("Failed to build attachment")
            }
            mcoAttachment.mimeType = attachment.mimetype
            mcoAttachment.isInlineAttachment = attachment.inlineAttachment
            mcoAttachment.contentID = attachment.contentId

            builder.addAttachment(mcoAttachment)
        }

        guard let data = builder.data() else {
            throw SudoEmailError.internalError("No data encoded")
        }

        return data
    }

    func transformMCOAttachments(_ mcoAttachments: [MCOAttachment]) -> [EmailAttachment] {
        var attachments: [EmailAttachment] = []
        for mcoAttachment in mcoAttachments {
            attachments.append(EmailAttachment(
                filename: mcoAttachment.filename,
                contentId: mcoAttachment.contentID,
                mimetype: mcoAttachment.mimeType,
                inlineAttachment: mcoAttachment.isInlineAttachment,
                data: mcoAttachment.data
            ))
        }
        return attachments
    }

    func decodeInternetMessageData(input: String) throws -> EmailMessageDetails {
        guard let parser = MCOMessageParser(data: input.data(using: .utf8)),
              let header = parser.header else {
            throw SudoEmailError.decodingError
        }

        let from = header.from
        let to = header.to as? [MCOAddress] ?? []
        let cc = header.cc as? [MCOAddress] ?? []
        let bcc = header.bcc as? [MCOAddress] ?? []
        let replyTo = header.replyTo as? [MCOAddress] ?? []
        let subject = header.subject
        /// This is forcing HTML for incoming email. Even plain text would resolve to a HTML render.
        /// Product decision as to whether we *need* support for raw plaintext. If we do, this might
        /// need some minor refactoring. e.g: let isHtml = parser.isPlaintext()
        let isHtml = true
        let renderer = parser.isPlaintext() ?
            HTMLPlaintextRenderer(logger: Logger.emailSDKLogger) : HTMLRenderer()
        let body = parser.htmlRendering(with: renderer)

        var attachments: [EmailAttachment]?
        if let mcoAttachments = parser.attachments() as NSArray? as? [MCOAttachment] {
            attachments = transformMCOAttachments(mcoAttachments)
        }

        var inlineAttachments: [EmailAttachment]?
        if let mcoInlineAttachments = parser.htmlInlineAttachments() as NSArray? as? [MCOAttachment] {
            inlineAttachments = transformMCOAttachments(mcoInlineAttachments)
        }

        // Inline attachments can be interpreted by the parser as either a regular attachment with the inline
        // flag set to true, or as an explicit inline attachment, so we need to cater for both scenarios
        var allInlineAttachments: [EmailAttachment] = []
        allInlineAttachments.append(contentsOf: inlineAttachments ?? [])
        allInlineAttachments.append(contentsOf: attachments?.filter { $0.inlineAttachment == true } ?? [])

        let encryptionHeader = header.extraHeaderValue(forName: EMAIL_HEADER_NAME_ENCRYPTION)
        let encryptionStatus = encryptionHeader == PLATFORM_ENCRYPTION ? EncryptionStatus.ENCRYPTED : EncryptionStatus.UNENCRYPTED

        var result = EmailMessageDetails(
            from: [
                EmailAddressAndName(
                    address: from?.mailbox ?? "",
                    displayName: from?.displayName
                )
            ],
            to: to.map { EmailAddressAndName(
                address: $0.mailbox ?? "",
                displayName: $0.displayName
            ) },
            cc: cc.map { EmailAddressAndName(
                address: $0.mailbox ?? "",
                displayName: $0.displayName
            ) },
            bcc: bcc.map { EmailAddressAndName(
                address: $0.mailbox ?? "",
                displayName: $0.displayName
            ) },
            replyTo: replyTo.map { EmailAddressAndName(
                address: $0.mailbox ?? "",
                displayName: $0.displayName
            ) },
            subject: subject,
            body: body,
            attachments: attachments?.filter { $0.inlineAttachment != true },
            inlineAttachments: allInlineAttachments,
            isHtml: isHtml,
            encryptionStatus: encryptionStatus
        )

        if let forwardMessageId = header.references?.last as? String {
            result.forwardMessageId = forwardMessageId
        }
        if let replyMessageId = header.inReplyTo?.last as? String {
            result.replyMessageId = replyMessageId
        }

        return result
    }
}
