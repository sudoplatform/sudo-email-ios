//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

struct EncodableMessageDetails: Equatable {
    var from: [EmailAddressAndName]
    var to: [EmailAddressAndName]?
    var cc: [EmailAddressAndName]?
    var date: Date?
    var subject: String?
    var body: String?
    var id: String?
}

// (in conformance with how MySudo strips images)
let IMAGE_REPLACEMENT_TEXT = "-IMAGE REMOVED-<br/>"
let IMAGE_REPLACEMENT_REGEX = "<img(?<=<img)[^>]*>"

class MessageFormatter {

    /// Format the body and subject of an email message to contain details of another message that is being
    /// replied to.
    /// - Parameters:
    ///   - messageDetails: Email message details to be formatted.
    ///   - replyMessage: Reply message details to be included in the other message details.
    /// - Returns: Original `messageDetails` object with updated subject and/or body fields,
    ///     or `nil` if an error occurred while encoding the reply message.
    func formatAsReplyingMessage(messageDetails: EmailMessageDetails, replyMessage: EncodableMessageDetails) -> EmailMessageDetails? {
        do {
            var formattedMessageDetails = EmailMessageDetails(messageDetails)

            if messageDetails.subject == nil || messageDetails.subject?.count == 0 {
                formattedMessageDetails.subject = "Re: " + (replyMessage.subject ?? "")
            }

            let encodedReplyMessage = try self.encodeReplyMessage(messageDetails: replyMessage)
            if let body = messageDetails.body {
                formattedMessageDetails.body = body + "\n\n" + encodedReplyMessage
            }
            formattedMessageDetails.isHtml = true

            return formattedMessageDetails
        } catch {
            return nil
        }
    }

    /// Format the body and subject of an email message to contain details of another message that is being
    /// forwarded.
    /// - Parameters:
    ///   - messageDetails: Email message details to be formatted.
    ///   - forwardMessage: Forard message details to be included in the other message details.
    /// - Returns: `messageDetails` object with updated subject and/or body fields.
    func formatAsForwardingMessage(messageDetails: EmailMessageDetails, forwardMessage: EncodableMessageDetails) -> EmailMessageDetails {
        var formattedMessageDetails = EmailMessageDetails(messageDetails)
        if messageDetails.subject == nil || messageDetails.subject?.count == 0 {
            formattedMessageDetails.subject = "Fwd: " + (forwardMessage.subject ?? "")
        }
        let encodedForwardMessage = self.encodeForwardMessage(messageDetails: forwardMessage)
        if let body = messageDetails.body {
            formattedMessageDetails.body = body + "\n\n" + encodedForwardMessage
        }
        formattedMessageDetails.isHtml = true

        return formattedMessageDetails
    }

    /// Create a plaintext reply message string from the given message details.
    /// - Parameters:
    ///   - messageDetails: Details of the email message to create a reply message from.
    /// - Returns: An email message string in the format of a reply message.
    internal func encodeReplyMessage(messageDetails: EncodableMessageDetails) throws -> String {
        var replyMessage = "<div class=\"replyMessage\"><br/></div>\n"
        + "<div class=\"replyMessage\"><br/></div>\n"
        + "<div class=\"replyMessage\"><br/></div>\n"
        + "<div class=\"replyMessage\"><br/></div>\n"
        + "<hr>\n"

        // Format 'from' addresses line
        if !messageDetails.from.isEmpty {
            let fromAddressLine = messageDetails.from.map({ $0.description }).joined(separator: ", ")
            replyMessage += "<div class=\"replyMessage\">From: \(fromAddressLine)</div>\n"
        }

        // Format date line
        if let date = messageDetails.date {
            let formattedDate = formatDateForEmail(date: date)
            replyMessage += "<div class=\"replyMessage\">Date: \(formattedDate)</div>\n"
        }

        // Format subject line
        replyMessage += "<div class=\"replyMessage\">Subject: \(messageDetails.subject ?? "")</div>\n"

        // Format message body and strip all html image tags
        let regex = try NSRegularExpression(pattern: IMAGE_REPLACEMENT_REGEX, options: .caseInsensitive)
        let body = messageDetails.body ?? ""
        let formattedBody = regex.stringByReplacingMatches(in: body, options:  [], range: NSMakeRange(0, body.count), withTemplate: IMAGE_REPLACEMENT_TEXT)
        replyMessage += "<div><br/>\(formattedBody)<br/></div>"

        return replyMessage
    }

    /// Create a plaintext forward message string from the given message details.
    /// - Parameters:
    ///   - messageDetails: Details of the email message to create a forward message from.
    /// - Returns: An email message string in the format of a forwarded message.
    internal func encodeForwardMessage(messageDetails: EncodableMessageDetails) -> String {
        var forwardMessage = "<div class=\"forwardMessage\"><br/></div>\n"
        + "<div class=\"forwardMessage\"><br/></div>\n"
        + "<div class=\"forwardMessage\"><br/></div>\n"
        + "<div class=\"forwardMessage\"><br/></div>\n"
        + "<div class=\"forwardMessage\">---------- Forwarded message ----------</div>\n"

        // Format 'from' addresses line
        if !messageDetails.from.isEmpty {
            let fromAddressesLine = messageDetails.from.map({ $0.description }).joined(separator: ", ")
            forwardMessage += "<div class=\"forwardMessage\">From: \(fromAddressesLine)</div>\n"
        }

        // Format date line
        if let date = messageDetails.date {
            let formattedDate = formatDateForEmail(date: date)
            forwardMessage += "<div class=\"forwardMessage\">Date: \(formattedDate)</div>\n"
        }

        // Format subject line
        forwardMessage += "<div class=\"forwardMessage\">Subject: \(messageDetails.subject ?? "")</div>\n"

        // Format lines containing from and/or cc addresses
        let toAddresses = messageDetails.to?.map({ $0.description }) ?? []
        let ccAddresses = messageDetails.cc?.map({ $0.description }) ?? []
        if !toAddresses.isEmpty || !ccAddresses.isEmpty {
            // eslint-disable-next-line quotes
            forwardMessage += "<div class=\"forwardMessage\">\n"
            if !toAddresses.isEmpty {
                let toAddressesLine = toAddresses.joined(separator: ", ")
                forwardMessage += "To: \(toAddressesLine)<br/>\n"
            }
            if !ccAddresses.isEmpty {
                let ccAddressesLine = ccAddresses.joined(separator: ", ")
                forwardMessage += "Cc: \(ccAddressesLine)<br/>\n"
            }
            forwardMessage += "</div>\n"
        }

        // Format message body
        forwardMessage += "<div><br/>\(messageDetails.body ?? "")<br/></div>"

        return forwardMessage
    }

    /// Create a date/time string in the format `Tuesday, 2 June 2020 at 9:47 AM`.
    internal func formatDateForEmail(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")

        formatter.dateFormat = "EEEE"
        let weekday = formatter.string(from: date)

        formatter.dateFormat = "d"
        let day = formatter.string(from: date)

        formatter.dateFormat = "MMMM"
        let month = formatter.string(from: date)

        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)

        formatter.dateFormat = "h:mm a"
        let time = formatter.string(from: date)

        let formattedDate = "\(weekday), \(day) \(month) \(year) at \(time)"
        return formattedDate
    }
}
