//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
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

    /// The hashed value of the blocked address. This can be used to unblock the address in the event the unsealing failed
    public var hashedBlockedValue: String
    
    /// The plaintext address that has been blocked
    public var address: String
    
    /// The status of the retrieval and unsealing. If 'Failed' the address property will likely be empty, but the hashed value will be available
    public var status: UnsealedBlockedAddressStatus
}
