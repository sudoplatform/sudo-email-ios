//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import MailCore

/// A class which handles the parsing of RFC822 compliant email messages in the Platform SDK
class Rfc822MessageParser {
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
    
    // MARK: - Properties
    
    static let EMAIL_HEADER_NAME_ENCRYPTION = "X-Sudoplatform-Encryption"
    static let PLATFORM_ENCRYPTION = "sudoplatform"
    static let CANNED_TEXT_BODY = "Encrypted message attached"
    
    static let ENCODED_WORD_REGEX_PATTERN = "(?:=\\?([\\w-]+)\\?([A-Z])\\?([a-zA-Z0-9+\\/=_]*)\\?=)"
    
    // MARK: - Rfc822MessageParser
    
    static func encodeToRfc822Data(message: EmailMessageDetails) throws -> Data {
        let resultStr = try Rfc822MessageParser.encodeToRfc822Str(message: message)
        return resultStr.data(using: .utf8)!
    }
    
    /// Encodes the given email into an RFC822 compliant string
    /// - Parameters:
    ///   - message: The email to be encoded
    /// - Returns: The encoded email as a string
    static func encodeToRfc822Str(message: EmailMessageDetails) throws -> String {
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
        
        if(message.encryptionStatus == EncryptionStatus.ENCRYPTED) {
            body = CANNED_TEXT_BODY
            builder.header.setExtraHeaderValue(PLATFORM_ENCRYPTION, forName: EMAIL_HEADER_NAME_ENCRYPTION)
        }
        
        if(message.inlineAttachments?.count ?? 0 > 0) {
            builder.htmlBody = body
        } else {
            builder.textBody = body
        }

        message.attachments?.forEach({ attachment in
            guard let mcoAttachment = MCOAttachment(data: Data(base64Encoded: attachment.data), filename: attachment.filename) else {
                return
            }
            mcoAttachment.mimeType = attachment.mimetype
            mcoAttachment.isInlineAttachment = attachment.inlineAttachment
            mcoAttachment.contentID = attachment.contentId
            builder.addAttachment(mcoAttachment)
        })
        
        message.inlineAttachments?.forEach({ attachment in
            guard let mcoAttachment = MCOAttachment(data: Data(base64Encoded: attachment.data), filename: attachment.filename) else {
                return
            }
            mcoAttachment.mimeType = attachment.mimetype
            mcoAttachment.isInlineAttachment = attachment.inlineAttachment
            mcoAttachment.contentID = attachment.contentId
            builder.addAttachment(mcoAttachment)
        })
        
        guard let data = builder.data() else {
            throw SudoEmailError.internalError("No data encoded")
        }

        return try Rfc822MessageParser.decodeEncodedWords(input: String(decoding: data, as: UTF8.self))
    }
    
    static func decodeRfc822Data(input: String) throws -> EmailMessageDetails {
        let parser = MCOMessageParser(data: input.data(using: .utf8))
        
        if(parser == nil) {
            throw SudoEmailError.decodingError
        }
        let header = parser!.header
        
        let from = header?.from
        let to = header?.to as? [MCOAddress] ?? []
        let cc = header?.cc as? [MCOAddress] ?? []
        let bcc = header?.bcc as? [MCOAddress] ?? []
        let replyTo = header?.replyTo as? [MCOAddress] ?? []
        let subject = header?.subject
        var body = parser?.plainTextBodyRendering()
        var attachments: [EmailAttachment] = []
        var inlineAttachments: [EmailAttachment] = []
        
        (parser?.attachments() as! [MCOAttachment]).forEach({a in
            let attachment = EmailAttachment(
                filename: a.filename!,
                contentId: a.contentID,
                mimetype: a.mimeType,
                inlineAttachment: a.isInlineAttachment,
                data: a.data.base64EncodedString()
            )
            if (attachment.inlineAttachment) {
                inlineAttachments.append(attachment)
            } else {
                attachments.append(attachment)
            }
            
            // There will be a list of the attachments at the end of the body that we want to remove
            body = body?.replacingOccurrences(of: " - \(a.filename ?? ""), \(a.data.count) bytes", with: "")
        })
        
        let encryptionHeader = header?.extraHeaderValue(forName: EMAIL_HEADER_NAME_ENCRYPTION)
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
    private static func decodeEncodedWords(input: String) throws -> String {
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
                    let decoded = try Rfc822MessageParser.decodeQEncoding(
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
    private static func decodeQEncoding(encodedString: String) throws -> String {
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
