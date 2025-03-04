//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Utility class to transform list API result entities from the Core level to output results of the SDK.
struct ListAPIResultTransformer {

    /// Utility to transform email message entites to email messages.
    let emailMessageTransformer = EmailMessageAPITransformer()

    func transformEmailMessages(_ result: ListAPIResult<EmailMessageEntity, PartialEmailMessageEntity>) -> ListAPIResult<EmailMessage, PartialEmailMessage> {
        switch result {
        case .success(let messageEntities):
            let messages = messageEntities.items.map(emailMessageTransformer.transform(_:))
            let listSuccessResult = ListAPIResult<EmailMessage, PartialEmailMessage>.ListSuccessResult(
                items: messages,
                nextToken: messageEntities.nextToken
            )
            return ListAPIResult.success(listSuccessResult)
        case .partial(let partialMessageResults):
            var partialResults: [PartialResult<PartialEmailMessage>] = []
            for partialMessageResult in partialMessageResults.failed {
                let partialMessage = emailMessageTransformer.transform(partialMessageResult.partial)
                partialResults.append(PartialResult(
                    partial: partialMessage,
                    error: partialMessageResult.error
                ))
            }
            let successMessages = partialMessageResults.items.map(emailMessageTransformer.transform(_:))
            let listPartialResult = ListAPIResult.ListPartialResult(
                items: successMessages,
                failed: partialResults,
                nextToken: partialMessageResults.nextToken
            )
            return ListAPIResult.partial(listPartialResult)
        }
    }
}
