//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import MailCore


let EMAIL_HEADER_NAME_ENCRYPTION = "X-Sudoplatform-Encryption"
let PLATFORM_ENCRYPTION = "sudoplatform"
let CANNED_TEXT_BODY = "Encrypted message attached"

let ENCODED_WORD_REGEX_PATTERN = "(?:=\\?([\\w-]+)\\?([A-Z])\\?([a-zA-Z0-9+\\/=_]*)\\?=)"

/// A class which handles the parsing of RFC822 compliant email messages in the Platform SDK
class Rfc822MessageDataProcessor {
    struct EmailMessageDetails {
        var from: [EmailAddressDetail]
        var to: [EmailAddressDetail]?
        var cc: [EmailAddressDetail]?
        var bcc: [EmailAddressDetail]?
        var replyTo: [EmailAddressDetail]?
        var subject: String?
        var body: String?
        var attachments: [EmailAttachment]?
        var inlineAttachments: [EmailAttachment]?
        var encryptionStatus: EncryptionStatus = EncryptionStatus.UNENCRYPTED
    }

    // MARK: - Rfc822MessageDataProcessor


    /// Encodes the given email into RFC822 compliant data
    /// - Parameters:
    ///   - message: The email to be encoded
    /// - Returns: The encoded email as RFC822 data
    func encodeToInternetMessageData(message: EmailMessageDetails) throws -> Data {
        let resultStr = try self.encodeToInternetMessageDataStr(message: message)
        return Data(resultStr.utf8)
    }

    /// Encodes the given email into an RFC822 compliant string
    /// - Parameters:
    ///   - message: The email to be encoded
    /// - Returns: The encoded email as a string
    func encodeToInternetMessageDataStr(message: EmailMessageDetails) throws -> String {
        let builder = MCOMessageBuilder()

        builder.header.from = MCOAddress(
            displayName: message.from[0].displayName,
            mailbox: message.from[0].emailAddress
        )

        var toList = [MCOAddress]()
        message.to?.forEach({ to in
            toList.append(MCOAddress(
                displayName: to.displayName,
                mailbox: to.emailAddress
            ))
        })
        builder.header.to = toList

        var ccList = [MCOAddress]()
        message.cc?.forEach({ cc in
            ccList.append(MCOAddress(
                displayName: cc.displayName,
                mailbox: cc.emailAddress
            ))
        })
        builder.header.cc = ccList

        var bccList = [MCOAddress]()
        message.bcc?.forEach({ bcc in
            bccList.append(MCOAddress(
                displayName: bcc.displayName,
                mailbox: bcc.emailAddress
            ))
        })
        builder.header.bcc = bccList

        var replyToList = [MCOAddress]()
        message.replyTo?.forEach({ replyTo in
            replyToList.append(MCOAddress(
                displayName: replyTo.displayName,
                mailbox: replyTo.emailAddress
            ))
        })
        builder.header.replyTo = replyToList

        builder.header.subject = message.subject
        var body = message.body

        if message.encryptionStatus == EncryptionStatus.ENCRYPTED {
            body = CANNED_TEXT_BODY
            builder.header.setExtraHeaderValue(PLATFORM_ENCRYPTION, forName: EMAIL_HEADER_NAME_ENCRYPTION)
        }

        if message.inlineAttachments?.count ?? 0 > 0 {
            builder.htmlBody = body
        } else {
            builder.textBody = body
        }

        try message.attachments?.forEach({ builder.addAttachment(try formatAttachment($0)) })

        try message.inlineAttachments?.forEach({ builder.addAttachment(try formatAttachment($0)) })

        guard let data = builder.data() else {
            throw SudoEmailError.internalError("No data encoded")
        }

        return try self.decodeEncodedWords(input: String(decoding: data, as: UTF8.self))
    }

