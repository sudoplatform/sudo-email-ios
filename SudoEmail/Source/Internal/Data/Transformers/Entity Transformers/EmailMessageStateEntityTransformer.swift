//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform data received from GraphQL to the Core/Entity level of the SDK.
struct EmailMessageStateEntityTransformer {

    /// Transform the success result of `EmailMessageState` from the service to a `EmailMessageEntity`.
    func transform(_ graphQL: GraphQL.EmailMessageState) throws -> StateEntity {
        switch graphQL {
        case .queued:
            return .queued
        case .sent:
            return .sent
        case .delivered:
            return .delivered
        case .undelivered:
            return .undelivered
        case .failed:
            return .failed
        case .received:
            return .received
        case let .unknown(state):
            throw SudoEmailError.internalError("Unsupported state: \(state)")
        }
    }

    /// Transform an API input `EmailMessage.Direction` into a `DirectionEntity`.
        func transform(_ apiInput: EmailMessage.State) -> StateEntity {
        switch apiInput {
        case .queued:
            return .queued
        case .sent:
            return .sent
        case .delivered:
            return .delivered
        case .undelivered:
            return .undelivered
        case .failed:
            return .failed
        case .received:
            return .received
        }
    }

}
