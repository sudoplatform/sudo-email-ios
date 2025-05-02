//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoApiClient

protocol Repository: AnyObject {
    var appSyncClient: SudoApiClient { get }
    func perform<Mutation: GraphQLMutation>(_ mutation: Mutation) async throws -> Mutation.Data
    func fetch<Query: GraphQLQuery>(_ query: Query) async throws -> Query.Data
}

extension Repository {

    func perform<Mutation: GraphQLMutation>(_ mutation: Mutation) async throws -> Mutation.Data {
        do {
            return try await appSyncClient.perform(mutation: mutation)
        } catch {
            throw SudoEmailError.fromApiOperationError(error: error)
        }
    }

    func fetch<Query: GraphQLQuery>(_ query: Query) async throws -> Query.Data {
        do {
            return try await appSyncClient.fetch(query: query)
        } catch {
            throw SudoEmailError.fromApiOperationError(error: error)
        }
    }
}
