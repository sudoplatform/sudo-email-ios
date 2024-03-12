//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct EmailAddressDetail {
    
    // MARK: - Properties
    
    /// The email address in the format `local-part@domain.com`
    var emailAddress: String
    
    /// Optional display name for the address
    var displayName: String?
}
