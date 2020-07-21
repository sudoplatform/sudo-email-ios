//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoProfiles

/// Data implementation of the core `OwnershipProofRepository`.
///
/// Uses `SudoProfilesClient` to access the user's ownership proofs.
class ProfilesOwnershipProofRepository: OwnershipProofRepository {

    // MARK: - Supplementary

    /// Audience attribute for the ownership proof.
    let emailAudience = "sudoplatform.email.email-address"

    // MARK: - Properties

    /// Instance of  the profiles client, used to access the ownership proof.
    unowned var profilesClient: SudoProfilesClient

    // MARK: - Lifecycle

    /// Initialize an instance of `ProfilesOwnershipProofRepository`.
    init(profilesClient: SudoProfilesClient) {
        self.profilesClient = profilesClient
    }

    // MARK: - OwnershipProofRepository

    func getWithId(_ id: String, completion: @escaping ClientCompletion<String>) {
        let sudo = Sudo(id: id)
        do {
            try profilesClient.getOwnershipProof(sudo: sudo, audience: emailAudience) { result in
                switch result {
                case let .success(jwt):
                    completion(.success(jwt))
                case let .failure(cause):
                    completion(.failure(cause))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }

}
