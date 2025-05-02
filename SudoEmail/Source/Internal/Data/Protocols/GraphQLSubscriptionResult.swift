//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

protocol GraphQLSubscriptionResult {}
extension GraphQL.OnEmailMessageCreatedSubscription.Data: GraphQLSubscriptionResult {}
extension GraphQL.OnEmailMessageUpdatedSubscription.Data: GraphQLSubscriptionResult {}
extension GraphQL.OnEmailMessageDeletedSubscription.Data: GraphQLSubscriptionResult {}
