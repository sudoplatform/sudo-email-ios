//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// Core entity representation of a ownership proof repository used in business logic. Used to perform CRUD operations for ownership proofs.
protocol OwnershipProofRepository: class {

    /// Get an ownership proof with an identifier.
    /// - Parameters:
    ///   - id: Identifier of the sudo.
    ///   - completion: Returns a ownership proof on success, or an error on failure.
    func getWithId(_ id: String, completion: @escaping ClientCompletion<String>)

}
