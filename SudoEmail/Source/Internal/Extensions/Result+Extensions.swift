//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

extension Result where Failure: Error {

    /// Returns a new result, mapping any success value using the given
    /// transformation. If the transformation fails, the failure error will be mapped to `.failure(Error)`.
    ///
    /// Use this method when you need to transform the value of a `Result`
    /// instance when it represents a success. The following example transforms
    /// the integer success value of a result into a string:
    ///
    ///     func getNextInteger() -> Result<Int, Error> { /* ... */ }
    ///
    ///     let integerResult = getNextInteger()
    ///     // integerResult == .success(5)
    ///     let stringResult = integerResult.map({ String($0) })
    ///     // stringResult == .success("5")
    ///
    /// - Parameter transform: A closure that takes the success value of this
    ///   instance.
    /// - Returns: A `Result` instance with the result of evaluating `transform`
    ///   as the new success value if this instance represents a success.
    func mapThrowingSuccess<NewSuccess>(_ transform: (Success) throws -> NewSuccess) -> Result<NewSuccess, Error> {
        switch self {
        case .failure(let error):
            return .failure(error)
        case .success(let success):
            do {
                let newSuccess = try transform(success)
                return .success(newSuccess)
            } catch {
                return .failure(error)
            }
        }
    }

    /// Will return whether or not the instance is a `success` case
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }

    /// Will return the associated success value from the instance if it is the `success` case
    var value: Success? {
        switch self {
        case .success(let output):
            return output
        case .failure:
            return nil
        }
    }

    /// Will return whether or not the instance is the `failed` case
    var isFailure: Bool {
        switch self {
        case .failure:
            return true
        case .success:
            return false
        }
    }

    /// Will return the associated error if the instnace is the `failed` case
    var error: Failure? {
        switch self {
        case .failure(let output):
            return output
        case .success:
            return nil
        }
    }
}
