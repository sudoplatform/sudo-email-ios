//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import AWSS3

/// Utility class to transform data received from AWSS3 to the Core/Entity level of the SDK.
struct DraftEmailMetadataEntityTransformer {

    func transform(awsS3Object: AWSS3Object, s3KeyPrefix: String) throws -> DraftEmailMessageMetadataEntity {
        guard let key = awsS3Object.key else {
            throw SudoEmailError.internalError("draft email message has no id")
        }
        guard let updatedAt = awsS3Object.lastModified else {
            throw SudoEmailError.internalError("draft email message has no last modified date")
        }
        return DraftEmailMessageMetadataEntity(
            id: key.replacingOccurrences(of: s3KeyPrefix, with: ""),
            updatedAt: updatedAt
        )
    }

    func transform(_ entity: DraftEmailMessageMetadataEntity) -> DraftEmailMessageMetadata {
        return DraftEmailMessageMetadata(
            id: entity.id,
            updatedAt: entity.updatedAt
        )
    }
}
