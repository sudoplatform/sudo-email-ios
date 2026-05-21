//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public enum BlockedEmailAddressLevel {

    // Block just the specific email address
    case address

    // Block all email addresses from the same domain
    case domain
}