    /// Generates a MailCore-formatted attachment from a given `EmailAttachment`.
    private func formatAttachment(_ attachment: EmailAttachment) throws -> MCOAttachment {
        let attachmentData = Data(base64Encoded: attachment.data) ?? Data(attachment.data.utf8)
        guard let mcoAttachment = MCOAttachment(data: attachmentData, filename: attachment.filename) else {
            throw SudoEmailError.internalError("Failed to build attachment")
        }
        mcoAttachment.mimeType = attachment.mimetype
        mcoAttachment.isInlineAttachment = attachment.inlineAttachment
        mcoAttachment.contentID = attachment.contentId

        return mcoAttachment
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

        // Strip whitespace and preserve newline characters.
        var body = parser.plainTextBodyRenderingAndStripWhitespace(false).trimmingCharacters(in: .whitespaces)

        var inlineAttachments: [EmailAttachment] = []
        var attachments: [EmailAttachment] = []

        func formatMCOAttachments(_ mcoAttachments: [MCOAttachment], isInline: Bool = false) throws {
            try mcoAttachments.forEach { a in
                // Mailcore may parse content types such as 'text/rfc822-headers' and 'message/delivery-status'
                // as attachments won't have filenames, meaning we need to skip attachments without filenames
                // to avoid eventual errors with content types such as these.
                if let filename = a.filename {
                    let attachment = EmailAttachment(
                        filename: filename,
                        contentId: a.contentID,
                        mimetype: a.mimeType,
                        inlineAttachment: isInline || a.isInlineAttachment,
                        // MailCore automatically encodes base64 data when parsing a message, so we encode
                        // the data here to protect the inner-contents from being unwrapped.
                        data: a.data.base64EncodedString()
                    )
                    if attachment.inlineAttachment {
                        inlineAttachments.append(attachment)
                    } else {
                        attachments.append(attachment)
                    }

                    // There will be a list of the attachments at the end of the body that we want to remove, ie
                    // `- a test.txt, 738 bytes`
                    // `- aTest2.png, 14 KB`
                    // `- a-large_test.pdf, 2.0 MB`
                    let pattern = "- \(filename), \\d+(\\.){0,1}(\\d+){0,}\\s?(?:(bytes|KB|MB))\n"
                    let regex = try NSRegularExpression(pattern: pattern)
                    let range = NSRange(body.startIndex..<body.endIndex, in: body)
                    body = regex.stringByReplacingMatches(in: body, options: [], range: range, withTemplate: "")
                }
            }
        }

        // List are retrieved separately here to use Mailcore's logic as a baseline of which attachments are
        // inline and which aren't - our logic can then be added on top.
        // (Sometimes `parser.attachments()` can contain inline attachments...)
        try formatMCOAttachments(parser.attachments() as? [MCOAttachment] ?? [])
        try formatMCOAttachments(parser.htmlInlineAttachments() as? [MCOAttachment] ?? [], isInline: true)

        let encryptionHeader = header.extraHeaderValue(forName: EMAIL_HEADER_NAME_ENCRYPTION)
        let encryptionStatus: EncryptionStatus = encryptionHeader == PLATFORM_ENCRYPTION ? EncryptionStatus.ENCRYPTED : EncryptionStatus.UNENCRYPTED

        let result = EmailMessageDetails(
            from: [EmailAddressDetail(
                emailAddress: from?.mailbox ?? "",
                displayName: from?.displayName
            )],
            to: to.map { EmailAddressDetail(
                emailAddress: $0.mailbox ?? "",
                displayName: $0.displayName
            ) },
            cc: cc.map { EmailAddressDetail(
                emailAddress: $0.mailbox ?? "",
                displayName: $0.displayName
            ) },
            bcc: bcc.map { EmailAddressDetail(
                emailAddress: $0.mailbox ?? "",
                displayName: $0.displayName
            ) },
            replyTo: replyTo.map { EmailAddressDetail(
                emailAddress: $0.mailbox ?? "",
                displayName: $0.displayName
            ) },
            subject: subject,
            body: body,
            attachments: attachments,
            inlineAttachments: inlineAttachments,
            encryptionStatus: encryptionStatus
        )

        return result
    }

