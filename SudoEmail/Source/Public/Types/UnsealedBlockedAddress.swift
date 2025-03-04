//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Representation of an unsealed blocked email address in Platform SDK
public struct UnsealedBlockedAddress {

    /// The state of the retreival and unsealing procedure of a particular blocked address
    /// If the status is 'Failed' there will be an error indicating the cause.
    public enum UnsealedBlockedAddressStatus {
        case completed
        case failed(cause: Error)
    }

    /// The action to take on incoming messages from the blocked address
    public enum BlockedAddressAction {
        /// Do nothing. Message will not appear in user's account
        case drop
        /// Redirect to SPAM folder, if available
        case spam
    }

    /// The hashed value of the blocked address. This can be used to unblock the address in the event the unsealing failed
    public var hashedBlockedValue: String

    /// The plaintext address that has been blocked
    public var address: String

    /// The action to take on incoming messages from the blocked address
    public var action: BlockedAddressAction

    /// The status of the retrieval and unsealing. If 'Failed' the address property will likely be empty, but the hashed value will be available
    public var status: UnsealedBlockedAddressStatus
    /// The id of the email address for which the blocked address is blocked. If not present, blocked address cannot send to any of owner's addresses.
    public var emailAddressId: String?
}
