//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// input object for Provisioning an email address using `SudoEmailClient`
public struct CheckEmailAddressAvailabilityInput: Equatable {

    /// The local parts of the email address to check. Local parts require the following
    ///   criteria:
    ///     - At least one local part is required.
    ///     - A maximum of 5 local parts per API request.
    ///     - Local parts must not exceed 64 characters.
    ///     - Local parts must match the following pattern: `^[a-zA-Z0-9](\.?[-_a-zA-Z0-9])*$`
    public let localParts: [String]

    /// The domains of the email address to check. If left undefined, will use default recognized by the service.
    public let domains: [String]?

    public init(localParts: [String], domains: [String]? = nil) {
        self.localParts = localParts
        self.domains = domains
    }
}
