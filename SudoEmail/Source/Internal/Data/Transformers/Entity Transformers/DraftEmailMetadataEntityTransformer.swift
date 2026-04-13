//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSS3
import Foundation

/// Utility class to transform data received from AWSS3 to the Core/Entity level of the SDK.
struct DraftEmailMetadataEntityTransformer {

    func transform(
        awsS3Object: S3ClientTypes.Object,
        s3KeyPrefix: String,
        emailAddressId: String
    ) throws -> DraftEmailMessageMetadataEntity {
        var fullS3KeyPrefix = s3KeyPrefix
        guard let key = awsS3Object.key else {
            throw SudoEmailError.internalError("draft email message has no id")
        }
        guard let updatedAt = awsS3Object.lastModified else {
            throw SudoEmailError.internalError("draft email message has no last modified date")
        }
        let emailMaskId = extractEmailMaskIdFromDraftMessageS3Key(key: key)
        if let emailMaskId, !emailMaskId.isEmpty {
            fullS3KeyPrefix += "mask/\(emailMaskId)/"
        }
        return DraftEmailMessageMetadataEntity(
            id: key.replacingOccurrences(of: fullS3KeyPrefix, with: ""),
            emailAddressId: emailAddressId,
            updatedAt: updatedAt,
            emailMaskId: emailMaskId
        )
    }

    func transform(_ entity: DraftEmailMessageMetadataEntity) -> DraftEmailMessageMetadata {
        return DraftEmailMessageMetadata(
            id: entity.id,
            emailAddressId: entity.emailAddressId,
            updatedAt: entity.updatedAt,
            emailMaskId: entity.emailMaskId
        )
    }

    /// Extracts the email mask ID from a draft message S3 key.
    /// - Parameter key: The S3 key string
    /// - Returns: The email mask ID if found, otherwise `nil`
    private func extractEmailMaskIdFromDraftMessageS3Key(key: String) -> String? {
        let pattern = #"/mask/([^/]+)/"# // matches '/mask/{emailMaskId}/'
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        let nsRange = NSRange(key.startIndex ..< key.endIndex, in: key)
        guard let match = regex.firstMatch(in: key, options: [], range: nsRange),
              match.numberOfRanges > 1,
              let range = Range(match.range(at: 1), in: key) else {
            return nil
        }
        return String(key[range])
    }
}
