//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// The result of a successfull email message update
public struct UpdatedEmailMessageSuccess {
    let id: String
    
    let createdAt: Date
    
    let updatedAt: Date
}
