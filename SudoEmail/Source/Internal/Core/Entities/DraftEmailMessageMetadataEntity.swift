//
// Copyright © 2022 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a draft email message metadata business rule. Depicts the meta data of a draft email message.
struct DraftEmailMessageMetadataEntity: Equatable {

    /// Unique identifier of the draft email message.
    public var id: String

    /// Time at which the draft was last updated
    public var updatedAt: Date
}
