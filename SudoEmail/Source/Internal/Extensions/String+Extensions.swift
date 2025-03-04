//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

extension String {
    var nilIfEmpty: String? {
        isEmpty ? nil : self
    }
}
