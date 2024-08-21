//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import MailCore
import SudoLogging

public class HTMLPlaintextRenderer: HTMLRenderer {

    // MARK: - Properties

    let logger: Logger

    // MARK: - Lifecycle

    public init(logger: Logger) {
        self.logger = logger
        super.init()
    }

    // MARK: - Methods

    // Attempts to convert the HTML given into one that has links added
    public func mcoAbstractMessage(_ msg: MCOAbstractMessage!, filterHTMLForMessage html: String!) -> String! {

        // upgrade URLS to <a> and emails to mailto

        // check no a tags exist, as we will break them.
        // They really should not get to this point, but better to be safe

        var options: NSRegularExpression.Options = NSRegularExpression.Options(rawValue: 0)
        options.insert(NSRegularExpression.Options.dotMatchesLineSeparators)
        options.insert(NSRegularExpression.Options.caseInsensitive)

        // matches all unacceptable tags by whitelist (negative match the good tags and their close)
        guard let atag = try? NSRegularExpression(pattern: "<(?!\\s*/?(br\\/|body|blockquote|meta|head))[^>]*>", options: options) else {
            logger.error("Could not make regex")
            return html
        }

        let matches = atag.numberOfMatches(in: html, options: .withoutAnchoringBounds, range: NSRange(location: 0, length: html.count))
        guard matches == 0 else {
            logger.warning("Got \(matches) unacceptable tags, expected 0")
            return html
        }

        // phoneNumber sometimes matches incorrectly/where it should not
        // remove .phoneNumber if it gets bad
        let matchTypes: NSTextCheckingResult.CheckingType = [.link, .phoneNumber]
        guard let dd = try? NSDataDetector(types: matchTypes.rawValue) else {
            logger.error("Could not init DataDetector")
            return html
        }

        var out = html!

        // unescape enough of the html so that urls can be found correctly

        // this method fails safe
        // rather than manually encoding which could create security issues/break emails, this method finds and replaces
        // worst case for a missed encoding is a link that is just plain text

        // This solution is to get data detector to properly identify html encoded URLs,
        // by manually removing overmatched things
        // i.e. [...&amp;test=test|&gt]; [] is dd match, | is where I manually cut it off

        // backwards so we don't rematch on things we have setup as this is a lazy matcher and must use ranges
        for match in dd.matches(in: out, options: .withTransparentBounds, range: NSRange(location: 0, length: out.count)).reversed() {

            if let matchRange = Range(match.range, in: out) {

                // get what we expect the encoded value to look like, after removing anything datadector overmatches
                let matchText = String(out[matchRange])
                let cleanMatchText = cutURL(matchText)
                let cleanMatch = htmlUnescape(cleanMatchText)

                // get a new match as the last one has the wrong url
                guard let trueMatcher = dd.firstMatch(
                    in: cleanMatch,
                    options: .withTransparentBounds,
                    range: NSRange(location: 0, length: cleanMatch.count)
                )
                else {
                    continue
                }

                var replacement: String?

                // only bother if we can make a meaningful replacement
                if let url = trueMatcher.url {
                    replacement = "<a href='\(url)'>\(cleanMatchText)</a>"
                }

                // match for phone numbers and make a tel link
                // https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/PhoneLinks/PhoneLinks.html
                if let phoneNum = trueMatcher.phoneNumber {
                    replacement = "<a href='tel:\(phoneNum)'>\(cleanMatchText)</a>"
                }

                // replace only the new part
                if let replacement = replacement,
                   let newRange = Range(NSRange(location: match.range.lowerBound, length: cleanMatchText.count), in: out)
                {
                    out.replaceSubrange(newRange, with: replacement)
                }

            } else {
                // could not get the range done, skip the match
                logger.warning("Could not init range for match at \(match.range)")
                continue
            }
        }
        return out
    }

    // MARK: - Helpers

    // this is a limited html unescaper that is done to just to fix the amperstands so that urls work
    // slashdot is a good example of why we do this, the gt can be assumed to be part of the url
    func htmlUnescape(_ orig: String) -> String {

        let swaps: [String: String] = ["&amp;": "&", "&lt;": "<", "&gt;": ">", "&quot;": "\"", "&apos;": "'"]
        var out = orig

        for pair in swaps {
            out = out.replacingOccurrences(of: pair.key, with: pair.value)
        }

        return out
    }

    // gets the proper URL based on html
    func cutURL(_ orig: String) -> String {

        // Removes &aaa when not followed by a ; (look that we get to the end without finding a ;)
        guard let match = orig.range(of: "&[^;]*(?!;)$", options: .regularExpression) else {
            return orig
        }

        var out = orig
        out.replaceSubrange(match, with: "")

        return out
    }
}

