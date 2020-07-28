//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSAppSync

/// Represents a subscription. When this object is released, the subscription is cancelled.
///
/// If reference is lost to this token, the subscription will be automatically cancelled on cleanup.
public protocol SubscriptionToken: class {
    /// Cancel the subscription.
    func cancel()
}