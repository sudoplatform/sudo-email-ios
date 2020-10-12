//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of an email address business rule. Depicts the address of an email address that a user may own or send mail to.
struct EmailAddressEntity: Equatable {

    // MARK: - Properties

    /// The local part of the email address. For example, `example@sudoplatform.com`, `example` is the local part.
    var localPart: String

    /// The domain of the email address. For example, `example@sudoplatform.com`, `sudoplatform.com` is the domain.
    var domain: String

    /// The display name of the email address
    var displayName: String?

    /// Returns the fully structured email address.
    var address: String {
        return "\(localPart)@\(domain)"
    }

    // MARK: - Lifecycle

    /// Initialize an instance of `EmailAddressEntity`.
    /// - Parameters:
    ///   - localPart: Local part of the email address.
    ///   - domain: Domain of the email address.
    init(localPart: String, domain: String, displayName: String? = nil) {
        self.localPart = localPart
        self.domain = domain
        self.displayName = displayName
    }

}
