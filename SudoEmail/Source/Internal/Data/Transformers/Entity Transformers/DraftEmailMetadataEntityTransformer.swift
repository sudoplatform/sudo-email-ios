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
        guard let key = awsS3Object.key else {
            throw SudoEmailError.internalError("draft email message has no id")
        }
        guard let updatedAt = awsS3Object.lastModified else {
            throw SudoEmailError.internalError("draft email message has no last modified date")
        }
        return DraftEmailMessageMetadataEntity(
            id: key.replacingOccurrences(of: s3KeyPrefix, with: ""),
            emailAddressId: emailAddressId,
            updatedAt: updatedAt
        )
    }

    func transform(_ entity: DraftEmailMessageMetadataEntity) -> DraftEmailMessageMetadata {
        return DraftEmailMessageMetadata(
            id: entity.id,
            emailAddressId: entity.emailAddressId,
            updatedAt: entity.updatedAt
        )
    }
}
