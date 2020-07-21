//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoOperations
import SudoLogging

/// Get the ownership proof of the sudo.
class GetOwnershipProofOperation: PlatformOperation {

    // MARK: - Properties

    /// Result object of the operation. The ownership proof.
    var resultObject: String?

    /// Sudo identifier used to get the ownership proof.
    let sudoId: String

    /// Key pair repository to get the ownership proof.
    unowned let ownershipProofRepository: OwnershipProofRepository

    // MARK: - Lifecycle

    /// Initialize an instance of `GetOwnershipProofOperation`.
    init(sudoId: String, ownershipProofRepository: OwnershipProofRepository, logger: Logger) {
        self.sudoId = sudoId
        self.ownershipProofRepository = ownershipProofRepository
        super.init(logger: logger)
    }

    // MARK: - PlatformOperation

    override func execute() {
        ownershipProofRepository.getWithId(sudoId) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case let .success(ownershipProof):
                weakSelf.resultObject = ownershipProof
                weakSelf.finish()
            case let .failure(error):
                weakSelf.finishWithError(error)
            }
        }
    }

}