    ///
    /// MailCore2 encodes some parts of the email message as Encoded-Words. This function
    /// decodes them back to plaintext
    /// - Parameters:
    ///   - input: The string value of the RFC822 encoded message as output from MailCore2
    /// - Returns: The string value with any Encoded-Words decoded
    private func decodeEncodedWords(input: String) throws -> String {
        var processed = input
        let regex = try NSRegularExpression(
            pattern: ENCODED_WORD_REGEX_PATTERN
        )

        let matches = regex.matches(in: input, range: NSMakeRange(0, input.count))

        if(matches.isEmpty) {
            return processed
        }

        try matches.forEach({ match in
            // Each instance of an encoded word
            let group = input[Range(match.range(at: 0), in: input)!]
            let charset = input[Range(match.range(at: 1), in: input)!]
            let encodingType = input[Range(match.range(at: 2), in: input)!]
            let value = input[Range(match.range(at: 3), in: input)!]

            if(value == "") { // Found a match but its for an empty string
                processed = input.replacingOccurrences(of: group, with: value)
            } else {
                let encodingCharset: String.Encoding
                switch (charset) {
                case "utf-8":
                    encodingCharset = String.Encoding.utf8
                default:
                    throw SudoEmailError.internalError("Invalid charset value: \(charset)")
                }

                switch (encodingType) {
                    case "B": //Base64
                    guard let decodedValueData = Data(base64Encoded: String(value)) else {
                        print("Could not decode base64 string: \(String(value))")
                        throw SudoEmailError.decodingError
                    }
                    let decodedValueStr = String(data: decodedValueData, encoding: encodingCharset)
                    processed = processed.replacingOccurrences(
                        of: group,
                        with: decodedValueStr!
                    )
                    break
                case "Q": //Q-Encoded
                    let decoded = try self.decodeQEncoding(
                        encodedString: String(value)
                    )
                    processed = processed.replacingOccurrences(of: group, with: decoded)
                    break
                default:
                    throw SudoEmailError.internalError("Invalid encodingType value: \(encodingType)")
                }
            }
        })


        return processed
    }

    /// This decodes Q-Encoded values such as `=F0=9F=A4=94` which
    /// decodes to 🤔
    private func decodeQEncoding(encodedString: String) throws -> String {
        var decodedString = ""
        // Remove underscores that replace spaces. Will add them back later
        let components = encodedString.components(separatedBy: "_")

        for (index, component) in components.enumerated() {

            if component.hasPrefix("=") {
                // convert the hex string
                var remainingSection = component
                var isBytes = true
                var hexString = ""
                var remainder = ""
                while(isBytes) {
                    if(remainingSection.prefix(1) == "="){
                        let index = remainingSection.index(remainingSection.startIndex, offsetBy: 3)
                        let chars = remainingSection[..<index]
                        hexString.append(
                            String(chars).replacingOccurrences(of: "=", with: "")
                        )
                        remainingSection = String(remainingSection[index...])
                    } else {
                        isBytes = false
                        remainder = remainingSection
                    }
                }
                let byteCount = hexString.count / 2
                var bytes = [UInt8]()
                var currentIndex = hexString.startIndex

                for _ in 0..<byteCount {
                    if let byte = UInt8(hexString[currentIndex...hexString.index(after: currentIndex)], radix: 16) {
                        bytes.append(byte)
                        currentIndex = hexString.index(after: currentIndex)
                        currentIndex = hexString.index(after: currentIndex)
                    } else {
                        print("invalid hex string `\(hexString)`")
                        throw SudoEmailError.decodingError
                    }
                }

                if let decodedCharacter = String(bytes: bytes, encoding: .utf8) {
                    decodedString.append(decodedCharacter)
                } else {
                    print("Unable to decode bytes `\(bytes)`")
                    throw SudoEmailError.decodingError
                }
                decodedString.append(remainder)
            } else {
                decodedString.append(component)
            }

            // Add space after each component except the last one
            if index < components.count - 1 {
                decodedString.append(" ")
            }
        }

        return decodedString
    }
}
