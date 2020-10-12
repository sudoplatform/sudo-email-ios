//
// Copyright © 2020 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// Core entity representation of a email message unsealer service used in business logic.
///
/// Used to unseal email messages that are received, typically from a sealed email message repository.
protocol EmailMessageUnsealerService: class {

    /// Unseal an email message.
    /// - Parameter sealedEmailMessage: Sealed email message to be unsealed.
    /// - Returns: Unsealed email message.
    /// - Throws: `SudoEmailError` on failure to unseal email message
    func unsealEmailMessage(_ sealedEmailMessage: SealedEmailMessageEntity) throws -> EmailMessageEntity

    /// Unseal the email message RFC 6854 (supersedes RFC 822) data.
    /// - Parameters:
    ///   - data: Sealed data containing the RFC 6854 data.
    ///   - keyId: Key identifier to use to lookup the key to unseal the data.
    ///   - algorithm: Algorithm that was used to seal the input RFC 6854 data.
    /// - Returns: Unsealed emaill message RFC 6854 data.
    /// - Throws: `SudoEmailError` on failure to unseal email message data.
    func unsealEmailMessageRFC822Data(_ data: Data, withKeyId keyId: String, algorithm: String) throws -> Data
}
