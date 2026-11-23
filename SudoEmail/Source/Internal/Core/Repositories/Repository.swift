//
// Copyright © 2026 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoApiClient

protocol Repository: AnyObject {
    var sudoApiClient: SudoApiClient { get }
    func perform<Mutation: GraphQLMutation>(_ mutation: Mutation) async throws -> Mutation.Data
    func fetch<Query: GraphQLQuery>(_ query: Query) async throws -> Query.Data
}

extension Repository {

    func perform<Mutation: GraphQLMutation>(_ mutation: Mutation) async throws -> Mutation.Data {
        do {
            return try await sudoApiClient.perform(mutation: mutation)
        } catch {
            throw SudoEmailError.fromApiOperationError(error: error)
        }
    }

    /// Execute a mutation, translating any failure into a `SudoEmailError`, and first calling `onDefinitiveRejection`
    /// if the failure proves the service didn't carry the mutation out.
    ///
    /// The rejection is decided from the raw error, before it is mapped; see `SudoEmailError.isDefinitiveRejection(_:)`.
    ///
    /// - Parameters:
    ///   - mutation: The mutation to perform.
    ///   - onDefinitiveRejection: Undoes local work done for the mutation, such as a key generated for it, when the
    ///     service definitely didn't act on it.
    func perform<Mutation: GraphQLMutation>(
        _ mutation: Mutation,
        onDefinitiveRejection: () -> Void
    ) async throws -> Mutation.Data {
        do {
            return try await sudoApiClient.perform(mutation: mutation)
        } catch {
            if SudoEmailError.isDefinitiveRejection(error) {
                onDefinitiveRejection()
            }
            throw SudoEmailError.fromApiOperationError(error: error)
        }
    }

    func fetch<Query: GraphQLQuery>(_ query: Query) async throws -> Query.Data {
        do {
            return try await sudoApiClient.fetch(query: query)
        } catch {
            throw SudoEmailError.fromApiOperationError(error: error)
        }
    }
}
