//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import MailCore

public class HTMLRenderer: NSObject, MCOHTMLRendererDelegate {

    // Stops the renderer inserting a <hr> separator element just above the attachment text
    public func mcoAbstractMessage_template(forAttachmentSeparator msg: MCOAbstractMessage!) -> String {
        return ""
    }

    // Stops the renderer from applying a template to the message
    public func mcoAbstractMessage_template(for msg: MCOAbstractMessage!) -> String {
        return "{{BODY}}"
    }

    // Stops the renderer from inserting attachment text in the email body, i.e. `- some_file.txt, 0 bytes`
    public func mcoAbstractMessage(_ msg: MCOAbstractMessage!, templateForAttachment part: MCOAbstractPart!) -> String {
        return ""
    }

    // Stops the renderer inserting "TO: ...", "FROM: ...",  etc. at the beginning of the email body.
    public func mcoAbstractMessage(_ msg: MCOAbstractMessage!, templateForMainHeader header: MCOMessageHeader!) -> String {
        return ""
    }

    // Stops mailcore default HTML renderer stripping out parts of the email body.
    public func mcoAbstractMessage(_ msg: MCOAbstractMessage!, cleanHTMLForPart html: String) -> String {
        return html
    }
}
