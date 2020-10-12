//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of an email account business rule. Depicts the information of the user's account and related information.
struct EmailAccountEntity: Equatable {

    /// Unique identifier of the email account.
    var id: String

    /// Unique identifier of the user that owns the email account.
    var userId: String

    /// Unique identifier of the sudo that owns the email account.
    var sudoId: String

    /// Unique identifier of the identity of the email account.
    var identityId: String

    /// Unique identifier of the key ring associated with the email account.
    var keyRingId: String

    /// Email address associated with the account.
    var emailAddress: EmailAddressEntity

    /// Identifier of the owners of the account.
    var owners: [OwnerEntity]

    /// Timestamp of when the account was created on the service.
    var created: Date

    /// Timestamp of when the account was last updated on the service.
    var updated: Date

}
