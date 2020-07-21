//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Utility class to transform data received from API and GraphQL to the Core/Entity level of the SDK.
struct EmailMessageDirectionEntityTransformer {

    /// Transform the success result of `EmailMessageDirection` from the service to a `EmailMessageEntity`.
    func transform(_ graphQL: EmailMessageDirection) throws -> DirectionEntity {
        switch graphQL {
        case .inbound:
            return .inbound
        case .outbound:
            return .outbound
        case let .unknown(direction):
            throw SudoEmailError.internalError("Unsupported email message direction: \(direction)")
        }
    }

    /// Transform an API input `EmailMessage.Direction` into a `DirectionEntity`.
    ///
    /// If input is `nil`, `nil` will be returned.
    func transform(_ apiInput: EmailMessage.Direction?) -> DirectionEntity? {
        guard let apiInput = apiInput else {
            return nil
        }
        return transform(apiInput)
    }

    /// Transform an API input `EmailMessage.Direction` into a `DirectionEntity`.
    func transform(_ apiInput: EmailMessage.Direction) -> DirectionEntity {
        switch apiInput {
        case .inbound:
            return .inbound
        case .outbound:
            return .outbound
        }
    }

}
