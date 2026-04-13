//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

struct DomainEntityTransformer {

    func transform(_ domain: String) -> DomainEntity {
        return DomainEntity(name: domain)
    }

    func transform(_ data: GraphQL.ListEmailDomainsQuery.Data.ListEmailDomain) throws -> EmailDomainEntity {
        var metadata: [String: String] = [:]
        do {
            if let jsonData = data.metadata.data(using: .utf8),
               let metadataDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: String] {
                metadata = metadataDict
            }
        } catch {
            // If metadata is present but not valid JSON, we will ignore it and return empty object.
            metadata = [:]
        }

        return EmailDomainEntity(
            domain: data.domain,
            isMaskDomain: data.isMaskDomain,
            metadata: metadata
        )
    }
}
