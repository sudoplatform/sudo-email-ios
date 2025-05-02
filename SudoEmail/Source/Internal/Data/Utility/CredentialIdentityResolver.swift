//
// Copyright © 2025 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import AWSCognitoAuthPlugin
import Foundation
import struct Smithy.Attributes
import SmithyIdentity

struct CredentialIdentityResolver: AWSCredentialIdentityResolver {

    // MARK: - Conformance: AWSCredentialIdentityResolver

    func getIdentity(identityProperties: Attributes? = nil) async throws -> AWSCredentialIdentity {
        guard
            let authPlugin = try? Amplify.Auth.getPlugin(for: "awsCognitoAuthPlugin") as? AWSCognitoAuthPlugin,
            let authSession = try? await authPlugin.fetchAuthSession(options: nil) as? AWSAuthCognitoSession,
            let credentials = try? authSession.getAWSCredentials().get() as? AuthAWSCognitoCredentials
        else {
            throw SudoEmailError.notSignedIn
        }
        return AWSCredentialIdentity(
            accessKey: credentials.accessKeyId,
            secret: credentials.secretAccessKey,
            expiration: credentials.expiration,
            sessionToken: credentials.sessionToken
        )
    }
}
