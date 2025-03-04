// swiftlint:disable all
//  This file was automatically generated and should not be edited.

import AWSAppSync

struct GraphQL {

internal enum BlockedAddressHashAlgorithm: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  internal typealias RawValue = String
  case sha256
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  internal init?(rawValue: RawValue) {
    switch rawValue {
      case "SHA256": self = .sha256
      default: self = .unknown(rawValue)
    }
  }

  internal var rawValue: RawValue {
    switch self {
      case .sha256: return "SHA256"
      case .unknown(let value): return value
    }
  }

  internal static func == (lhs: BlockedAddressHashAlgorithm, rhs: BlockedAddressHashAlgorithm) -> Bool {
    switch (lhs, rhs) {
      case (.sha256, .sha256): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

internal enum BlockedAddressAction: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  internal typealias RawValue = String
  case drop
  case spam
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  internal init?(rawValue: RawValue) {
    switch rawValue {
      case "DROP": self = .drop
      case "SPAM": self = .spam
      default: self = .unknown(rawValue)
    }
  }

  internal var rawValue: RawValue {
    switch self {
      case .drop: return "DROP"
      case .spam: return "SPAM"
      case .unknown(let value): return value
    }
  }

  internal static func == (lhs: BlockedAddressAction, rhs: BlockedAddressAction) -> Bool {
    switch (lhs, rhs) {
      case (.drop, .drop): return true
      case (.spam, .spam): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

internal enum UpdateBlockedAddressesStatus: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  internal typealias RawValue = String
  case failed
  case partial
  case success
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  internal init?(rawValue: RawValue) {
    switch rawValue {
      case "FAILED": self = .failed
      case "PARTIAL": self = .partial
      case "SUCCESS": self = .success
      default: self = .unknown(rawValue)
    }
  }

  internal var rawValue: RawValue {
    switch self {
      case .failed: return "FAILED"
      case .partial: return "PARTIAL"
      case .success: return "SUCCESS"
      case .unknown(let value): return value
    }
  }

  internal static func == (lhs: UpdateBlockedAddressesStatus, rhs: UpdateBlockedAddressesStatus) -> Bool {
    switch (lhs, rhs) {
      case (.failed, .failed): return true
      case (.partial, .partial): return true
      case (.success, .success): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

internal enum KeyFormat: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  internal typealias RawValue = String
  case rsaPublicKey
  case spki
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  internal init?(rawValue: RawValue) {
    switch rawValue {
      case "RSA_PUBLIC_KEY": self = .rsaPublicKey
      case "SPKI": self = .spki
      default: self = .unknown(rawValue)
    }
  }

  internal var rawValue: RawValue {
    switch self {
      case .rsaPublicKey: return "RSA_PUBLIC_KEY"
      case .spki: return "SPKI"
      case .unknown(let value): return value
    }
  }

  internal static func == (lhs: KeyFormat, rhs: KeyFormat) -> Bool {
    switch (lhs, rhs) {
      case (.rsaPublicKey, .rsaPublicKey): return true
      case (.spki, .spki): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

internal enum EmailMessageDirection: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  internal typealias RawValue = String
  case inbound
  case outbound
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  internal init?(rawValue: RawValue) {
    switch rawValue {
      case "INBOUND": self = .inbound
      case "OUTBOUND": self = .outbound
      default: self = .unknown(rawValue)
    }
  }

  internal var rawValue: RawValue {
    switch self {
      case .inbound: return "INBOUND"
      case .outbound: return "OUTBOUND"
      case .unknown(let value): return value
    }
  }

  internal static func == (lhs: EmailMessageDirection, rhs: EmailMessageDirection) -> Bool {
    switch (lhs, rhs) {
      case (.inbound, .inbound): return true
      case (.outbound, .outbound): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

internal enum EmailMessageState: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  internal typealias RawValue = String
  case deleted
  case delivered
  case failed
  case queued
  case received
  case sent
  case undelivered
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  internal init?(rawValue: RawValue) {
    switch rawValue {
      case "DELETED": self = .deleted
      case "DELIVERED": self = .delivered
      case "FAILED": self = .failed
      case "QUEUED": self = .queued
      case "RECEIVED": self = .received
      case "SENT": self = .sent
      case "UNDELIVERED": self = .undelivered
      default: self = .unknown(rawValue)
    }
  }

  internal var rawValue: RawValue {
    switch self {
      case .deleted: return "DELETED"
      case .delivered: return "DELIVERED"
      case .failed: return "FAILED"
      case .queued: return "QUEUED"
      case .received: return "RECEIVED"
      case .sent: return "SENT"
      case .undelivered: return "UNDELIVERED"
      case .unknown(let value): return value
    }
  }

  internal static func == (lhs: EmailMessageState, rhs: EmailMessageState) -> Bool {
    switch (lhs, rhs) {
      case (.deleted, .deleted): return true
      case (.delivered, .delivered): return true
      case (.failed, .failed): return true
      case (.queued, .queued): return true
      case (.received, .received): return true
      case (.sent, .sent): return true
      case (.undelivered, .undelivered): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

internal enum EmailMessageEncryptionStatus: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  internal typealias RawValue = String
  case encrypted
  case unencrypted
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  internal init?(rawValue: RawValue) {
    switch rawValue {
      case "ENCRYPTED": self = .encrypted
      case "UNENCRYPTED": self = .unencrypted
      default: self = .unknown(rawValue)
    }
  }

  internal var rawValue: RawValue {
    switch self {
      case .encrypted: return "ENCRYPTED"
      case .unencrypted: return "UNENCRYPTED"
      case .unknown(let value): return value
    }
  }

  internal static func == (lhs: EmailMessageEncryptionStatus, rhs: EmailMessageEncryptionStatus) -> Bool {
    switch (lhs, rhs) {
      case (.encrypted, .encrypted): return true
      case (.unencrypted, .unencrypted): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

internal enum UpdateEmailMessagesStatus: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  internal typealias RawValue = String
  case failed
  case partial
  case success
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  internal init?(rawValue: RawValue) {
    switch rawValue {
      case "FAILED": self = .failed
      case "PARTIAL": self = .partial
      case "SUCCESS": self = .success
      default: self = .unknown(rawValue)
    }
  }

  internal var rawValue: RawValue {
    switch self {
      case .failed: return "FAILED"
      case .partial: return "PARTIAL"
      case .success: return "SUCCESS"
      case .unknown(let value): return value
    }
  }

  internal static func == (lhs: UpdateEmailMessagesStatus, rhs: UpdateEmailMessagesStatus) -> Bool {
    switch (lhs, rhs) {
      case (.failed, .failed): return true
      case (.partial, .partial): return true
      case (.success, .success): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

internal struct DeleteEmailMessagesInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(messageIds: [GraphQLID]) {
    graphQLMap = ["messageIds": messageIds]
  }

  internal var messageIds: [GraphQLID] {
    get {
      return graphQLMap["messageIds"] as! [GraphQLID]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "messageIds")
    }
  }
}

internal struct ProvisionEmailAddressInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(alias: Optional<SealedAttributeInput?> = nil, emailAddress: String, key: ProvisionEmailAddressPublicKeyInput, ownershipProofTokens: [String]) {
    graphQLMap = ["alias": alias, "emailAddress": emailAddress, "key": key, "ownershipProofTokens": ownershipProofTokens]
  }

  internal var alias: Optional<SealedAttributeInput?> {
    get {
      return graphQLMap["alias"] as! Optional<SealedAttributeInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "alias")
    }
  }

  internal var emailAddress: String {
    get {
      return graphQLMap["emailAddress"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddress")
    }
  }

  internal var key: ProvisionEmailAddressPublicKeyInput {
    get {
      return graphQLMap["key"] as! ProvisionEmailAddressPublicKeyInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "key")
    }
  }

  internal var ownershipProofTokens: [String] {
    get {
      return graphQLMap["ownershipProofTokens"] as! [String]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ownershipProofTokens")
    }
  }
}

internal struct SealedAttributeInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(algorithm: String, base64EncodedSealedData: String, keyId: String, plainTextType: String) {
    graphQLMap = ["algorithm": algorithm, "base64EncodedSealedData": base64EncodedSealedData, "keyId": keyId, "plainTextType": plainTextType]
  }

  internal var algorithm: String {
    get {
      return graphQLMap["algorithm"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "algorithm")
    }
  }

  internal var base64EncodedSealedData: String {
    get {
      return graphQLMap["base64EncodedSealedData"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "base64EncodedSealedData")
    }
  }

  internal var keyId: String {
    get {
      return graphQLMap["keyId"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "keyId")
    }
  }

  internal var plainTextType: String {
    get {
      return graphQLMap["plainTextType"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "plainTextType")
    }
  }
}

internal struct ProvisionEmailAddressPublicKeyInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(algorithm: String, keyFormat: Optional<KeyFormat?> = nil, keyId: String, publicKey: String) {
    graphQLMap = ["algorithm": algorithm, "keyFormat": keyFormat, "keyId": keyId, "publicKey": publicKey]
  }

  internal var algorithm: String {
    get {
      return graphQLMap["algorithm"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "algorithm")
    }
  }

  internal var keyFormat: Optional<KeyFormat?> {
    get {
      return graphQLMap["keyFormat"] as! Optional<KeyFormat?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "keyFormat")
    }
  }

  internal var keyId: String {
    get {
      return graphQLMap["keyId"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "keyId")
    }
  }

  internal var publicKey: String {
    get {
      return graphQLMap["publicKey"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "publicKey")
    }
  }
}

internal struct DeprovisionEmailAddressInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(emailAddressId: GraphQLID) {
    graphQLMap = ["emailAddressId": emailAddressId]
  }

  internal var emailAddressId: GraphQLID {
    get {
      return graphQLMap["emailAddressId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddressId")
    }
  }
}

internal struct UpdateEmailAddressMetadataInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(id: GraphQLID, values: EmailAddressMetadataUpdateValuesInput) {
    graphQLMap = ["id": id, "values": values]
  }

  internal var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  internal var values: EmailAddressMetadataUpdateValuesInput {
    get {
      return graphQLMap["values"] as! EmailAddressMetadataUpdateValuesInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "values")
    }
  }
}

internal struct EmailAddressMetadataUpdateValuesInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(alias: Optional<SealedAttributeInput?> = nil) {
    graphQLMap = ["alias": alias]
  }

  internal var alias: Optional<SealedAttributeInput?> {
    get {
      return graphQLMap["alias"] as! Optional<SealedAttributeInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "alias")
    }
  }
}

internal struct SendEmailMessageInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(clientRefId: Optional<String?> = nil, emailAddressId: GraphQLID, message: S3EmailObjectInput) {
    graphQLMap = ["clientRefId": clientRefId, "emailAddressId": emailAddressId, "message": message]
  }

  internal var clientRefId: Optional<String?> {
    get {
      return graphQLMap["clientRefId"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "clientRefId")
    }
  }

  internal var emailAddressId: GraphQLID {
    get {
      return graphQLMap["emailAddressId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddressId")
    }
  }

  internal var message: S3EmailObjectInput {
    get {
      return graphQLMap["message"] as! S3EmailObjectInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "message")
    }
  }
}

internal struct S3EmailObjectInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(bucket: String, key: String, region: String) {
    graphQLMap = ["bucket": bucket, "key": key, "region": region]
  }

  internal var bucket: String {
    get {
      return graphQLMap["bucket"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "bucket")
    }
  }

  internal var key: String {
    get {
      return graphQLMap["key"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "key")
    }
  }

  internal var region: String {
    get {
      return graphQLMap["region"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "region")
    }
  }
}

internal struct SendEncryptedEmailMessageInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(clientRefId: Optional<String?> = nil, emailAddressId: GraphQLID, message: S3EmailObjectInput, rfc822Header: Rfc822HeaderInput) {
    graphQLMap = ["clientRefId": clientRefId, "emailAddressId": emailAddressId, "message": message, "rfc822Header": rfc822Header]
  }

  internal var clientRefId: Optional<String?> {
    get {
      return graphQLMap["clientRefId"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "clientRefId")
    }
  }

  internal var emailAddressId: GraphQLID {
    get {
      return graphQLMap["emailAddressId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddressId")
    }
  }

  internal var message: S3EmailObjectInput {
    get {
      return graphQLMap["message"] as! S3EmailObjectInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "message")
    }
  }

  internal var rfc822Header: Rfc822HeaderInput {
    get {
      return graphQLMap["rfc822Header"] as! Rfc822HeaderInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "rfc822Header")
    }
  }
}

internal struct Rfc822HeaderInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(bcc: [String], cc: [String], dateEpochMs: Optional<Double?> = nil, from: String, hasAttachments: Optional<Bool?> = nil, inReplyTo: Optional<String?> = nil, references: Optional<[String]?> = nil, replyTo: [String], subject: Optional<String?> = nil, to: [String]) {
    graphQLMap = ["bcc": bcc, "cc": cc, "dateEpochMs": dateEpochMs, "from": from, "hasAttachments": hasAttachments, "inReplyTo": inReplyTo, "references": references, "replyTo": replyTo, "subject": subject, "to": to]
  }

  internal var bcc: [String] {
    get {
      return graphQLMap["bcc"] as! [String]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "bcc")
    }
  }

  internal var cc: [String] {
    get {
      return graphQLMap["cc"] as! [String]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "cc")
    }
  }

  internal var dateEpochMs: Optional<Double?> {
    get {
      return graphQLMap["dateEpochMs"] as! Optional<Double?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "dateEpochMs")
    }
  }

  internal var from: String {
    get {
      return graphQLMap["from"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "from")
    }
  }

  internal var hasAttachments: Optional<Bool?> {
    get {
      return graphQLMap["hasAttachments"] as! Optional<Bool?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "hasAttachments")
    }
  }

  internal var inReplyTo: Optional<String?> {
    get {
      return graphQLMap["inReplyTo"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "inReplyTo")
    }
  }

  internal var references: Optional<[String]?> {
    get {
      return graphQLMap["references"] as! Optional<[String]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "references")
    }
  }

  internal var replyTo: [String] {
    get {
      return graphQLMap["replyTo"] as! [String]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "replyTo")
    }
  }

  internal var subject: Optional<String?> {
    get {
      return graphQLMap["subject"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "subject")
    }
  }

  internal var to: [String] {
    get {
      return graphQLMap["to"] as! [String]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "to")
    }
  }
}

internal struct UpdateEmailMessagesInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(messageIds: [GraphQLID], values: EmailMessageUpdateValuesInput) {
    graphQLMap = ["messageIds": messageIds, "values": values]
  }

  internal var messageIds: [GraphQLID] {
    get {
      return graphQLMap["messageIds"] as! [GraphQLID]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "messageIds")
    }
  }

  internal var values: EmailMessageUpdateValuesInput {
    get {
      return graphQLMap["values"] as! EmailMessageUpdateValuesInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "values")
    }
  }
}

internal struct EmailMessageUpdateValuesInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(folderId: Optional<GraphQLID?> = nil, seen: Optional<Bool?> = nil) {
    graphQLMap = ["folderId": folderId, "seen": seen]
  }

  internal var folderId: Optional<GraphQLID?> {
    get {
      return graphQLMap["folderId"] as! Optional<GraphQLID?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "folderId")
    }
  }

  internal var seen: Optional<Bool?> {
    get {
      return graphQLMap["seen"] as! Optional<Bool?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "seen")
    }
  }
}

internal struct BlockEmailAddressesInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(blockedAddresses: [BlockedEmailAddressInput], emailAddressId: Optional<String?> = nil, owner: GraphQLID) {
    graphQLMap = ["blockedAddresses": blockedAddresses, "emailAddressId": emailAddressId, "owner": owner]
  }

  internal var blockedAddresses: [BlockedEmailAddressInput] {
    get {
      return graphQLMap["blockedAddresses"] as! [BlockedEmailAddressInput]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "blockedAddresses")
    }
  }

  internal var emailAddressId: Optional<String?> {
    get {
      return graphQLMap["emailAddressId"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddressId")
    }
  }

  internal var owner: GraphQLID {
    get {
      return graphQLMap["owner"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "owner")
    }
  }
}

internal struct BlockedEmailAddressInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(action: Optional<BlockedAddressAction?> = nil, hashAlgorithm: BlockedAddressHashAlgorithm, hashedBlockedValue: String, sealedValue: SealedAttributeInput) {
    graphQLMap = ["action": action, "hashAlgorithm": hashAlgorithm, "hashedBlockedValue": hashedBlockedValue, "sealedValue": sealedValue]
  }

  internal var action: Optional<BlockedAddressAction?> {
    get {
      return graphQLMap["action"] as! Optional<BlockedAddressAction?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "action")
    }
  }

  internal var hashAlgorithm: BlockedAddressHashAlgorithm {
    get {
      return graphQLMap["hashAlgorithm"] as! BlockedAddressHashAlgorithm
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "hashAlgorithm")
    }
  }

  internal var hashedBlockedValue: String {
    get {
      return graphQLMap["hashedBlockedValue"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "hashedBlockedValue")
    }
  }

  internal var sealedValue: SealedAttributeInput {
    get {
      return graphQLMap["sealedValue"] as! SealedAttributeInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sealedValue")
    }
  }
}

internal struct UnblockEmailAddressesInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(owner: GraphQLID, unblockedAddresses: [String]) {
    graphQLMap = ["owner": owner, "unblockedAddresses": unblockedAddresses]
  }

  internal var owner: GraphQLID {
    get {
      return graphQLMap["owner"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "owner")
    }
  }

  internal var unblockedAddresses: [String] {
    get {
      return graphQLMap["unblockedAddresses"] as! [String]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "unblockedAddresses")
    }
  }
}

internal struct CreateCustomEmailFolderInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(customFolderName: SealedAttributeInput, emailAddressId: GraphQLID) {
    graphQLMap = ["customFolderName": customFolderName, "emailAddressId": emailAddressId]
  }

  internal var customFolderName: SealedAttributeInput {
    get {
      return graphQLMap["customFolderName"] as! SealedAttributeInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "customFolderName")
    }
  }

  internal var emailAddressId: GraphQLID {
    get {
      return graphQLMap["emailAddressId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddressId")
    }
  }
}

internal struct DeleteCustomEmailFolderInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(emailAddressId: GraphQLID, emailFolderId: GraphQLID) {
    graphQLMap = ["emailAddressId": emailAddressId, "emailFolderId": emailFolderId]
  }

  internal var emailAddressId: GraphQLID {
    get {
      return graphQLMap["emailAddressId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddressId")
    }
  }

  internal var emailFolderId: GraphQLID {
    get {
      return graphQLMap["emailFolderId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailFolderId")
    }
  }
}

internal struct UpdateCustomEmailFolderInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(emailAddressId: GraphQLID, emailFolderId: GraphQLID, values: CustomEmailFolderUpdateValuesInput) {
    graphQLMap = ["emailAddressId": emailAddressId, "emailFolderId": emailFolderId, "values": values]
  }

  internal var emailAddressId: GraphQLID {
    get {
      return graphQLMap["emailAddressId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddressId")
    }
  }

  internal var emailFolderId: GraphQLID {
    get {
      return graphQLMap["emailFolderId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailFolderId")
    }
  }

  internal var values: CustomEmailFolderUpdateValuesInput {
    get {
      return graphQLMap["values"] as! CustomEmailFolderUpdateValuesInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "values")
    }
  }
}

internal struct CustomEmailFolderUpdateValuesInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(customFolderName: Optional<SealedAttributeInput?> = nil) {
    graphQLMap = ["customFolderName": customFolderName]
  }

  internal var customFolderName: Optional<SealedAttributeInput?> {
    get {
      return graphQLMap["customFolderName"] as! Optional<SealedAttributeInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "customFolderName")
    }
  }
}

internal struct CreatePublicKeyInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(algorithm: String, keyFormat: Optional<KeyFormat?> = nil, keyId: String, keyRingId: String, publicKey: String) {
    graphQLMap = ["algorithm": algorithm, "keyFormat": keyFormat, "keyId": keyId, "keyRingId": keyRingId, "publicKey": publicKey]
  }

  internal var algorithm: String {
    get {
      return graphQLMap["algorithm"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "algorithm")
    }
  }

  internal var keyFormat: Optional<KeyFormat?> {
    get {
      return graphQLMap["keyFormat"] as! Optional<KeyFormat?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "keyFormat")
    }
  }

  internal var keyId: String {
    get {
      return graphQLMap["keyId"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "keyId")
    }
  }

  internal var keyRingId: String {
    get {
      return graphQLMap["keyRingId"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "keyRingId")
    }
  }

  internal var publicKey: String {
    get {
      return graphQLMap["publicKey"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "publicKey")
    }
  }
}

internal struct CheckEmailAddressAvailabilityInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(domains: Optional<[String]?> = nil, localParts: [String]) {
    graphQLMap = ["domains": domains, "localParts": localParts]
  }

  internal var domains: Optional<[String]?> {
    get {
      return graphQLMap["domains"] as! Optional<[String]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "domains")
    }
  }

  internal var localParts: [String] {
    get {
      return graphQLMap["localParts"] as! [String]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "localParts")
    }
  }
}

internal struct ListEmailAddressesInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(filter: Optional<EmailAddressFilterInput?> = nil, limit: Optional<Int?> = nil, nextToken: Optional<String?> = nil) {
    graphQLMap = ["filter": filter, "limit": limit, "nextToken": nextToken]
  }

  internal var filter: Optional<EmailAddressFilterInput?> {
    get {
      return graphQLMap["filter"] as! Optional<EmailAddressFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "filter")
    }
  }

  internal var limit: Optional<Int?> {
    get {
      return graphQLMap["limit"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "limit")
    }
  }

  internal var nextToken: Optional<String?> {
    get {
      return graphQLMap["nextToken"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "nextToken")
    }
  }
}

internal struct EmailAddressFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(and: Optional<[EmailAddressFilterInput?]?> = nil, emailAddress: Optional<StringFilterInput?> = nil, id: Optional<IDFilterInput?> = nil, identityId: Optional<IDFilterInput?> = nil, keyRingId: Optional<IDFilterInput?> = nil, not: Optional<EmailAddressFilterInput?> = nil, or: Optional<[EmailAddressFilterInput?]?> = nil) {
    graphQLMap = ["and": and, "emailAddress": emailAddress, "id": id, "identityId": identityId, "keyRingId": keyRingId, "not": not, "or": or]
  }

  internal var and: Optional<[EmailAddressFilterInput?]?> {
    get {
      return graphQLMap["and"] as! Optional<[EmailAddressFilterInput?]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  internal var emailAddress: Optional<StringFilterInput?> {
    get {
      return graphQLMap["emailAddress"] as! Optional<StringFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddress")
    }
  }

  internal var id: Optional<IDFilterInput?> {
    get {
      return graphQLMap["id"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  internal var identityId: Optional<IDFilterInput?> {
    get {
      return graphQLMap["identityId"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "identityId")
    }
  }

  internal var keyRingId: Optional<IDFilterInput?> {
    get {
      return graphQLMap["keyRingId"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "keyRingId")
    }
  }

  internal var not: Optional<EmailAddressFilterInput?> {
    get {
      return graphQLMap["not"] as! Optional<EmailAddressFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }

  internal var or: Optional<[EmailAddressFilterInput?]?> {
    get {
      return graphQLMap["or"] as! Optional<[EmailAddressFilterInput?]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }
}

internal struct StringFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(beginsWith: Optional<String?> = nil, eq: Optional<String?> = nil, ne: Optional<String?> = nil) {
    graphQLMap = ["beginsWith": beginsWith, "eq": eq, "ne": ne]
  }

  internal var beginsWith: Optional<String?> {
    get {
      return graphQLMap["beginsWith"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }

  internal var eq: Optional<String?> {
    get {
      return graphQLMap["eq"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  internal var ne: Optional<String?> {
    get {
      return graphQLMap["ne"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }
}

internal struct IDFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(beginsWith: Optional<GraphQLID?> = nil, eq: Optional<GraphQLID?> = nil, ne: Optional<GraphQLID?> = nil) {
    graphQLMap = ["beginsWith": beginsWith, "eq": eq, "ne": ne]
  }

  internal var beginsWith: Optional<GraphQLID?> {
    get {
      return graphQLMap["beginsWith"] as! Optional<GraphQLID?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }

  internal var eq: Optional<GraphQLID?> {
    get {
      return graphQLMap["eq"] as! Optional<GraphQLID?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  internal var ne: Optional<GraphQLID?> {
    get {
      return graphQLMap["ne"] as! Optional<GraphQLID?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }
}

internal struct ListEmailAddressesForSudoIdInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(filter: Optional<EmailAddressFilterInput?> = nil, limit: Optional<Int?> = nil, nextToken: Optional<String?> = nil, sudoId: GraphQLID) {
    graphQLMap = ["filter": filter, "limit": limit, "nextToken": nextToken, "sudoId": sudoId]
  }

  internal var filter: Optional<EmailAddressFilterInput?> {
    get {
      return graphQLMap["filter"] as! Optional<EmailAddressFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "filter")
    }
  }

  internal var limit: Optional<Int?> {
    get {
      return graphQLMap["limit"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "limit")
    }
  }

  internal var nextToken: Optional<String?> {
    get {
      return graphQLMap["nextToken"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "nextToken")
    }
  }

  internal var sudoId: GraphQLID {
    get {
      return graphQLMap["sudoId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sudoId")
    }
  }
}

internal struct LookupEmailAddressesPublicInfoInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(emailAddresses: [String]) {
    graphQLMap = ["emailAddresses": emailAddresses]
  }

  internal var emailAddresses: [String] {
    get {
      return graphQLMap["emailAddresses"] as! [String]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddresses")
    }
  }
}

internal struct ListEmailFoldersForEmailAddressIdInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(emailAddressId: GraphQLID, filter: Optional<EmailFolderFilterInput?> = nil, limit: Optional<Int?> = nil, nextToken: Optional<String?> = nil) {
    graphQLMap = ["emailAddressId": emailAddressId, "filter": filter, "limit": limit, "nextToken": nextToken]
  }

  internal var emailAddressId: GraphQLID {
    get {
      return graphQLMap["emailAddressId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddressId")
    }
  }

  internal var filter: Optional<EmailFolderFilterInput?> {
    get {
      return graphQLMap["filter"] as! Optional<EmailFolderFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "filter")
    }
  }

  internal var limit: Optional<Int?> {
    get {
      return graphQLMap["limit"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "limit")
    }
  }

  internal var nextToken: Optional<String?> {
    get {
      return graphQLMap["nextToken"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "nextToken")
    }
  }
}

internal struct EmailFolderFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(and: Optional<[EmailFolderFilterInput?]?> = nil, folderName: Optional<StringFilterInput?> = nil, id: Optional<IDFilterInput?> = nil, not: Optional<EmailFolderFilterInput?> = nil, or: Optional<[EmailFolderFilterInput?]?> = nil, size: Optional<FloatFilterInput?> = nil, unseenCount: Optional<IntFilterInput?> = nil) {
    graphQLMap = ["and": and, "folderName": folderName, "id": id, "not": not, "or": or, "size": size, "unseenCount": unseenCount]
  }

  internal var and: Optional<[EmailFolderFilterInput?]?> {
    get {
      return graphQLMap["and"] as! Optional<[EmailFolderFilterInput?]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  internal var folderName: Optional<StringFilterInput?> {
    get {
      return graphQLMap["folderName"] as! Optional<StringFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "folderName")
    }
  }

  internal var id: Optional<IDFilterInput?> {
    get {
      return graphQLMap["id"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  internal var not: Optional<EmailFolderFilterInput?> {
    get {
      return graphQLMap["not"] as! Optional<EmailFolderFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }

  internal var or: Optional<[EmailFolderFilterInput?]?> {
    get {
      return graphQLMap["or"] as! Optional<[EmailFolderFilterInput?]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  internal var size: Optional<FloatFilterInput?> {
    get {
      return graphQLMap["size"] as! Optional<FloatFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "size")
    }
  }

  internal var unseenCount: Optional<IntFilterInput?> {
    get {
      return graphQLMap["unseenCount"] as! Optional<IntFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "unseenCount")
    }
  }
}

internal struct FloatFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(between: Optional<[Double?]?> = nil, eq: Optional<Double?> = nil, ge: Optional<Double?> = nil, gt: Optional<Double?> = nil, le: Optional<Double?> = nil, lt: Optional<Double?> = nil, ne: Optional<Double?> = nil) {
    graphQLMap = ["between": between, "eq": eq, "ge": ge, "gt": gt, "le": le, "lt": lt, "ne": ne]
  }

  internal var between: Optional<[Double?]?> {
    get {
      return graphQLMap["between"] as! Optional<[Double?]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  internal var eq: Optional<Double?> {
    get {
      return graphQLMap["eq"] as! Optional<Double?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  internal var ge: Optional<Double?> {
    get {
      return graphQLMap["ge"] as! Optional<Double?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  internal var gt: Optional<Double?> {
    get {
      return graphQLMap["gt"] as! Optional<Double?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  internal var le: Optional<Double?> {
    get {
      return graphQLMap["le"] as! Optional<Double?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  internal var lt: Optional<Double?> {
    get {
      return graphQLMap["lt"] as! Optional<Double?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  internal var ne: Optional<Double?> {
    get {
      return graphQLMap["ne"] as! Optional<Double?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }
}

internal struct IntFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(between: Optional<[Int?]?> = nil, eq: Optional<Int?> = nil, ge: Optional<Int?> = nil, gt: Optional<Int?> = nil, le: Optional<Int?> = nil, lt: Optional<Int?> = nil, ne: Optional<Int?> = nil) {
    graphQLMap = ["between": between, "eq": eq, "ge": ge, "gt": gt, "le": le, "lt": lt, "ne": ne]
  }

  internal var between: Optional<[Int?]?> {
    get {
      return graphQLMap["between"] as! Optional<[Int?]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "between")
    }
  }

  internal var eq: Optional<Int?> {
    get {
      return graphQLMap["eq"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  internal var ge: Optional<Int?> {
    get {
      return graphQLMap["ge"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ge")
    }
  }

  internal var gt: Optional<Int?> {
    get {
      return graphQLMap["gt"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "gt")
    }
  }

  internal var le: Optional<Int?> {
    get {
      return graphQLMap["le"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "le")
    }
  }

  internal var lt: Optional<Int?> {
    get {
      return graphQLMap["lt"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "lt")
    }
  }

  internal var ne: Optional<Int?> {
    get {
      return graphQLMap["ne"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }
}

internal struct ListEmailMessagesInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(includeDeletedMessages: Optional<Bool?> = nil, limit: Optional<Int?> = nil, nextToken: Optional<String?> = nil, sortOrder: Optional<SortOrder?> = nil, specifiedDateRange: Optional<EmailMessageDateRangeInput?> = nil) {
    graphQLMap = ["includeDeletedMessages": includeDeletedMessages, "limit": limit, "nextToken": nextToken, "sortOrder": sortOrder, "specifiedDateRange": specifiedDateRange]
  }

  internal var includeDeletedMessages: Optional<Bool?> {
    get {
      return graphQLMap["includeDeletedMessages"] as! Optional<Bool?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "includeDeletedMessages")
    }
  }

  internal var limit: Optional<Int?> {
    get {
      return graphQLMap["limit"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "limit")
    }
  }

  internal var nextToken: Optional<String?> {
    get {
      return graphQLMap["nextToken"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "nextToken")
    }
  }

  internal var sortOrder: Optional<SortOrder?> {
    get {
      return graphQLMap["sortOrder"] as! Optional<SortOrder?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sortOrder")
    }
  }

  internal var specifiedDateRange: Optional<EmailMessageDateRangeInput?> {
    get {
      return graphQLMap["specifiedDateRange"] as! Optional<EmailMessageDateRangeInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "specifiedDateRange")
    }
  }
}

internal enum SortOrder: RawRepresentable, Equatable, JSONDecodable, JSONEncodable {
  internal typealias RawValue = String
  case asc
  case desc
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  internal init?(rawValue: RawValue) {
    switch rawValue {
      case "ASC": self = .asc
      case "DESC": self = .desc
      default: self = .unknown(rawValue)
    }
  }

  internal var rawValue: RawValue {
    switch self {
      case .asc: return "ASC"
      case .desc: return "DESC"
      case .unknown(let value): return value
    }
  }

  internal static func == (lhs: SortOrder, rhs: SortOrder) -> Bool {
    switch (lhs, rhs) {
      case (.asc, .asc): return true
      case (.desc, .desc): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

internal struct EmailMessageDateRangeInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(sortDateEpochMs: Optional<DateRangeInput?> = nil, updatedAtEpochMs: Optional<DateRangeInput?> = nil) {
    graphQLMap = ["sortDateEpochMs": sortDateEpochMs, "updatedAtEpochMs": updatedAtEpochMs]
  }

  internal var sortDateEpochMs: Optional<DateRangeInput?> {
    get {
      return graphQLMap["sortDateEpochMs"] as! Optional<DateRangeInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sortDateEpochMs")
    }
  }

  internal var updatedAtEpochMs: Optional<DateRangeInput?> {
    get {
      return graphQLMap["updatedAtEpochMs"] as! Optional<DateRangeInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "updatedAtEpochMs")
    }
  }
}

internal struct DateRangeInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(endDateEpochMs: Double, startDateEpochMs: Double) {
    graphQLMap = ["endDateEpochMs": endDateEpochMs, "startDateEpochMs": startDateEpochMs]
  }

  internal var endDateEpochMs: Double {
    get {
      return graphQLMap["endDateEpochMs"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "endDateEpochMs")
    }
  }

  internal var startDateEpochMs: Double {
    get {
      return graphQLMap["startDateEpochMs"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "startDateEpochMs")
    }
  }
}

internal struct ListEmailMessagesForEmailAddressIdInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(emailAddressId: GraphQLID, includeDeletedMessages: Optional<Bool?> = nil, limit: Optional<Int?> = nil, nextToken: Optional<String?> = nil, sortOrder: Optional<SortOrder?> = nil, specifiedDateRange: Optional<EmailMessageDateRangeInput?> = nil) {
    graphQLMap = ["emailAddressId": emailAddressId, "includeDeletedMessages": includeDeletedMessages, "limit": limit, "nextToken": nextToken, "sortOrder": sortOrder, "specifiedDateRange": specifiedDateRange]
  }

  internal var emailAddressId: GraphQLID {
    get {
      return graphQLMap["emailAddressId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddressId")
    }
  }

  internal var includeDeletedMessages: Optional<Bool?> {
    get {
      return graphQLMap["includeDeletedMessages"] as! Optional<Bool?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "includeDeletedMessages")
    }
  }

  internal var limit: Optional<Int?> {
    get {
      return graphQLMap["limit"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "limit")
    }
  }

  internal var nextToken: Optional<String?> {
    get {
      return graphQLMap["nextToken"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "nextToken")
    }
  }

  internal var sortOrder: Optional<SortOrder?> {
    get {
      return graphQLMap["sortOrder"] as! Optional<SortOrder?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sortOrder")
    }
  }

  internal var specifiedDateRange: Optional<EmailMessageDateRangeInput?> {
    get {
      return graphQLMap["specifiedDateRange"] as! Optional<EmailMessageDateRangeInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "specifiedDateRange")
    }
  }
}

internal struct ListEmailMessagesForEmailFolderIdInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(filter: Optional<EmailMessageFilterInput?> = nil, folderId: GraphQLID, includeDeletedMessages: Optional<Bool?> = nil, limit: Optional<Int?> = nil, nextToken: Optional<String?> = nil, sortOrder: Optional<SortOrder?> = nil, specifiedDateRange: Optional<EmailMessageDateRangeInput?> = nil) {
    graphQLMap = ["filter": filter, "folderId": folderId, "includeDeletedMessages": includeDeletedMessages, "limit": limit, "nextToken": nextToken, "sortOrder": sortOrder, "specifiedDateRange": specifiedDateRange]
  }

  internal var filter: Optional<EmailMessageFilterInput?> {
    get {
      return graphQLMap["filter"] as! Optional<EmailMessageFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "filter")
    }
  }

  internal var folderId: GraphQLID {
    get {
      return graphQLMap["folderId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "folderId")
    }
  }

  internal var includeDeletedMessages: Optional<Bool?> {
    get {
      return graphQLMap["includeDeletedMessages"] as! Optional<Bool?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "includeDeletedMessages")
    }
  }

  internal var limit: Optional<Int?> {
    get {
      return graphQLMap["limit"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "limit")
    }
  }

  internal var nextToken: Optional<String?> {
    get {
      return graphQLMap["nextToken"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "nextToken")
    }
  }

  internal var sortOrder: Optional<SortOrder?> {
    get {
      return graphQLMap["sortOrder"] as! Optional<SortOrder?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sortOrder")
    }
  }

  internal var specifiedDateRange: Optional<EmailMessageDateRangeInput?> {
    get {
      return graphQLMap["specifiedDateRange"] as! Optional<EmailMessageDateRangeInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "specifiedDateRange")
    }
  }
}

internal struct EmailMessageFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(algorithm: Optional<StringFilterInput?> = nil, and: Optional<[EmailMessageFilterInput?]?> = nil, clientRefId: Optional<IDFilterInput?> = nil, direction: Optional<EmailMessageDirectionFilterInput?> = nil, folderId: Optional<IDFilterInput?> = nil, forwarded: Optional<BooleanFilterInput?> = nil, id: Optional<IDFilterInput?> = nil, keyId: Optional<IDFilterInput?> = nil, messageId: Optional<IDFilterInput?> = nil, not: Optional<EmailMessageFilterInput?> = nil, or: Optional<[EmailMessageFilterInput?]?> = nil, repliedTo: Optional<BooleanFilterInput?> = nil, seen: Optional<BooleanFilterInput?> = nil, state: Optional<EmailMessageStateFilterInput?> = nil) {
    graphQLMap = ["algorithm": algorithm, "and": and, "clientRefId": clientRefId, "direction": direction, "folderId": folderId, "forwarded": forwarded, "id": id, "keyId": keyId, "messageId": messageId, "not": not, "or": or, "repliedTo": repliedTo, "seen": seen, "state": state]
  }

  internal var algorithm: Optional<StringFilterInput?> {
    get {
      return graphQLMap["algorithm"] as! Optional<StringFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "algorithm")
    }
  }

  internal var and: Optional<[EmailMessageFilterInput?]?> {
    get {
      return graphQLMap["and"] as! Optional<[EmailMessageFilterInput?]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
    }
  }

  internal var clientRefId: Optional<IDFilterInput?> {
    get {
      return graphQLMap["clientRefId"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "clientRefId")
    }
  }

  internal var direction: Optional<EmailMessageDirectionFilterInput?> {
    get {
      return graphQLMap["direction"] as! Optional<EmailMessageDirectionFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "direction")
    }
  }

  internal var folderId: Optional<IDFilterInput?> {
    get {
      return graphQLMap["folderId"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "folderId")
    }
  }

  internal var forwarded: Optional<BooleanFilterInput?> {
    get {
      return graphQLMap["forwarded"] as! Optional<BooleanFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "forwarded")
    }
  }

  internal var id: Optional<IDFilterInput?> {
    get {
      return graphQLMap["id"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  internal var keyId: Optional<IDFilterInput?> {
    get {
      return graphQLMap["keyId"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "keyId")
    }
  }

  internal var messageId: Optional<IDFilterInput?> {
    get {
      return graphQLMap["messageId"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "messageId")
    }
  }

  internal var not: Optional<EmailMessageFilterInput?> {
    get {
      return graphQLMap["not"] as! Optional<EmailMessageFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }

  internal var or: Optional<[EmailMessageFilterInput?]?> {
    get {
      return graphQLMap["or"] as! Optional<[EmailMessageFilterInput?]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "or")
    }
  }

  internal var repliedTo: Optional<BooleanFilterInput?> {
    get {
      return graphQLMap["repliedTo"] as! Optional<BooleanFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "repliedTo")
    }
  }

  internal var seen: Optional<BooleanFilterInput?> {
    get {
      return graphQLMap["seen"] as! Optional<BooleanFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "seen")
    }
  }

  internal var state: Optional<EmailMessageStateFilterInput?> {
    get {
      return graphQLMap["state"] as! Optional<EmailMessageStateFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "state")
    }
  }
}

internal struct EmailMessageDirectionFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(eq: Optional<EmailMessageDirection?> = nil, ne: Optional<EmailMessageDirection?> = nil) {
    graphQLMap = ["eq": eq, "ne": ne]
  }

  internal var eq: Optional<EmailMessageDirection?> {
    get {
      return graphQLMap["eq"] as! Optional<EmailMessageDirection?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  internal var ne: Optional<EmailMessageDirection?> {
    get {
      return graphQLMap["ne"] as! Optional<EmailMessageDirection?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }
}

internal struct BooleanFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(eq: Optional<Bool?> = nil, ne: Optional<Bool?> = nil) {
    graphQLMap = ["eq": eq, "ne": ne]
  }

  internal var eq: Optional<Bool?> {
    get {
      return graphQLMap["eq"] as! Optional<Bool?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  internal var ne: Optional<Bool?> {
    get {
      return graphQLMap["ne"] as! Optional<Bool?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }
}

internal struct EmailMessageStateFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(eq: Optional<EmailMessageState?> = nil, `in`: Optional<[EmailMessageState?]?> = nil, ne: Optional<EmailMessageState?> = nil, notIn: Optional<[EmailMessageState?]?> = nil) {
    graphQLMap = ["eq": eq, "in": `in`, "ne": ne, "notIn": notIn]
  }

  internal var eq: Optional<EmailMessageState?> {
    get {
      return graphQLMap["eq"] as! Optional<EmailMessageState?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }

  internal var `in`: Optional<[EmailMessageState?]?> {
    get {
      return graphQLMap["in"] as! Optional<[EmailMessageState?]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "in")
    }
  }

  internal var ne: Optional<EmailMessageState?> {
    get {
      return graphQLMap["ne"] as! Optional<EmailMessageState?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  internal var notIn: Optional<[EmailMessageState?]?> {
    get {
      return graphQLMap["notIn"] as! Optional<[EmailMessageState?]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notIn")
    }
  }
}

internal struct GetEmailAddressBlocklistInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(owner: GraphQLID) {
    graphQLMap = ["owner": owner]
  }

  internal var owner: GraphQLID {
    get {
      return graphQLMap["owner"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "owner")
    }
  }
}

internal final class DeleteEmailMessagesMutation: GraphQLMutation {
  internal static let operationString =
    "mutation DeleteEmailMessages($input: DeleteEmailMessagesInput!) {\n  deleteEmailMessages(input: $input)\n}"

  internal var input: DeleteEmailMessagesInput

  internal init(input: DeleteEmailMessagesInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("deleteEmailMessages", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.list(.nonNull(.scalar(GraphQLID.self))))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(deleteEmailMessages: [GraphQLID]) {
      self.init(snapshot: ["__typename": "Mutation", "deleteEmailMessages": deleteEmailMessages])
    }

    internal var deleteEmailMessages: [GraphQLID] {
      get {
        return snapshot["deleteEmailMessages"]! as! [GraphQLID]
      }
      set {
        snapshot.updateValue(newValue, forKey: "deleteEmailMessages")
      }
    }
  }
}

internal final class ProvisionEmailAddressMutation: GraphQLMutation {
  internal static let operationString =
    "mutation ProvisionEmailAddress($input: ProvisionEmailAddressInput!) {\n  provisionEmailAddress(input: $input) {\n    __typename\n    ...EmailAddress\n  }\n}"

  internal static var requestString: String { return operationString.appending(EmailAddress.fragmentString).appending(EmailAddressWithoutFolders.fragmentString).appending(SealedAttribute.fragmentString).appending(EmailFolder.fragmentString) }

  internal var input: ProvisionEmailAddressInput

  internal init(input: ProvisionEmailAddressInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("provisionEmailAddress", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(ProvisionEmailAddress.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(provisionEmailAddress: ProvisionEmailAddress) {
      self.init(snapshot: ["__typename": "Mutation", "provisionEmailAddress": provisionEmailAddress.snapshot])
    }

    internal var provisionEmailAddress: ProvisionEmailAddress {
      get {
        return ProvisionEmailAddress(snapshot: snapshot["provisionEmailAddress"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "provisionEmailAddress")
      }
    }

    internal struct ProvisionEmailAddress: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailAddress"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("identityId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyIds", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("lastReceivedAtEpochMs", type: .scalar(Double.self)),
        GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
        GraphQLField("size", type: .nonNull(.scalar(Double.self))),
        GraphQLField("numberOfEmailMessages", type: .nonNull(.scalar(Int.self))),
        GraphQLField("alias", type: .object(Alias.selections)),
        GraphQLField("folders", type: .nonNull(.list(.nonNull(.object(Folder.selections))))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], identityId: GraphQLID, keyRingId: GraphQLID, keyIds: [String], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, lastReceivedAtEpochMs: Double? = nil, emailAddress: String, size: Double, numberOfEmailMessages: Int, alias: Alias? = nil, folders: [Folder]) {
        self.init(snapshot: ["__typename": "EmailAddress", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "identityId": identityId, "keyRingId": keyRingId, "keyIds": keyIds, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "lastReceivedAtEpochMs": lastReceivedAtEpochMs, "emailAddress": emailAddress, "size": size, "numberOfEmailMessages": numberOfEmailMessages, "alias": alias.flatMap { $0.snapshot }, "folders": folders.map { $0.snapshot }])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      internal var identityId: GraphQLID {
        get {
          return snapshot["identityId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "identityId")
        }
      }

      internal var keyRingId: GraphQLID {
        get {
          return snapshot["keyRingId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyRingId")
        }
      }

      internal var keyIds: [String] {
        get {
          return snapshot["keyIds"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyIds")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var lastReceivedAtEpochMs: Double? {
        get {
          return snapshot["lastReceivedAtEpochMs"] as? Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "lastReceivedAtEpochMs")
        }
      }

      internal var emailAddress: String {
        get {
          return snapshot["emailAddress"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddress")
        }
      }

      internal var size: Double {
        get {
          return snapshot["size"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "size")
        }
      }

      internal var numberOfEmailMessages: Int {
        get {
          return snapshot["numberOfEmailMessages"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "numberOfEmailMessages")
        }
      }

      internal var alias: Alias? {
        get {
          return (snapshot["alias"] as? Snapshot).flatMap { Alias(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "alias")
        }
      }

      internal var folders: [Folder] {
        get {
          return (snapshot["folders"] as! [Snapshot]).map { Folder(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "folders")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var emailAddress: EmailAddress {
          get {
            return EmailAddress(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal var emailAddressWithoutFolders: EmailAddressWithoutFolders {
          get {
            return EmailAddressWithoutFolders(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Owner: GraphQLSelectionSet {
        internal static let possibleTypes = ["Owner"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: String, issuer: String) {
          self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var issuer: String {
          get {
            return snapshot["issuer"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "issuer")
          }
        }
      }

      internal struct Alias: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedAttribute"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
          GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
          self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var plainTextType: String {
          get {
            return snapshot["plainTextType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "plainTextType")
          }
        }

        internal var base64EncodedSealedData: String {
          get {
            return snapshot["base64EncodedSealedData"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var sealedAttribute: SealedAttribute {
            get {
              return SealedAttribute(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }

      internal struct Folder: GraphQLSelectionSet {
        internal static let possibleTypes = ["EmailFolder"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("folderName", type: .nonNull(.scalar(String.self))),
          GraphQLField("size", type: .nonNull(.scalar(Double.self))),
          GraphQLField("unseenCount", type: .nonNull(.scalar(Double.self))),
          GraphQLField("ttl", type: .scalar(Double.self)),
          GraphQLField("customFolderName", type: .object(CustomFolderName.selections)),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddressId: GraphQLID, folderName: String, size: Double, unseenCount: Double, ttl: Double? = nil, customFolderName: CustomFolderName? = nil) {
          self.init(snapshot: ["__typename": "EmailFolder", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddressId": emailAddressId, "folderName": folderName, "size": size, "unseenCount": unseenCount, "ttl": ttl, "customFolderName": customFolderName.flatMap { $0.snapshot }])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var owner: GraphQLID {
          get {
            return snapshot["owner"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "owner")
          }
        }

        internal var owners: [Owner] {
          get {
            return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
          }
        }

        internal var version: Int {
          get {
            return snapshot["version"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "version")
          }
        }

        internal var createdAtEpochMs: Double {
          get {
            return snapshot["createdAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
          }
        }

        internal var updatedAtEpochMs: Double {
          get {
            return snapshot["updatedAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
          }
        }

        internal var emailAddressId: GraphQLID {
          get {
            return snapshot["emailAddressId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "emailAddressId")
          }
        }

        internal var folderName: String {
          get {
            return snapshot["folderName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "folderName")
          }
        }

        internal var size: Double {
          get {
            return snapshot["size"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "size")
          }
        }

        internal var unseenCount: Double {
          get {
            return snapshot["unseenCount"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "unseenCount")
          }
        }

        internal var ttl: Double? {
          get {
            return snapshot["ttl"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "ttl")
          }
        }

        internal var customFolderName: CustomFolderName? {
          get {
            return (snapshot["customFolderName"] as? Snapshot).flatMap { CustomFolderName(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "customFolderName")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var emailFolder: EmailFolder {
            get {
              return EmailFolder(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }

        internal struct Owner: GraphQLSelectionSet {
          internal static let possibleTypes = ["Owner"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(id: String, issuer: String) {
            self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var id: String {
            get {
              return snapshot["id"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          internal var issuer: String {
            get {
              return snapshot["issuer"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "issuer")
            }
          }
        }

        internal struct CustomFolderName: GraphQLSelectionSet {
          internal static let possibleTypes = ["SealedAttribute"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
            GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
            GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
            GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
            self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var algorithm: String {
            get {
              return snapshot["algorithm"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "algorithm")
            }
          }

          internal var keyId: String {
            get {
              return snapshot["keyId"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "keyId")
            }
          }

          internal var plainTextType: String {
            get {
              return snapshot["plainTextType"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "plainTextType")
            }
          }

          internal var base64EncodedSealedData: String {
            get {
              return snapshot["base64EncodedSealedData"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
            }
          }

          internal var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          internal struct Fragments {
            internal var snapshot: Snapshot

            internal var sealedAttribute: SealedAttribute {
              get {
                return SealedAttribute(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }
          }
        }
      }
    }
  }
}

internal final class DeprovisionEmailAddressMutation: GraphQLMutation {
  internal static let operationString =
    "mutation DeprovisionEmailAddress($input: DeprovisionEmailAddressInput!) {\n  deprovisionEmailAddress(input: $input) {\n    __typename\n    ...EmailAddressWithoutFolders\n  }\n}"

  internal static var requestString: String { return operationString.appending(EmailAddressWithoutFolders.fragmentString).appending(SealedAttribute.fragmentString) }

  internal var input: DeprovisionEmailAddressInput

  internal init(input: DeprovisionEmailAddressInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("deprovisionEmailAddress", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(DeprovisionEmailAddress.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(deprovisionEmailAddress: DeprovisionEmailAddress) {
      self.init(snapshot: ["__typename": "Mutation", "deprovisionEmailAddress": deprovisionEmailAddress.snapshot])
    }

    internal var deprovisionEmailAddress: DeprovisionEmailAddress {
      get {
        return DeprovisionEmailAddress(snapshot: snapshot["deprovisionEmailAddress"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "deprovisionEmailAddress")
      }
    }

    internal struct DeprovisionEmailAddress: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailAddress"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("identityId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyIds", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("lastReceivedAtEpochMs", type: .scalar(Double.self)),
        GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
        GraphQLField("size", type: .nonNull(.scalar(Double.self))),
        GraphQLField("numberOfEmailMessages", type: .nonNull(.scalar(Int.self))),
        GraphQLField("alias", type: .object(Alias.selections)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], identityId: GraphQLID, keyRingId: GraphQLID, keyIds: [String], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, lastReceivedAtEpochMs: Double? = nil, emailAddress: String, size: Double, numberOfEmailMessages: Int, alias: Alias? = nil) {
        self.init(snapshot: ["__typename": "EmailAddress", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "identityId": identityId, "keyRingId": keyRingId, "keyIds": keyIds, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "lastReceivedAtEpochMs": lastReceivedAtEpochMs, "emailAddress": emailAddress, "size": size, "numberOfEmailMessages": numberOfEmailMessages, "alias": alias.flatMap { $0.snapshot }])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      internal var identityId: GraphQLID {
        get {
          return snapshot["identityId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "identityId")
        }
      }

      internal var keyRingId: GraphQLID {
        get {
          return snapshot["keyRingId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyRingId")
        }
      }

      internal var keyIds: [String] {
        get {
          return snapshot["keyIds"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyIds")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var lastReceivedAtEpochMs: Double? {
        get {
          return snapshot["lastReceivedAtEpochMs"] as? Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "lastReceivedAtEpochMs")
        }
      }

      internal var emailAddress: String {
        get {
          return snapshot["emailAddress"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddress")
        }
      }

      internal var size: Double {
        get {
          return snapshot["size"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "size")
        }
      }

      internal var numberOfEmailMessages: Int {
        get {
          return snapshot["numberOfEmailMessages"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "numberOfEmailMessages")
        }
      }

      internal var alias: Alias? {
        get {
          return (snapshot["alias"] as? Snapshot).flatMap { Alias(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "alias")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var emailAddressWithoutFolders: EmailAddressWithoutFolders {
          get {
            return EmailAddressWithoutFolders(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Owner: GraphQLSelectionSet {
        internal static let possibleTypes = ["Owner"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: String, issuer: String) {
          self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var issuer: String {
          get {
            return snapshot["issuer"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "issuer")
          }
        }
      }

      internal struct Alias: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedAttribute"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
          GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
          self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var plainTextType: String {
          get {
            return snapshot["plainTextType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "plainTextType")
          }
        }

        internal var base64EncodedSealedData: String {
          get {
            return snapshot["base64EncodedSealedData"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var sealedAttribute: SealedAttribute {
            get {
              return SealedAttribute(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }
    }
  }
}

internal final class UpdateEmailAddressMetadataMutation: GraphQLMutation {
  internal static let operationString =
    "mutation UpdateEmailAddressMetadata($input: UpdateEmailAddressMetadataInput!) {\n  updateEmailAddressMetadata(input: $input)\n}"

  internal var input: UpdateEmailAddressMetadataInput

  internal init(input: UpdateEmailAddressMetadataInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("updateEmailAddressMetadata", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.scalar(GraphQLID.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(updateEmailAddressMetadata: GraphQLID) {
      self.init(snapshot: ["__typename": "Mutation", "updateEmailAddressMetadata": updateEmailAddressMetadata])
    }

    internal var updateEmailAddressMetadata: GraphQLID {
      get {
        return snapshot["updateEmailAddressMetadata"]! as! GraphQLID
      }
      set {
        snapshot.updateValue(newValue, forKey: "updateEmailAddressMetadata")
      }
    }
  }
}

internal final class SendEmailMessageMutation: GraphQLMutation {
  internal static let operationString =
    "mutation SendEmailMessage($input: SendEmailMessageInput!) {\n  sendEmailMessageV2(input: $input) {\n    __typename\n    ...SendEmailMessageResult\n  }\n}"

  internal static var requestString: String { return operationString.appending(SendEmailMessageResult.fragmentString) }

  internal var input: SendEmailMessageInput

  internal init(input: SendEmailMessageInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("sendEmailMessageV2", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(SendEmailMessageV2.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(sendEmailMessageV2: SendEmailMessageV2) {
      self.init(snapshot: ["__typename": "Mutation", "sendEmailMessageV2": sendEmailMessageV2.snapshot])
    }

    internal var sendEmailMessageV2: SendEmailMessageV2 {
      get {
        return SendEmailMessageV2(snapshot: snapshot["sendEmailMessageV2"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "sendEmailMessageV2")
      }
    }

    internal struct SendEmailMessageV2: GraphQLSelectionSet {
      internal static let possibleTypes = ["SendEmailMessageResult"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, createdAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "SendEmailMessageResult", "id": id, "createdAtEpochMs": createdAtEpochMs])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var sendEmailMessageResult: SendEmailMessageResult {
          get {
            return SendEmailMessageResult(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal final class SendEncryptedEmailMessageMutation: GraphQLMutation {
  internal static let operationString =
    "mutation SendEncryptedEmailMessage($input: SendEncryptedEmailMessageInput!) {\n  sendEncryptedEmailMessage(input: $input) {\n    __typename\n    ...SendEmailMessageResult\n  }\n}"

  internal static var requestString: String { return operationString.appending(SendEmailMessageResult.fragmentString) }

  internal var input: SendEncryptedEmailMessageInput

  internal init(input: SendEncryptedEmailMessageInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("sendEncryptedEmailMessage", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(SendEncryptedEmailMessage.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(sendEncryptedEmailMessage: SendEncryptedEmailMessage) {
      self.init(snapshot: ["__typename": "Mutation", "sendEncryptedEmailMessage": sendEncryptedEmailMessage.snapshot])
    }

    internal var sendEncryptedEmailMessage: SendEncryptedEmailMessage {
      get {
        return SendEncryptedEmailMessage(snapshot: snapshot["sendEncryptedEmailMessage"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "sendEncryptedEmailMessage")
      }
    }

    internal struct SendEncryptedEmailMessage: GraphQLSelectionSet {
      internal static let possibleTypes = ["SendEmailMessageResult"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, createdAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "SendEmailMessageResult", "id": id, "createdAtEpochMs": createdAtEpochMs])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var sendEmailMessageResult: SendEmailMessageResult {
          get {
            return SendEmailMessageResult(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal final class UpdateEmailMessagesMutation: GraphQLMutation {
  internal static let operationString =
    "mutation UpdateEmailMessages($input: UpdateEmailMessagesInput!) {\n  updateEmailMessagesV2(input: $input) {\n    __typename\n    ...UpdateEmailMessagesResult\n  }\n}"

  internal static var requestString: String { return operationString.appending(UpdateEmailMessagesResult.fragmentString) }

  internal var input: UpdateEmailMessagesInput

  internal init(input: UpdateEmailMessagesInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("updateEmailMessagesV2", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(UpdateEmailMessagesV2.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(updateEmailMessagesV2: UpdateEmailMessagesV2) {
      self.init(snapshot: ["__typename": "Mutation", "updateEmailMessagesV2": updateEmailMessagesV2.snapshot])
    }

    internal var updateEmailMessagesV2: UpdateEmailMessagesV2 {
      get {
        return UpdateEmailMessagesV2(snapshot: snapshot["updateEmailMessagesV2"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "updateEmailMessagesV2")
      }
    }

    internal struct UpdateEmailMessagesV2: GraphQLSelectionSet {
      internal static let possibleTypes = ["UpdateEmailMessagesV2Result"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(UpdateEmailMessagesStatus.self))),
        GraphQLField("failedMessages", type: .list(.nonNull(.object(FailedMessage.selections)))),
        GraphQLField("successMessages", type: .list(.nonNull(.object(SuccessMessage.selections)))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(status: UpdateEmailMessagesStatus, failedMessages: [FailedMessage]? = nil, successMessages: [SuccessMessage]? = nil) {
        self.init(snapshot: ["__typename": "UpdateEmailMessagesV2Result", "status": status, "failedMessages": failedMessages.flatMap { $0.map { $0.snapshot } }, "successMessages": successMessages.flatMap { $0.map { $0.snapshot } }])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var status: UpdateEmailMessagesStatus {
        get {
          return snapshot["status"]! as! UpdateEmailMessagesStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "status")
        }
      }

      internal var failedMessages: [FailedMessage]? {
        get {
          return (snapshot["failedMessages"] as? [Snapshot]).flatMap { $0.map { FailedMessage(snapshot: $0) } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.snapshot } }, forKey: "failedMessages")
        }
      }

      internal var successMessages: [SuccessMessage]? {
        get {
          return (snapshot["successMessages"] as? [Snapshot]).flatMap { $0.map { SuccessMessage(snapshot: $0) } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.snapshot } }, forKey: "successMessages")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var updateEmailMessagesResult: UpdateEmailMessagesResult {
          get {
            return UpdateEmailMessagesResult(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct FailedMessage: GraphQLSelectionSet {
        internal static let possibleTypes = ["UpdatedEmailMessageFailure"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("errorType", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, errorType: String) {
          self.init(snapshot: ["__typename": "UpdatedEmailMessageFailure", "id": id, "errorType": errorType])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var errorType: String {
          get {
            return snapshot["errorType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "errorType")
          }
        }
      }

      internal struct SuccessMessage: GraphQLSelectionSet {
        internal static let possibleTypes = ["UpdatedEmailMessageSuccess"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
          self.init(snapshot: ["__typename": "UpdatedEmailMessageSuccess", "id": id, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var createdAtEpochMs: Double {
          get {
            return snapshot["createdAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
          }
        }

        internal var updatedAtEpochMs: Double {
          get {
            return snapshot["updatedAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
          }
        }
      }
    }
  }
}

internal final class BlockEmailAddressesMutation: GraphQLMutation {
  internal static let operationString =
    "mutation BlockEmailAddresses($input: BlockEmailAddressesInput!) {\n  blockEmailAddresses(input: $input) {\n    __typename\n    ...BlockAddressesResult\n  }\n}"

  internal static var requestString: String { return operationString.appending(BlockAddressesResult.fragmentString) }

  internal var input: BlockEmailAddressesInput

  internal init(input: BlockEmailAddressesInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("blockEmailAddresses", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(BlockEmailAddress.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(blockEmailAddresses: BlockEmailAddress) {
      self.init(snapshot: ["__typename": "Mutation", "blockEmailAddresses": blockEmailAddresses.snapshot])
    }

    internal var blockEmailAddresses: BlockEmailAddress {
      get {
        return BlockEmailAddress(snapshot: snapshot["blockEmailAddresses"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "blockEmailAddresses")
      }
    }

    internal struct BlockEmailAddress: GraphQLSelectionSet {
      internal static let possibleTypes = ["BlockEmailAddressesBulkUpdateResult"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(UpdateBlockedAddressesStatus.self))),
        GraphQLField("failedAddresses", type: .list(.nonNull(.scalar(String.self)))),
        GraphQLField("successAddresses", type: .list(.nonNull(.scalar(String.self)))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(status: UpdateBlockedAddressesStatus, failedAddresses: [String]? = nil, successAddresses: [String]? = nil) {
        self.init(snapshot: ["__typename": "BlockEmailAddressesBulkUpdateResult", "status": status, "failedAddresses": failedAddresses, "successAddresses": successAddresses])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var status: UpdateBlockedAddressesStatus {
        get {
          return snapshot["status"]! as! UpdateBlockedAddressesStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "status")
        }
      }

      internal var failedAddresses: [String]? {
        get {
          return snapshot["failedAddresses"] as? [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "failedAddresses")
        }
      }

      internal var successAddresses: [String]? {
        get {
          return snapshot["successAddresses"] as? [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "successAddresses")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var blockAddressesResult: BlockAddressesResult {
          get {
            return BlockAddressesResult(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal final class UnblockEmailAddressesMutation: GraphQLMutation {
  internal static let operationString =
    "mutation UnblockEmailAddresses($input: UnblockEmailAddressesInput!) {\n  unblockEmailAddresses(input: $input) {\n    __typename\n    ...BlockAddressesResult\n  }\n}"

  internal static var requestString: String { return operationString.appending(BlockAddressesResult.fragmentString) }

  internal var input: UnblockEmailAddressesInput

  internal init(input: UnblockEmailAddressesInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("unblockEmailAddresses", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(UnblockEmailAddress.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(unblockEmailAddresses: UnblockEmailAddress) {
      self.init(snapshot: ["__typename": "Mutation", "unblockEmailAddresses": unblockEmailAddresses.snapshot])
    }

    internal var unblockEmailAddresses: UnblockEmailAddress {
      get {
        return UnblockEmailAddress(snapshot: snapshot["unblockEmailAddresses"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "unblockEmailAddresses")
      }
    }

    internal struct UnblockEmailAddress: GraphQLSelectionSet {
      internal static let possibleTypes = ["BlockEmailAddressesBulkUpdateResult"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("status", type: .nonNull(.scalar(UpdateBlockedAddressesStatus.self))),
        GraphQLField("failedAddresses", type: .list(.nonNull(.scalar(String.self)))),
        GraphQLField("successAddresses", type: .list(.nonNull(.scalar(String.self)))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(status: UpdateBlockedAddressesStatus, failedAddresses: [String]? = nil, successAddresses: [String]? = nil) {
        self.init(snapshot: ["__typename": "BlockEmailAddressesBulkUpdateResult", "status": status, "failedAddresses": failedAddresses, "successAddresses": successAddresses])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var status: UpdateBlockedAddressesStatus {
        get {
          return snapshot["status"]! as! UpdateBlockedAddressesStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "status")
        }
      }

      internal var failedAddresses: [String]? {
        get {
          return snapshot["failedAddresses"] as? [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "failedAddresses")
        }
      }

      internal var successAddresses: [String]? {
        get {
          return snapshot["successAddresses"] as? [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "successAddresses")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var blockAddressesResult: BlockAddressesResult {
          get {
            return BlockAddressesResult(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal final class CreateCustomEmailFolderMutation: GraphQLMutation {
  internal static let operationString =
    "mutation CreateCustomEmailFolder($input: CreateCustomEmailFolderInput!) {\n  createCustomEmailFolder(input: $input) {\n    __typename\n    ...EmailFolder\n  }\n}"

  internal static var requestString: String { return operationString.appending(EmailFolder.fragmentString).appending(SealedAttribute.fragmentString) }

  internal var input: CreateCustomEmailFolderInput

  internal init(input: CreateCustomEmailFolderInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("createCustomEmailFolder", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(CreateCustomEmailFolder.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(createCustomEmailFolder: CreateCustomEmailFolder) {
      self.init(snapshot: ["__typename": "Mutation", "createCustomEmailFolder": createCustomEmailFolder.snapshot])
    }

    internal var createCustomEmailFolder: CreateCustomEmailFolder {
      get {
        return CreateCustomEmailFolder(snapshot: snapshot["createCustomEmailFolder"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "createCustomEmailFolder")
      }
    }

    internal struct CreateCustomEmailFolder: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailFolder"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("folderName", type: .nonNull(.scalar(String.self))),
        GraphQLField("size", type: .nonNull(.scalar(Double.self))),
        GraphQLField("unseenCount", type: .nonNull(.scalar(Double.self))),
        GraphQLField("ttl", type: .scalar(Double.self)),
        GraphQLField("customFolderName", type: .object(CustomFolderName.selections)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddressId: GraphQLID, folderName: String, size: Double, unseenCount: Double, ttl: Double? = nil, customFolderName: CustomFolderName? = nil) {
        self.init(snapshot: ["__typename": "EmailFolder", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddressId": emailAddressId, "folderName": folderName, "size": size, "unseenCount": unseenCount, "ttl": ttl, "customFolderName": customFolderName.flatMap { $0.snapshot }])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var emailAddressId: GraphQLID {
        get {
          return snapshot["emailAddressId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddressId")
        }
      }

      internal var folderName: String {
        get {
          return snapshot["folderName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "folderName")
        }
      }

      internal var size: Double {
        get {
          return snapshot["size"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "size")
        }
      }

      internal var unseenCount: Double {
        get {
          return snapshot["unseenCount"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "unseenCount")
        }
      }

      internal var ttl: Double? {
        get {
          return snapshot["ttl"] as? Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "ttl")
        }
      }

      internal var customFolderName: CustomFolderName? {
        get {
          return (snapshot["customFolderName"] as? Snapshot).flatMap { CustomFolderName(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "customFolderName")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var emailFolder: EmailFolder {
          get {
            return EmailFolder(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Owner: GraphQLSelectionSet {
        internal static let possibleTypes = ["Owner"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: String, issuer: String) {
          self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var issuer: String {
          get {
            return snapshot["issuer"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "issuer")
          }
        }
      }

      internal struct CustomFolderName: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedAttribute"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
          GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
          self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var plainTextType: String {
          get {
            return snapshot["plainTextType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "plainTextType")
          }
        }

        internal var base64EncodedSealedData: String {
          get {
            return snapshot["base64EncodedSealedData"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var sealedAttribute: SealedAttribute {
            get {
              return SealedAttribute(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }
    }
  }
}

internal final class DeleteCustomEmailFolderMutation: GraphQLMutation {
  internal static let operationString =
    "mutation DeleteCustomEmailFolder($input: DeleteCustomEmailFolderInput!) {\n  deleteCustomEmailFolder(input: $input) {\n    __typename\n    ...EmailFolder\n  }\n}"

  internal static var requestString: String { return operationString.appending(EmailFolder.fragmentString).appending(SealedAttribute.fragmentString) }

  internal var input: DeleteCustomEmailFolderInput

  internal init(input: DeleteCustomEmailFolderInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("deleteCustomEmailFolder", arguments: ["input": GraphQLVariable("input")], type: .object(DeleteCustomEmailFolder.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(deleteCustomEmailFolder: DeleteCustomEmailFolder? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "deleteCustomEmailFolder": deleteCustomEmailFolder.flatMap { $0.snapshot }])
    }

    internal var deleteCustomEmailFolder: DeleteCustomEmailFolder? {
      get {
        return (snapshot["deleteCustomEmailFolder"] as? Snapshot).flatMap { DeleteCustomEmailFolder(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "deleteCustomEmailFolder")
      }
    }

    internal struct DeleteCustomEmailFolder: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailFolder"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("folderName", type: .nonNull(.scalar(String.self))),
        GraphQLField("size", type: .nonNull(.scalar(Double.self))),
        GraphQLField("unseenCount", type: .nonNull(.scalar(Double.self))),
        GraphQLField("ttl", type: .scalar(Double.self)),
        GraphQLField("customFolderName", type: .object(CustomFolderName.selections)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddressId: GraphQLID, folderName: String, size: Double, unseenCount: Double, ttl: Double? = nil, customFolderName: CustomFolderName? = nil) {
        self.init(snapshot: ["__typename": "EmailFolder", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddressId": emailAddressId, "folderName": folderName, "size": size, "unseenCount": unseenCount, "ttl": ttl, "customFolderName": customFolderName.flatMap { $0.snapshot }])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var emailAddressId: GraphQLID {
        get {
          return snapshot["emailAddressId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddressId")
        }
      }

      internal var folderName: String {
        get {
          return snapshot["folderName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "folderName")
        }
      }

      internal var size: Double {
        get {
          return snapshot["size"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "size")
        }
      }

      internal var unseenCount: Double {
        get {
          return snapshot["unseenCount"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "unseenCount")
        }
      }

      internal var ttl: Double? {
        get {
          return snapshot["ttl"] as? Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "ttl")
        }
      }

      internal var customFolderName: CustomFolderName? {
        get {
          return (snapshot["customFolderName"] as? Snapshot).flatMap { CustomFolderName(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "customFolderName")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var emailFolder: EmailFolder {
          get {
            return EmailFolder(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Owner: GraphQLSelectionSet {
        internal static let possibleTypes = ["Owner"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: String, issuer: String) {
          self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var issuer: String {
          get {
            return snapshot["issuer"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "issuer")
          }
        }
      }

      internal struct CustomFolderName: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedAttribute"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
          GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
          self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var plainTextType: String {
          get {
            return snapshot["plainTextType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "plainTextType")
          }
        }

        internal var base64EncodedSealedData: String {
          get {
            return snapshot["base64EncodedSealedData"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var sealedAttribute: SealedAttribute {
            get {
              return SealedAttribute(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }
    }
  }
}

internal final class UpdateCustomEmailFolderMutation: GraphQLMutation {
  internal static let operationString =
    "mutation UpdateCustomEmailFolder($input: UpdateCustomEmailFolderInput!) {\n  updateCustomEmailFolder(input: $input) {\n    __typename\n    ...EmailFolder\n  }\n}"

  internal static var requestString: String { return operationString.appending(EmailFolder.fragmentString).appending(SealedAttribute.fragmentString) }

  internal var input: UpdateCustomEmailFolderInput

  internal init(input: UpdateCustomEmailFolderInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("updateCustomEmailFolder", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(UpdateCustomEmailFolder.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(updateCustomEmailFolder: UpdateCustomEmailFolder) {
      self.init(snapshot: ["__typename": "Mutation", "updateCustomEmailFolder": updateCustomEmailFolder.snapshot])
    }

    internal var updateCustomEmailFolder: UpdateCustomEmailFolder {
      get {
        return UpdateCustomEmailFolder(snapshot: snapshot["updateCustomEmailFolder"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "updateCustomEmailFolder")
      }
    }

    internal struct UpdateCustomEmailFolder: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailFolder"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("folderName", type: .nonNull(.scalar(String.self))),
        GraphQLField("size", type: .nonNull(.scalar(Double.self))),
        GraphQLField("unseenCount", type: .nonNull(.scalar(Double.self))),
        GraphQLField("ttl", type: .scalar(Double.self)),
        GraphQLField("customFolderName", type: .object(CustomFolderName.selections)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddressId: GraphQLID, folderName: String, size: Double, unseenCount: Double, ttl: Double? = nil, customFolderName: CustomFolderName? = nil) {
        self.init(snapshot: ["__typename": "EmailFolder", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddressId": emailAddressId, "folderName": folderName, "size": size, "unseenCount": unseenCount, "ttl": ttl, "customFolderName": customFolderName.flatMap { $0.snapshot }])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var emailAddressId: GraphQLID {
        get {
          return snapshot["emailAddressId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddressId")
        }
      }

      internal var folderName: String {
        get {
          return snapshot["folderName"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "folderName")
        }
      }

      internal var size: Double {
        get {
          return snapshot["size"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "size")
        }
      }

      internal var unseenCount: Double {
        get {
          return snapshot["unseenCount"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "unseenCount")
        }
      }

      internal var ttl: Double? {
        get {
          return snapshot["ttl"] as? Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "ttl")
        }
      }

      internal var customFolderName: CustomFolderName? {
        get {
          return (snapshot["customFolderName"] as? Snapshot).flatMap { CustomFolderName(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "customFolderName")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var emailFolder: EmailFolder {
          get {
            return EmailFolder(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Owner: GraphQLSelectionSet {
        internal static let possibleTypes = ["Owner"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: String, issuer: String) {
          self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var issuer: String {
          get {
            return snapshot["issuer"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "issuer")
          }
        }
      }

      internal struct CustomFolderName: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedAttribute"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
          GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
          self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var plainTextType: String {
          get {
            return snapshot["plainTextType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "plainTextType")
          }
        }

        internal var base64EncodedSealedData: String {
          get {
            return snapshot["base64EncodedSealedData"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var sealedAttribute: SealedAttribute {
            get {
              return SealedAttribute(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }
    }
  }
}

internal final class CreatePublicKeyForEmailMutation: GraphQLMutation {
  internal static let operationString =
    "mutation CreatePublicKeyForEmail($input: CreatePublicKeyInput!) {\n  createPublicKeyForEmail(input: $input) {\n    __typename\n    ...PublicKey\n  }\n}"

  internal static var requestString: String { return operationString.appending(PublicKey.fragmentString) }

  internal var input: CreatePublicKeyInput

  internal init(input: CreatePublicKeyInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("createPublicKeyForEmail", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(CreatePublicKeyForEmail.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(createPublicKeyForEmail: CreatePublicKeyForEmail) {
      self.init(snapshot: ["__typename": "Mutation", "createPublicKeyForEmail": createPublicKeyForEmail.snapshot])
    }

    internal var createPublicKeyForEmail: CreatePublicKeyForEmail {
      get {
        return CreatePublicKeyForEmail(snapshot: snapshot["createPublicKeyForEmail"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "createPublicKeyForEmail")
      }
    }

    internal struct CreatePublicKeyForEmail: GraphQLSelectionSet {
      internal static let possibleTypes = ["PublicKey"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyFormat", type: .scalar(KeyFormat.self)),
        GraphQLField("publicKey", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, keyId: String, keyRingId: String, algorithm: String, keyFormat: KeyFormat? = nil, publicKey: String, owner: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "PublicKey", "id": id, "keyId": keyId, "keyRingId": keyRingId, "algorithm": algorithm, "keyFormat": keyFormat, "publicKey": publicKey, "owner": owner, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var keyId: String {
        get {
          return snapshot["keyId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyId")
        }
      }

      internal var keyRingId: String {
        get {
          return snapshot["keyRingId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyRingId")
        }
      }

      internal var algorithm: String {
        get {
          return snapshot["algorithm"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "algorithm")
        }
      }

      internal var keyFormat: KeyFormat? {
        get {
          return snapshot["keyFormat"] as? KeyFormat
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyFormat")
        }
      }

      internal var publicKey: String {
        get {
          return snapshot["publicKey"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "publicKey")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var publicKey: PublicKey {
          get {
            return PublicKey(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal final class GetEmailConfigQuery: GraphQLQuery {
  internal static let operationString =
    "query GetEmailConfig {\n  getEmailConfig {\n    __typename\n    ...EmailConfigurationData\n  }\n}"

  internal static var requestString: String { return operationString.appending(EmailConfigurationData.fragmentString) }

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getEmailConfig", type: .nonNull(.object(GetEmailConfig.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getEmailConfig: GetEmailConfig) {
      self.init(snapshot: ["__typename": "Query", "getEmailConfig": getEmailConfig.snapshot])
    }

    internal var getEmailConfig: GetEmailConfig {
      get {
        return GetEmailConfig(snapshot: snapshot["getEmailConfig"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "getEmailConfig")
      }
    }

    internal struct GetEmailConfig: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailConfigurationData"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("deleteEmailMessagesLimit", type: .nonNull(.scalar(Int.self))),
        GraphQLField("updateEmailMessagesLimit", type: .nonNull(.scalar(Int.self))),
        GraphQLField("emailMessageMaxInboundMessageSize", type: .nonNull(.scalar(Int.self))),
        GraphQLField("emailMessageMaxOutboundMessageSize", type: .nonNull(.scalar(Int.self))),
        GraphQLField("emailMessageRecipientsLimit", type: .nonNull(.scalar(Int.self))),
        GraphQLField("encryptedEmailMessageRecipientsLimit", type: .nonNull(.scalar(Int.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(deleteEmailMessagesLimit: Int, updateEmailMessagesLimit: Int, emailMessageMaxInboundMessageSize: Int, emailMessageMaxOutboundMessageSize: Int, emailMessageRecipientsLimit: Int, encryptedEmailMessageRecipientsLimit: Int) {
        self.init(snapshot: ["__typename": "EmailConfigurationData", "deleteEmailMessagesLimit": deleteEmailMessagesLimit, "updateEmailMessagesLimit": updateEmailMessagesLimit, "emailMessageMaxInboundMessageSize": emailMessageMaxInboundMessageSize, "emailMessageMaxOutboundMessageSize": emailMessageMaxOutboundMessageSize, "emailMessageRecipientsLimit": emailMessageRecipientsLimit, "encryptedEmailMessageRecipientsLimit": encryptedEmailMessageRecipientsLimit])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var deleteEmailMessagesLimit: Int {
        get {
          return snapshot["deleteEmailMessagesLimit"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "deleteEmailMessagesLimit")
        }
      }

      internal var updateEmailMessagesLimit: Int {
        get {
          return snapshot["updateEmailMessagesLimit"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "updateEmailMessagesLimit")
        }
      }

      internal var emailMessageMaxInboundMessageSize: Int {
        get {
          return snapshot["emailMessageMaxInboundMessageSize"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailMessageMaxInboundMessageSize")
        }
      }

      internal var emailMessageMaxOutboundMessageSize: Int {
        get {
          return snapshot["emailMessageMaxOutboundMessageSize"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailMessageMaxOutboundMessageSize")
        }
      }

      internal var emailMessageRecipientsLimit: Int {
        get {
          return snapshot["emailMessageRecipientsLimit"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailMessageRecipientsLimit")
        }
      }

      internal var encryptedEmailMessageRecipientsLimit: Int {
        get {
          return snapshot["encryptedEmailMessageRecipientsLimit"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "encryptedEmailMessageRecipientsLimit")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var emailConfigurationData: EmailConfigurationData {
          get {
            return EmailConfigurationData(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal final class GetEmailDomainsQuery: GraphQLQuery {
  internal static let operationString =
    "query GetEmailDomains {\n  getEmailDomains {\n    __typename\n    domains\n  }\n}"

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getEmailDomains", type: .nonNull(.object(GetEmailDomain.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getEmailDomains: GetEmailDomain) {
      self.init(snapshot: ["__typename": "Query", "getEmailDomains": getEmailDomains.snapshot])
    }

    internal var getEmailDomains: GetEmailDomain {
      get {
        return GetEmailDomain(snapshot: snapshot["getEmailDomains"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "getEmailDomains")
      }
    }

    internal struct GetEmailDomain: GraphQLSelectionSet {
      internal static let possibleTypes = ["SupportedDomains"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("domains", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(domains: [String]) {
        self.init(snapshot: ["__typename": "SupportedDomains", "domains": domains])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var domains: [String] {
        get {
          return snapshot["domains"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "domains")
        }
      }
    }
  }
}

internal final class GetConfiguredEmailDomainsQuery: GraphQLQuery {
  internal static let operationString =
    "query GetConfiguredEmailDomains {\n  getConfiguredEmailDomains {\n    __typename\n    domains\n  }\n}"

  internal init() {
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getConfiguredEmailDomains", type: .nonNull(.object(GetConfiguredEmailDomain.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getConfiguredEmailDomains: GetConfiguredEmailDomain) {
      self.init(snapshot: ["__typename": "Query", "getConfiguredEmailDomains": getConfiguredEmailDomains.snapshot])
    }

    internal var getConfiguredEmailDomains: GetConfiguredEmailDomain {
      get {
        return GetConfiguredEmailDomain(snapshot: snapshot["getConfiguredEmailDomains"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "getConfiguredEmailDomains")
      }
    }

    internal struct GetConfiguredEmailDomain: GraphQLSelectionSet {
      internal static let possibleTypes = ["ConfiguredDomains"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("domains", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(domains: [String]) {
        self.init(snapshot: ["__typename": "ConfiguredDomains", "domains": domains])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var domains: [String] {
        get {
          return snapshot["domains"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "domains")
        }
      }
    }
  }
}

internal final class CheckEmailAddressAvailabilityQuery: GraphQLQuery {
  internal static let operationString =
    "query CheckEmailAddressAvailability($input: CheckEmailAddressAvailabilityInput!) {\n  checkEmailAddressAvailability(input: $input) {\n    __typename\n    addresses\n  }\n}"

  internal var input: CheckEmailAddressAvailabilityInput

  internal init(input: CheckEmailAddressAvailabilityInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("checkEmailAddressAvailability", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(CheckEmailAddressAvailability.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(checkEmailAddressAvailability: CheckEmailAddressAvailability) {
      self.init(snapshot: ["__typename": "Query", "checkEmailAddressAvailability": checkEmailAddressAvailability.snapshot])
    }

    internal var checkEmailAddressAvailability: CheckEmailAddressAvailability {
      get {
        return CheckEmailAddressAvailability(snapshot: snapshot["checkEmailAddressAvailability"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "checkEmailAddressAvailability")
      }
    }

    internal struct CheckEmailAddressAvailability: GraphQLSelectionSet {
      internal static let possibleTypes = ["AvailableAddresses"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("addresses", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(addresses: [String]) {
        self.init(snapshot: ["__typename": "AvailableAddresses", "addresses": addresses])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var addresses: [String] {
        get {
          return snapshot["addresses"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "addresses")
        }
      }
    }
  }
}

internal final class GetEmailAddressQuery: GraphQLQuery {
  internal static let operationString =
    "query GetEmailAddress($id: String!) {\n  getEmailAddress(id: $id) {\n    __typename\n    ...EmailAddress\n  }\n}"

  internal static var requestString: String { return operationString.appending(EmailAddress.fragmentString).appending(EmailAddressWithoutFolders.fragmentString).appending(SealedAttribute.fragmentString).appending(EmailFolder.fragmentString) }

  internal var id: String

  internal init(id: String) {
    self.id = id
  }

  internal var variables: GraphQLMap? {
    return ["id": id]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getEmailAddress", arguments: ["id": GraphQLVariable("id")], type: .object(GetEmailAddress.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getEmailAddress: GetEmailAddress? = nil) {
      self.init(snapshot: ["__typename": "Query", "getEmailAddress": getEmailAddress.flatMap { $0.snapshot }])
    }

    internal var getEmailAddress: GetEmailAddress? {
      get {
        return (snapshot["getEmailAddress"] as? Snapshot).flatMap { GetEmailAddress(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getEmailAddress")
      }
    }

    internal struct GetEmailAddress: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailAddress"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("identityId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyIds", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("lastReceivedAtEpochMs", type: .scalar(Double.self)),
        GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
        GraphQLField("size", type: .nonNull(.scalar(Double.self))),
        GraphQLField("numberOfEmailMessages", type: .nonNull(.scalar(Int.self))),
        GraphQLField("alias", type: .object(Alias.selections)),
        GraphQLField("folders", type: .nonNull(.list(.nonNull(.object(Folder.selections))))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], identityId: GraphQLID, keyRingId: GraphQLID, keyIds: [String], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, lastReceivedAtEpochMs: Double? = nil, emailAddress: String, size: Double, numberOfEmailMessages: Int, alias: Alias? = nil, folders: [Folder]) {
        self.init(snapshot: ["__typename": "EmailAddress", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "identityId": identityId, "keyRingId": keyRingId, "keyIds": keyIds, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "lastReceivedAtEpochMs": lastReceivedAtEpochMs, "emailAddress": emailAddress, "size": size, "numberOfEmailMessages": numberOfEmailMessages, "alias": alias.flatMap { $0.snapshot }, "folders": folders.map { $0.snapshot }])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      internal var identityId: GraphQLID {
        get {
          return snapshot["identityId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "identityId")
        }
      }

      internal var keyRingId: GraphQLID {
        get {
          return snapshot["keyRingId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyRingId")
        }
      }

      internal var keyIds: [String] {
        get {
          return snapshot["keyIds"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyIds")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var lastReceivedAtEpochMs: Double? {
        get {
          return snapshot["lastReceivedAtEpochMs"] as? Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "lastReceivedAtEpochMs")
        }
      }

      internal var emailAddress: String {
        get {
          return snapshot["emailAddress"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddress")
        }
      }

      internal var size: Double {
        get {
          return snapshot["size"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "size")
        }
      }

      internal var numberOfEmailMessages: Int {
        get {
          return snapshot["numberOfEmailMessages"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "numberOfEmailMessages")
        }
      }

      internal var alias: Alias? {
        get {
          return (snapshot["alias"] as? Snapshot).flatMap { Alias(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "alias")
        }
      }

      internal var folders: [Folder] {
        get {
          return (snapshot["folders"] as! [Snapshot]).map { Folder(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "folders")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var emailAddress: EmailAddress {
          get {
            return EmailAddress(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal var emailAddressWithoutFolders: EmailAddressWithoutFolders {
          get {
            return EmailAddressWithoutFolders(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Owner: GraphQLSelectionSet {
        internal static let possibleTypes = ["Owner"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: String, issuer: String) {
          self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var issuer: String {
          get {
            return snapshot["issuer"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "issuer")
          }
        }
      }

      internal struct Alias: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedAttribute"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
          GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
          self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var plainTextType: String {
          get {
            return snapshot["plainTextType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "plainTextType")
          }
        }

        internal var base64EncodedSealedData: String {
          get {
            return snapshot["base64EncodedSealedData"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var sealedAttribute: SealedAttribute {
            get {
              return SealedAttribute(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }

      internal struct Folder: GraphQLSelectionSet {
        internal static let possibleTypes = ["EmailFolder"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("folderName", type: .nonNull(.scalar(String.self))),
          GraphQLField("size", type: .nonNull(.scalar(Double.self))),
          GraphQLField("unseenCount", type: .nonNull(.scalar(Double.self))),
          GraphQLField("ttl", type: .scalar(Double.self)),
          GraphQLField("customFolderName", type: .object(CustomFolderName.selections)),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddressId: GraphQLID, folderName: String, size: Double, unseenCount: Double, ttl: Double? = nil, customFolderName: CustomFolderName? = nil) {
          self.init(snapshot: ["__typename": "EmailFolder", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddressId": emailAddressId, "folderName": folderName, "size": size, "unseenCount": unseenCount, "ttl": ttl, "customFolderName": customFolderName.flatMap { $0.snapshot }])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var owner: GraphQLID {
          get {
            return snapshot["owner"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "owner")
          }
        }

        internal var owners: [Owner] {
          get {
            return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
          }
        }

        internal var version: Int {
          get {
            return snapshot["version"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "version")
          }
        }

        internal var createdAtEpochMs: Double {
          get {
            return snapshot["createdAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
          }
        }

        internal var updatedAtEpochMs: Double {
          get {
            return snapshot["updatedAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
          }
        }

        internal var emailAddressId: GraphQLID {
          get {
            return snapshot["emailAddressId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "emailAddressId")
          }
        }

        internal var folderName: String {
          get {
            return snapshot["folderName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "folderName")
          }
        }

        internal var size: Double {
          get {
            return snapshot["size"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "size")
          }
        }

        internal var unseenCount: Double {
          get {
            return snapshot["unseenCount"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "unseenCount")
          }
        }

        internal var ttl: Double? {
          get {
            return snapshot["ttl"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "ttl")
          }
        }

        internal var customFolderName: CustomFolderName? {
          get {
            return (snapshot["customFolderName"] as? Snapshot).flatMap { CustomFolderName(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "customFolderName")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var emailFolder: EmailFolder {
            get {
              return EmailFolder(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }

        internal struct Owner: GraphQLSelectionSet {
          internal static let possibleTypes = ["Owner"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(id: String, issuer: String) {
            self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var id: String {
            get {
              return snapshot["id"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          internal var issuer: String {
            get {
              return snapshot["issuer"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "issuer")
            }
          }
        }

        internal struct CustomFolderName: GraphQLSelectionSet {
          internal static let possibleTypes = ["SealedAttribute"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
            GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
            GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
            GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
            self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var algorithm: String {
            get {
              return snapshot["algorithm"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "algorithm")
            }
          }

          internal var keyId: String {
            get {
              return snapshot["keyId"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "keyId")
            }
          }

          internal var plainTextType: String {
            get {
              return snapshot["plainTextType"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "plainTextType")
            }
          }

          internal var base64EncodedSealedData: String {
            get {
              return snapshot["base64EncodedSealedData"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
            }
          }

          internal var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          internal struct Fragments {
            internal var snapshot: Snapshot

            internal var sealedAttribute: SealedAttribute {
              get {
                return SealedAttribute(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }
          }
        }
      }
    }
  }
}

internal final class ListEmailAddressesQuery: GraphQLQuery {
  internal static let operationString =
    "query ListEmailAddresses($input: ListEmailAddressesInput!) {\n  listEmailAddresses(input: $input) {\n    __typename\n    items {\n      __typename\n      ...EmailAddress\n    }\n    nextToken\n  }\n}"

  internal static var requestString: String { return operationString.appending(EmailAddress.fragmentString).appending(EmailAddressWithoutFolders.fragmentString).appending(SealedAttribute.fragmentString).appending(EmailFolder.fragmentString) }

  internal var input: ListEmailAddressesInput

  internal init(input: ListEmailAddressesInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("listEmailAddresses", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(ListEmailAddress.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(listEmailAddresses: ListEmailAddress) {
      self.init(snapshot: ["__typename": "Query", "listEmailAddresses": listEmailAddresses.snapshot])
    }

    internal var listEmailAddresses: ListEmailAddress {
      get {
        return ListEmailAddress(snapshot: snapshot["listEmailAddresses"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "listEmailAddresses")
      }
    }

    internal struct ListEmailAddress: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailAddressConnection"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.nonNull(.object(Item.selections))))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(items: [Item], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "EmailAddressConnection", "items": items.map { $0.snapshot }, "nextToken": nextToken])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var items: [Item] {
        get {
          return (snapshot["items"] as! [Snapshot]).map { Item(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "items")
        }
      }

      internal var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      internal struct Item: GraphQLSelectionSet {
        internal static let possibleTypes = ["EmailAddress"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
          GraphQLField("identityId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("keyRingId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("keyIds", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("lastReceivedAtEpochMs", type: .scalar(Double.self)),
          GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
          GraphQLField("size", type: .nonNull(.scalar(Double.self))),
          GraphQLField("numberOfEmailMessages", type: .nonNull(.scalar(Int.self))),
          GraphQLField("alias", type: .object(Alias.selections)),
          GraphQLField("folders", type: .nonNull(.list(.nonNull(.object(Folder.selections))))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], identityId: GraphQLID, keyRingId: GraphQLID, keyIds: [String], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, lastReceivedAtEpochMs: Double? = nil, emailAddress: String, size: Double, numberOfEmailMessages: Int, alias: Alias? = nil, folders: [Folder]) {
          self.init(snapshot: ["__typename": "EmailAddress", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "identityId": identityId, "keyRingId": keyRingId, "keyIds": keyIds, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "lastReceivedAtEpochMs": lastReceivedAtEpochMs, "emailAddress": emailAddress, "size": size, "numberOfEmailMessages": numberOfEmailMessages, "alias": alias.flatMap { $0.snapshot }, "folders": folders.map { $0.snapshot }])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var owner: GraphQLID {
          get {
            return snapshot["owner"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "owner")
          }
        }

        internal var owners: [Owner] {
          get {
            return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
          }
        }

        internal var identityId: GraphQLID {
          get {
            return snapshot["identityId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "identityId")
          }
        }

        internal var keyRingId: GraphQLID {
          get {
            return snapshot["keyRingId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyRingId")
          }
        }

        internal var keyIds: [String] {
          get {
            return snapshot["keyIds"]! as! [String]
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyIds")
          }
        }

        internal var version: Int {
          get {
            return snapshot["version"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "version")
          }
        }

        internal var createdAtEpochMs: Double {
          get {
            return snapshot["createdAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
          }
        }

        internal var updatedAtEpochMs: Double {
          get {
            return snapshot["updatedAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
          }
        }

        internal var lastReceivedAtEpochMs: Double? {
          get {
            return snapshot["lastReceivedAtEpochMs"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "lastReceivedAtEpochMs")
          }
        }

        internal var emailAddress: String {
          get {
            return snapshot["emailAddress"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "emailAddress")
          }
        }

        internal var size: Double {
          get {
            return snapshot["size"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "size")
          }
        }

        internal var numberOfEmailMessages: Int {
          get {
            return snapshot["numberOfEmailMessages"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "numberOfEmailMessages")
          }
        }

        internal var alias: Alias? {
          get {
            return (snapshot["alias"] as? Snapshot).flatMap { Alias(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "alias")
          }
        }

        internal var folders: [Folder] {
          get {
            return (snapshot["folders"] as! [Snapshot]).map { Folder(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "folders")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var emailAddress: EmailAddress {
            get {
              return EmailAddress(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          internal var emailAddressWithoutFolders: EmailAddressWithoutFolders {
            get {
              return EmailAddressWithoutFolders(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }

        internal struct Owner: GraphQLSelectionSet {
          internal static let possibleTypes = ["Owner"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(id: String, issuer: String) {
            self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var id: String {
            get {
              return snapshot["id"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          internal var issuer: String {
            get {
              return snapshot["issuer"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "issuer")
            }
          }
        }

        internal struct Alias: GraphQLSelectionSet {
          internal static let possibleTypes = ["SealedAttribute"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
            GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
            GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
            GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
            self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var algorithm: String {
            get {
              return snapshot["algorithm"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "algorithm")
            }
          }

          internal var keyId: String {
            get {
              return snapshot["keyId"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "keyId")
            }
          }

          internal var plainTextType: String {
            get {
              return snapshot["plainTextType"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "plainTextType")
            }
          }

          internal var base64EncodedSealedData: String {
            get {
              return snapshot["base64EncodedSealedData"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
            }
          }

          internal var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          internal struct Fragments {
            internal var snapshot: Snapshot

            internal var sealedAttribute: SealedAttribute {
              get {
                return SealedAttribute(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }
          }
        }

        internal struct Folder: GraphQLSelectionSet {
          internal static let possibleTypes = ["EmailFolder"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
            GraphQLField("version", type: .nonNull(.scalar(Int.self))),
            GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
            GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
            GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("folderName", type: .nonNull(.scalar(String.self))),
            GraphQLField("size", type: .nonNull(.scalar(Double.self))),
            GraphQLField("unseenCount", type: .nonNull(.scalar(Double.self))),
            GraphQLField("ttl", type: .scalar(Double.self)),
            GraphQLField("customFolderName", type: .object(CustomFolderName.selections)),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddressId: GraphQLID, folderName: String, size: Double, unseenCount: Double, ttl: Double? = nil, customFolderName: CustomFolderName? = nil) {
            self.init(snapshot: ["__typename": "EmailFolder", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddressId": emailAddressId, "folderName": folderName, "size": size, "unseenCount": unseenCount, "ttl": ttl, "customFolderName": customFolderName.flatMap { $0.snapshot }])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var id: GraphQLID {
            get {
              return snapshot["id"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          internal var owner: GraphQLID {
            get {
              return snapshot["owner"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "owner")
            }
          }

          internal var owners: [Owner] {
            get {
              return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
            }
          }

          internal var version: Int {
            get {
              return snapshot["version"]! as! Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "version")
            }
          }

          internal var createdAtEpochMs: Double {
            get {
              return snapshot["createdAtEpochMs"]! as! Double
            }
            set {
              snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
            }
          }

          internal var updatedAtEpochMs: Double {
            get {
              return snapshot["updatedAtEpochMs"]! as! Double
            }
            set {
              snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
            }
          }

          internal var emailAddressId: GraphQLID {
            get {
              return snapshot["emailAddressId"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "emailAddressId")
            }
          }

          internal var folderName: String {
            get {
              return snapshot["folderName"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "folderName")
            }
          }

          internal var size: Double {
            get {
              return snapshot["size"]! as! Double
            }
            set {
              snapshot.updateValue(newValue, forKey: "size")
            }
          }

          internal var unseenCount: Double {
            get {
              return snapshot["unseenCount"]! as! Double
            }
            set {
              snapshot.updateValue(newValue, forKey: "unseenCount")
            }
          }

          internal var ttl: Double? {
            get {
              return snapshot["ttl"] as? Double
            }
            set {
              snapshot.updateValue(newValue, forKey: "ttl")
            }
          }

          internal var customFolderName: CustomFolderName? {
            get {
              return (snapshot["customFolderName"] as? Snapshot).flatMap { CustomFolderName(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "customFolderName")
            }
          }

          internal var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          internal struct Fragments {
            internal var snapshot: Snapshot

            internal var emailFolder: EmailFolder {
              get {
                return EmailFolder(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }
          }

          internal struct Owner: GraphQLSelectionSet {
            internal static let possibleTypes = ["Owner"]

            internal static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(String.self))),
              GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
            ]

            internal var snapshot: Snapshot

            internal init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            internal init(id: String, issuer: String) {
              self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
            }

            internal var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            internal var id: String {
              get {
                return snapshot["id"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "id")
              }
            }

            internal var issuer: String {
              get {
                return snapshot["issuer"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "issuer")
              }
            }
          }

          internal struct CustomFolderName: GraphQLSelectionSet {
            internal static let possibleTypes = ["SealedAttribute"]

            internal static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
              GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
              GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
              GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
            ]

            internal var snapshot: Snapshot

            internal init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
              self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
            }

            internal var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            internal var algorithm: String {
              get {
                return snapshot["algorithm"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "algorithm")
              }
            }

            internal var keyId: String {
              get {
                return snapshot["keyId"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "keyId")
              }
            }

            internal var plainTextType: String {
              get {
                return snapshot["plainTextType"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "plainTextType")
              }
            }

            internal var base64EncodedSealedData: String {
              get {
                return snapshot["base64EncodedSealedData"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
              }
            }

            internal var fragments: Fragments {
              get {
                return Fragments(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            internal struct Fragments {
              internal var snapshot: Snapshot

              internal var sealedAttribute: SealedAttribute {
                get {
                  return SealedAttribute(snapshot: snapshot)
                }
                set {
                  snapshot += newValue.snapshot
                }
              }
            }
          }
        }
      }
    }
  }
}

internal final class ListEmailAddressesForSudoIdQuery: GraphQLQuery {
  internal static let operationString =
    "query ListEmailAddressesForSudoId($input: ListEmailAddressesForSudoIdInput!) {\n  listEmailAddressesForSudoId(input: $input) {\n    __typename\n    items {\n      __typename\n      ...EmailAddress\n    }\n    nextToken\n  }\n}"

  internal static var requestString: String { return operationString.appending(EmailAddress.fragmentString).appending(EmailAddressWithoutFolders.fragmentString).appending(SealedAttribute.fragmentString).appending(EmailFolder.fragmentString) }

  internal var input: ListEmailAddressesForSudoIdInput

  internal init(input: ListEmailAddressesForSudoIdInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("listEmailAddressesForSudoId", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(ListEmailAddressesForSudoId.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(listEmailAddressesForSudoId: ListEmailAddressesForSudoId) {
      self.init(snapshot: ["__typename": "Query", "listEmailAddressesForSudoId": listEmailAddressesForSudoId.snapshot])
    }

    internal var listEmailAddressesForSudoId: ListEmailAddressesForSudoId {
      get {
        return ListEmailAddressesForSudoId(snapshot: snapshot["listEmailAddressesForSudoId"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "listEmailAddressesForSudoId")
      }
    }

    internal struct ListEmailAddressesForSudoId: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailAddressConnection"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.nonNull(.object(Item.selections))))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(items: [Item], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "EmailAddressConnection", "items": items.map { $0.snapshot }, "nextToken": nextToken])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var items: [Item] {
        get {
          return (snapshot["items"] as! [Snapshot]).map { Item(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "items")
        }
      }

      internal var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      internal struct Item: GraphQLSelectionSet {
        internal static let possibleTypes = ["EmailAddress"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
          GraphQLField("identityId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("keyRingId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("keyIds", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("lastReceivedAtEpochMs", type: .scalar(Double.self)),
          GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
          GraphQLField("size", type: .nonNull(.scalar(Double.self))),
          GraphQLField("numberOfEmailMessages", type: .nonNull(.scalar(Int.self))),
          GraphQLField("alias", type: .object(Alias.selections)),
          GraphQLField("folders", type: .nonNull(.list(.nonNull(.object(Folder.selections))))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], identityId: GraphQLID, keyRingId: GraphQLID, keyIds: [String], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, lastReceivedAtEpochMs: Double? = nil, emailAddress: String, size: Double, numberOfEmailMessages: Int, alias: Alias? = nil, folders: [Folder]) {
          self.init(snapshot: ["__typename": "EmailAddress", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "identityId": identityId, "keyRingId": keyRingId, "keyIds": keyIds, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "lastReceivedAtEpochMs": lastReceivedAtEpochMs, "emailAddress": emailAddress, "size": size, "numberOfEmailMessages": numberOfEmailMessages, "alias": alias.flatMap { $0.snapshot }, "folders": folders.map { $0.snapshot }])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var owner: GraphQLID {
          get {
            return snapshot["owner"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "owner")
          }
        }

        internal var owners: [Owner] {
          get {
            return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
          }
        }

        internal var identityId: GraphQLID {
          get {
            return snapshot["identityId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "identityId")
          }
        }

        internal var keyRingId: GraphQLID {
          get {
            return snapshot["keyRingId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyRingId")
          }
        }

        internal var keyIds: [String] {
          get {
            return snapshot["keyIds"]! as! [String]
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyIds")
          }
        }

        internal var version: Int {
          get {
            return snapshot["version"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "version")
          }
        }

        internal var createdAtEpochMs: Double {
          get {
            return snapshot["createdAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
          }
        }

        internal var updatedAtEpochMs: Double {
          get {
            return snapshot["updatedAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
          }
        }

        internal var lastReceivedAtEpochMs: Double? {
          get {
            return snapshot["lastReceivedAtEpochMs"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "lastReceivedAtEpochMs")
          }
        }

        internal var emailAddress: String {
          get {
            return snapshot["emailAddress"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "emailAddress")
          }
        }

        internal var size: Double {
          get {
            return snapshot["size"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "size")
          }
        }

        internal var numberOfEmailMessages: Int {
          get {
            return snapshot["numberOfEmailMessages"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "numberOfEmailMessages")
          }
        }

        internal var alias: Alias? {
          get {
            return (snapshot["alias"] as? Snapshot).flatMap { Alias(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "alias")
          }
        }

        internal var folders: [Folder] {
          get {
            return (snapshot["folders"] as! [Snapshot]).map { Folder(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "folders")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var emailAddress: EmailAddress {
            get {
              return EmailAddress(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          internal var emailAddressWithoutFolders: EmailAddressWithoutFolders {
            get {
              return EmailAddressWithoutFolders(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }

        internal struct Owner: GraphQLSelectionSet {
          internal static let possibleTypes = ["Owner"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(id: String, issuer: String) {
            self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var id: String {
            get {
              return snapshot["id"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          internal var issuer: String {
            get {
              return snapshot["issuer"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "issuer")
            }
          }
        }

        internal struct Alias: GraphQLSelectionSet {
          internal static let possibleTypes = ["SealedAttribute"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
            GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
            GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
            GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
            self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var algorithm: String {
            get {
              return snapshot["algorithm"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "algorithm")
            }
          }

          internal var keyId: String {
            get {
              return snapshot["keyId"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "keyId")
            }
          }

          internal var plainTextType: String {
            get {
              return snapshot["plainTextType"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "plainTextType")
            }
          }

          internal var base64EncodedSealedData: String {
            get {
              return snapshot["base64EncodedSealedData"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
            }
          }

          internal var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          internal struct Fragments {
            internal var snapshot: Snapshot

            internal var sealedAttribute: SealedAttribute {
              get {
                return SealedAttribute(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }
          }
        }

        internal struct Folder: GraphQLSelectionSet {
          internal static let possibleTypes = ["EmailFolder"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
            GraphQLField("version", type: .nonNull(.scalar(Int.self))),
            GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
            GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
            GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("folderName", type: .nonNull(.scalar(String.self))),
            GraphQLField("size", type: .nonNull(.scalar(Double.self))),
            GraphQLField("unseenCount", type: .nonNull(.scalar(Double.self))),
            GraphQLField("ttl", type: .scalar(Double.self)),
            GraphQLField("customFolderName", type: .object(CustomFolderName.selections)),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddressId: GraphQLID, folderName: String, size: Double, unseenCount: Double, ttl: Double? = nil, customFolderName: CustomFolderName? = nil) {
            self.init(snapshot: ["__typename": "EmailFolder", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddressId": emailAddressId, "folderName": folderName, "size": size, "unseenCount": unseenCount, "ttl": ttl, "customFolderName": customFolderName.flatMap { $0.snapshot }])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var id: GraphQLID {
            get {
              return snapshot["id"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          internal var owner: GraphQLID {
            get {
              return snapshot["owner"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "owner")
            }
          }

          internal var owners: [Owner] {
            get {
              return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
            }
          }

          internal var version: Int {
            get {
              return snapshot["version"]! as! Int
            }
            set {
              snapshot.updateValue(newValue, forKey: "version")
            }
          }

          internal var createdAtEpochMs: Double {
            get {
              return snapshot["createdAtEpochMs"]! as! Double
            }
            set {
              snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
            }
          }

          internal var updatedAtEpochMs: Double {
            get {
              return snapshot["updatedAtEpochMs"]! as! Double
            }
            set {
              snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
            }
          }

          internal var emailAddressId: GraphQLID {
            get {
              return snapshot["emailAddressId"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "emailAddressId")
            }
          }

          internal var folderName: String {
            get {
              return snapshot["folderName"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "folderName")
            }
          }

          internal var size: Double {
            get {
              return snapshot["size"]! as! Double
            }
            set {
              snapshot.updateValue(newValue, forKey: "size")
            }
          }

          internal var unseenCount: Double {
            get {
              return snapshot["unseenCount"]! as! Double
            }
            set {
              snapshot.updateValue(newValue, forKey: "unseenCount")
            }
          }

          internal var ttl: Double? {
            get {
              return snapshot["ttl"] as? Double
            }
            set {
              snapshot.updateValue(newValue, forKey: "ttl")
            }
          }

          internal var customFolderName: CustomFolderName? {
            get {
              return (snapshot["customFolderName"] as? Snapshot).flatMap { CustomFolderName(snapshot: $0) }
            }
            set {
              snapshot.updateValue(newValue?.snapshot, forKey: "customFolderName")
            }
          }

          internal var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          internal struct Fragments {
            internal var snapshot: Snapshot

            internal var emailFolder: EmailFolder {
              get {
                return EmailFolder(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }
          }

          internal struct Owner: GraphQLSelectionSet {
            internal static let possibleTypes = ["Owner"]

            internal static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(String.self))),
              GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
            ]

            internal var snapshot: Snapshot

            internal init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            internal init(id: String, issuer: String) {
              self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
            }

            internal var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            internal var id: String {
              get {
                return snapshot["id"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "id")
              }
            }

            internal var issuer: String {
              get {
                return snapshot["issuer"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "issuer")
              }
            }
          }

          internal struct CustomFolderName: GraphQLSelectionSet {
            internal static let possibleTypes = ["SealedAttribute"]

            internal static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
              GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
              GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
              GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
            ]

            internal var snapshot: Snapshot

            internal init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
              self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
            }

            internal var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            internal var algorithm: String {
              get {
                return snapshot["algorithm"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "algorithm")
              }
            }

            internal var keyId: String {
              get {
                return snapshot["keyId"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "keyId")
              }
            }

            internal var plainTextType: String {
              get {
                return snapshot["plainTextType"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "plainTextType")
              }
            }

            internal var base64EncodedSealedData: String {
              get {
                return snapshot["base64EncodedSealedData"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
              }
            }

            internal var fragments: Fragments {
              get {
                return Fragments(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }

            internal struct Fragments {
              internal var snapshot: Snapshot

              internal var sealedAttribute: SealedAttribute {
                get {
                  return SealedAttribute(snapshot: snapshot)
                }
                set {
                  snapshot += newValue.snapshot
                }
              }
            }
          }
        }
      }
    }
  }
}

internal final class LookupEmailAddressesPublicInfoQuery: GraphQLQuery {
  internal static let operationString =
    "query LookupEmailAddressesPublicInfo($input: LookupEmailAddressesPublicInfoInput!) {\n  lookupEmailAddressesPublicInfo(input: $input) {\n    __typename\n    items {\n      __typename\n      ...EmailAddressPublicInfo\n    }\n  }\n}"

  internal static var requestString: String { return operationString.appending(EmailAddressPublicInfo.fragmentString) }

  internal var input: LookupEmailAddressesPublicInfoInput

  internal init(input: LookupEmailAddressesPublicInfoInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("lookupEmailAddressesPublicInfo", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(LookupEmailAddressesPublicInfo.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(lookupEmailAddressesPublicInfo: LookupEmailAddressesPublicInfo) {
      self.init(snapshot: ["__typename": "Query", "lookupEmailAddressesPublicInfo": lookupEmailAddressesPublicInfo.snapshot])
    }

    internal var lookupEmailAddressesPublicInfo: LookupEmailAddressesPublicInfo {
      get {
        return LookupEmailAddressesPublicInfo(snapshot: snapshot["lookupEmailAddressesPublicInfo"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "lookupEmailAddressesPublicInfo")
      }
    }

    internal struct LookupEmailAddressesPublicInfo: GraphQLSelectionSet {
      internal static let possibleTypes = ["LookupEmailAddressesPublicInfoResponse"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.nonNull(.object(Item.selections))))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(items: [Item]) {
        self.init(snapshot: ["__typename": "LookupEmailAddressesPublicInfoResponse", "items": items.map { $0.snapshot }])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var items: [Item] {
        get {
          return (snapshot["items"] as! [Snapshot]).map { Item(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "items")
        }
      }

      internal struct Item: GraphQLSelectionSet {
        internal static let possibleTypes = ["EmailAddressPublicInfo"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("publicKey", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(emailAddress: String, keyId: String, publicKey: String) {
          self.init(snapshot: ["__typename": "EmailAddressPublicInfo", "emailAddress": emailAddress, "keyId": keyId, "publicKey": publicKey])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var emailAddress: String {
          get {
            return snapshot["emailAddress"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "emailAddress")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var publicKey: String {
          get {
            return snapshot["publicKey"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "publicKey")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var emailAddressPublicInfo: EmailAddressPublicInfo {
            get {
              return EmailAddressPublicInfo(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }
    }
  }
}

internal final class ListEmailFoldersForEmailAddressIdQuery: GraphQLQuery {
  internal static let operationString =
    "query ListEmailFoldersForEmailAddressId($input: ListEmailFoldersForEmailAddressIdInput!) {\n  listEmailFoldersForEmailAddressId(input: $input) {\n    __typename\n    items {\n      __typename\n      ...EmailFolder\n    }\n    nextToken\n  }\n}"

  internal static var requestString: String { return operationString.appending(EmailFolder.fragmentString).appending(SealedAttribute.fragmentString) }

  internal var input: ListEmailFoldersForEmailAddressIdInput

  internal init(input: ListEmailFoldersForEmailAddressIdInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("listEmailFoldersForEmailAddressId", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(ListEmailFoldersForEmailAddressId.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(listEmailFoldersForEmailAddressId: ListEmailFoldersForEmailAddressId) {
      self.init(snapshot: ["__typename": "Query", "listEmailFoldersForEmailAddressId": listEmailFoldersForEmailAddressId.snapshot])
    }

    internal var listEmailFoldersForEmailAddressId: ListEmailFoldersForEmailAddressId {
      get {
        return ListEmailFoldersForEmailAddressId(snapshot: snapshot["listEmailFoldersForEmailAddressId"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "listEmailFoldersForEmailAddressId")
      }
    }

    internal struct ListEmailFoldersForEmailAddressId: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailFolderConnection"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.nonNull(.object(Item.selections))))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(items: [Item], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "EmailFolderConnection", "items": items.map { $0.snapshot }, "nextToken": nextToken])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var items: [Item] {
        get {
          return (snapshot["items"] as! [Snapshot]).map { Item(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "items")
        }
      }

      internal var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      internal struct Item: GraphQLSelectionSet {
        internal static let possibleTypes = ["EmailFolder"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("folderName", type: .nonNull(.scalar(String.self))),
          GraphQLField("size", type: .nonNull(.scalar(Double.self))),
          GraphQLField("unseenCount", type: .nonNull(.scalar(Double.self))),
          GraphQLField("ttl", type: .scalar(Double.self)),
          GraphQLField("customFolderName", type: .object(CustomFolderName.selections)),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddressId: GraphQLID, folderName: String, size: Double, unseenCount: Double, ttl: Double? = nil, customFolderName: CustomFolderName? = nil) {
          self.init(snapshot: ["__typename": "EmailFolder", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddressId": emailAddressId, "folderName": folderName, "size": size, "unseenCount": unseenCount, "ttl": ttl, "customFolderName": customFolderName.flatMap { $0.snapshot }])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var owner: GraphQLID {
          get {
            return snapshot["owner"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "owner")
          }
        }

        internal var owners: [Owner] {
          get {
            return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
          }
        }

        internal var version: Int {
          get {
            return snapshot["version"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "version")
          }
        }

        internal var createdAtEpochMs: Double {
          get {
            return snapshot["createdAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
          }
        }

        internal var updatedAtEpochMs: Double {
          get {
            return snapshot["updatedAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
          }
        }

        internal var emailAddressId: GraphQLID {
          get {
            return snapshot["emailAddressId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "emailAddressId")
          }
        }

        internal var folderName: String {
          get {
            return snapshot["folderName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "folderName")
          }
        }

        internal var size: Double {
          get {
            return snapshot["size"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "size")
          }
        }

        internal var unseenCount: Double {
          get {
            return snapshot["unseenCount"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "unseenCount")
          }
        }

        internal var ttl: Double? {
          get {
            return snapshot["ttl"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "ttl")
          }
        }

        internal var customFolderName: CustomFolderName? {
          get {
            return (snapshot["customFolderName"] as? Snapshot).flatMap { CustomFolderName(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "customFolderName")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var emailFolder: EmailFolder {
            get {
              return EmailFolder(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }

        internal struct Owner: GraphQLSelectionSet {
          internal static let possibleTypes = ["Owner"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(id: String, issuer: String) {
            self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var id: String {
            get {
              return snapshot["id"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          internal var issuer: String {
            get {
              return snapshot["issuer"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "issuer")
            }
          }
        }

        internal struct CustomFolderName: GraphQLSelectionSet {
          internal static let possibleTypes = ["SealedAttribute"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
            GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
            GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
            GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
            self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var algorithm: String {
            get {
              return snapshot["algorithm"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "algorithm")
            }
          }

          internal var keyId: String {
            get {
              return snapshot["keyId"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "keyId")
            }
          }

          internal var plainTextType: String {
            get {
              return snapshot["plainTextType"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "plainTextType")
            }
          }

          internal var base64EncodedSealedData: String {
            get {
              return snapshot["base64EncodedSealedData"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
            }
          }

          internal var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          internal struct Fragments {
            internal var snapshot: Snapshot

            internal var sealedAttribute: SealedAttribute {
              get {
                return SealedAttribute(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }
          }
        }
      }
    }
  }
}

internal final class GetEmailMessageQuery: GraphQLQuery {
  internal static let operationString =
    "query GetEmailMessage($id: ID!) {\n  getEmailMessage(id: $id) {\n    __typename\n    ...SealedEmailMessage\n  }\n}"

  internal static var requestString: String { return operationString.appending(SealedEmailMessage.fragmentString) }

  internal var id: GraphQLID

  internal init(id: GraphQLID) {
    self.id = id
  }

  internal var variables: GraphQLMap? {
    return ["id": id]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getEmailMessage", arguments: ["id": GraphQLVariable("id")], type: .object(GetEmailMessage.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getEmailMessage: GetEmailMessage? = nil) {
      self.init(snapshot: ["__typename": "Query", "getEmailMessage": getEmailMessage.flatMap { $0.snapshot }])
    }

    internal var getEmailMessage: GetEmailMessage? {
      get {
        return (snapshot["getEmailMessage"] as? Snapshot).flatMap { GetEmailMessage(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getEmailMessage")
      }
    }

    internal struct GetEmailMessage: GraphQLSelectionSet {
      internal static let possibleTypes = ["SealedEmailMessage"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("sortDateEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("folderId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("previousFolderId", type: .scalar(GraphQLID.self)),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("repliedTo", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("forwarded", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("rfc822Header", type: .nonNull(.object(Rfc822Header.selections))),
        GraphQLField("size", type: .nonNull(.scalar(Double.self))),
        GraphQLField("encryptionStatus", type: .scalar(EmailMessageEncryptionStatus.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, sortDateEpochMs: Double, folderId: GraphQLID, previousFolderId: GraphQLID? = nil, direction: EmailMessageDirection, seen: Bool, repliedTo: Bool, forwarded: Bool, state: EmailMessageState, clientRefId: String? = nil, rfc822Header: Rfc822Header, size: Double, encryptionStatus: EmailMessageEncryptionStatus? = nil) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "sortDateEpochMs": sortDateEpochMs, "folderId": folderId, "previousFolderId": previousFolderId, "direction": direction, "seen": seen, "repliedTo": repliedTo, "forwarded": forwarded, "state": state, "clientRefId": clientRefId, "rfc822Header": rfc822Header.snapshot, "size": size, "encryptionStatus": encryptionStatus])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      internal var emailAddressId: GraphQLID {
        get {
          return snapshot["emailAddressId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddressId")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var sortDateEpochMs: Double {
        get {
          return snapshot["sortDateEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "sortDateEpochMs")
        }
      }

      internal var folderId: GraphQLID {
        get {
          return snapshot["folderId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "folderId")
        }
      }

      internal var previousFolderId: GraphQLID? {
        get {
          return snapshot["previousFolderId"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "previousFolderId")
        }
      }

      internal var direction: EmailMessageDirection {
        get {
          return snapshot["direction"]! as! EmailMessageDirection
        }
        set {
          snapshot.updateValue(newValue, forKey: "direction")
        }
      }

      internal var seen: Bool {
        get {
          return snapshot["seen"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "seen")
        }
      }

      internal var repliedTo: Bool {
        get {
          return snapshot["repliedTo"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "repliedTo")
        }
      }

      internal var forwarded: Bool {
        get {
          return snapshot["forwarded"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "forwarded")
        }
      }

      internal var state: EmailMessageState {
        get {
          return snapshot["state"]! as! EmailMessageState
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      internal var clientRefId: String? {
        get {
          return snapshot["clientRefId"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "clientRefId")
        }
      }

      internal var rfc822Header: Rfc822Header {
        get {
          return Rfc822Header(snapshot: snapshot["rfc822Header"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "rfc822Header")
        }
      }

      internal var size: Double {
        get {
          return snapshot["size"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "size")
        }
      }

      internal var encryptionStatus: EmailMessageEncryptionStatus? {
        get {
          return snapshot["encryptionStatus"] as? EmailMessageEncryptionStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "encryptionStatus")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var sealedEmailMessage: SealedEmailMessage {
          get {
            return SealedEmailMessage(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Owner: GraphQLSelectionSet {
        internal static let possibleTypes = ["Owner"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: String, issuer: String) {
          self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var issuer: String {
          get {
            return snapshot["issuer"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "issuer")
          }
        }
      }

      internal struct Rfc822Header: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedAttribute"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
          GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
          self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var plainTextType: String {
          get {
            return snapshot["plainTextType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "plainTextType")
          }
        }

        internal var base64EncodedSealedData: String {
          get {
            return snapshot["base64EncodedSealedData"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
          }
        }
      }
    }
  }
}

internal final class ListEmailMessagesQuery: GraphQLQuery {
  internal static let operationString =
    "query ListEmailMessages($input: ListEmailMessagesInput!) {\n  listEmailMessages(input: $input) {\n    __typename\n    items {\n      __typename\n      ...SealedEmailMessage\n    }\n    nextToken\n  }\n}"

  internal static var requestString: String { return operationString.appending(SealedEmailMessage.fragmentString) }

  internal var input: ListEmailMessagesInput

  internal init(input: ListEmailMessagesInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("listEmailMessages", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(ListEmailMessage.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(listEmailMessages: ListEmailMessage) {
      self.init(snapshot: ["__typename": "Query", "listEmailMessages": listEmailMessages.snapshot])
    }

    internal var listEmailMessages: ListEmailMessage {
      get {
        return ListEmailMessage(snapshot: snapshot["listEmailMessages"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "listEmailMessages")
      }
    }

    internal struct ListEmailMessage: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailMessageConnection"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.nonNull(.object(Item.selections))))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(items: [Item], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "EmailMessageConnection", "items": items.map { $0.snapshot }, "nextToken": nextToken])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var items: [Item] {
        get {
          return (snapshot["items"] as! [Snapshot]).map { Item(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "items")
        }
      }

      internal var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      internal struct Item: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedEmailMessage"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
          GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("sortDateEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("folderId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("previousFolderId", type: .scalar(GraphQLID.self)),
          GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
          GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("repliedTo", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("forwarded", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
          GraphQLField("clientRefId", type: .scalar(String.self)),
          GraphQLField("rfc822Header", type: .nonNull(.object(Rfc822Header.selections))),
          GraphQLField("size", type: .nonNull(.scalar(Double.self))),
          GraphQLField("encryptionStatus", type: .scalar(EmailMessageEncryptionStatus.self)),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, sortDateEpochMs: Double, folderId: GraphQLID, previousFolderId: GraphQLID? = nil, direction: EmailMessageDirection, seen: Bool, repliedTo: Bool, forwarded: Bool, state: EmailMessageState, clientRefId: String? = nil, rfc822Header: Rfc822Header, size: Double, encryptionStatus: EmailMessageEncryptionStatus? = nil) {
          self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "sortDateEpochMs": sortDateEpochMs, "folderId": folderId, "previousFolderId": previousFolderId, "direction": direction, "seen": seen, "repliedTo": repliedTo, "forwarded": forwarded, "state": state, "clientRefId": clientRefId, "rfc822Header": rfc822Header.snapshot, "size": size, "encryptionStatus": encryptionStatus])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var owner: GraphQLID {
          get {
            return snapshot["owner"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "owner")
          }
        }

        internal var owners: [Owner] {
          get {
            return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
          }
        }

        internal var emailAddressId: GraphQLID {
          get {
            return snapshot["emailAddressId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "emailAddressId")
          }
        }

        internal var version: Int {
          get {
            return snapshot["version"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "version")
          }
        }

        internal var createdAtEpochMs: Double {
          get {
            return snapshot["createdAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
          }
        }

        internal var updatedAtEpochMs: Double {
          get {
            return snapshot["updatedAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
          }
        }

        internal var sortDateEpochMs: Double {
          get {
            return snapshot["sortDateEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "sortDateEpochMs")
          }
        }

        internal var folderId: GraphQLID {
          get {
            return snapshot["folderId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "folderId")
          }
        }

        internal var previousFolderId: GraphQLID? {
          get {
            return snapshot["previousFolderId"] as? GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "previousFolderId")
          }
        }

        internal var direction: EmailMessageDirection {
          get {
            return snapshot["direction"]! as! EmailMessageDirection
          }
          set {
            snapshot.updateValue(newValue, forKey: "direction")
          }
        }

        internal var seen: Bool {
          get {
            return snapshot["seen"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "seen")
          }
        }

        internal var repliedTo: Bool {
          get {
            return snapshot["repliedTo"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "repliedTo")
          }
        }

        internal var forwarded: Bool {
          get {
            return snapshot["forwarded"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "forwarded")
          }
        }

        internal var state: EmailMessageState {
          get {
            return snapshot["state"]! as! EmailMessageState
          }
          set {
            snapshot.updateValue(newValue, forKey: "state")
          }
        }

        internal var clientRefId: String? {
          get {
            return snapshot["clientRefId"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "clientRefId")
          }
        }

        internal var rfc822Header: Rfc822Header {
          get {
            return Rfc822Header(snapshot: snapshot["rfc822Header"]! as! Snapshot)
          }
          set {
            snapshot.updateValue(newValue.snapshot, forKey: "rfc822Header")
          }
        }

        internal var size: Double {
          get {
            return snapshot["size"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "size")
          }
        }

        internal var encryptionStatus: EmailMessageEncryptionStatus? {
          get {
            return snapshot["encryptionStatus"] as? EmailMessageEncryptionStatus
          }
          set {
            snapshot.updateValue(newValue, forKey: "encryptionStatus")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var sealedEmailMessage: SealedEmailMessage {
            get {
              return SealedEmailMessage(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }

        internal struct Owner: GraphQLSelectionSet {
          internal static let possibleTypes = ["Owner"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(id: String, issuer: String) {
            self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var id: String {
            get {
              return snapshot["id"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          internal var issuer: String {
            get {
              return snapshot["issuer"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "issuer")
            }
          }
        }

        internal struct Rfc822Header: GraphQLSelectionSet {
          internal static let possibleTypes = ["SealedAttribute"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
            GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
            GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
            GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
            self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var algorithm: String {
            get {
              return snapshot["algorithm"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "algorithm")
            }
          }

          internal var keyId: String {
            get {
              return snapshot["keyId"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "keyId")
            }
          }

          internal var plainTextType: String {
            get {
              return snapshot["plainTextType"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "plainTextType")
            }
          }

          internal var base64EncodedSealedData: String {
            get {
              return snapshot["base64EncodedSealedData"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
            }
          }
        }
      }
    }
  }
}

internal final class ListEmailMessagesForEmailAddressIdQuery: GraphQLQuery {
  internal static let operationString =
    "query ListEmailMessagesForEmailAddressId($input: ListEmailMessagesForEmailAddressIdInput!) {\n  listEmailMessagesForEmailAddressId(input: $input) {\n    __typename\n    items {\n      __typename\n      ...SealedEmailMessage\n    }\n    nextToken\n  }\n}"

  internal static var requestString: String { return operationString.appending(SealedEmailMessage.fragmentString) }

  internal var input: ListEmailMessagesForEmailAddressIdInput

  internal init(input: ListEmailMessagesForEmailAddressIdInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("listEmailMessagesForEmailAddressId", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(ListEmailMessagesForEmailAddressId.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(listEmailMessagesForEmailAddressId: ListEmailMessagesForEmailAddressId) {
      self.init(snapshot: ["__typename": "Query", "listEmailMessagesForEmailAddressId": listEmailMessagesForEmailAddressId.snapshot])
    }

    internal var listEmailMessagesForEmailAddressId: ListEmailMessagesForEmailAddressId {
      get {
        return ListEmailMessagesForEmailAddressId(snapshot: snapshot["listEmailMessagesForEmailAddressId"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "listEmailMessagesForEmailAddressId")
      }
    }

    internal struct ListEmailMessagesForEmailAddressId: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailMessageConnection"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.nonNull(.object(Item.selections))))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(items: [Item], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "EmailMessageConnection", "items": items.map { $0.snapshot }, "nextToken": nextToken])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var items: [Item] {
        get {
          return (snapshot["items"] as! [Snapshot]).map { Item(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "items")
        }
      }

      internal var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      internal struct Item: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedEmailMessage"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
          GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("sortDateEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("folderId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("previousFolderId", type: .scalar(GraphQLID.self)),
          GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
          GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("repliedTo", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("forwarded", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
          GraphQLField("clientRefId", type: .scalar(String.self)),
          GraphQLField("rfc822Header", type: .nonNull(.object(Rfc822Header.selections))),
          GraphQLField("size", type: .nonNull(.scalar(Double.self))),
          GraphQLField("encryptionStatus", type: .scalar(EmailMessageEncryptionStatus.self)),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, sortDateEpochMs: Double, folderId: GraphQLID, previousFolderId: GraphQLID? = nil, direction: EmailMessageDirection, seen: Bool, repliedTo: Bool, forwarded: Bool, state: EmailMessageState, clientRefId: String? = nil, rfc822Header: Rfc822Header, size: Double, encryptionStatus: EmailMessageEncryptionStatus? = nil) {
          self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "sortDateEpochMs": sortDateEpochMs, "folderId": folderId, "previousFolderId": previousFolderId, "direction": direction, "seen": seen, "repliedTo": repliedTo, "forwarded": forwarded, "state": state, "clientRefId": clientRefId, "rfc822Header": rfc822Header.snapshot, "size": size, "encryptionStatus": encryptionStatus])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var owner: GraphQLID {
          get {
            return snapshot["owner"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "owner")
          }
        }

        internal var owners: [Owner] {
          get {
            return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
          }
        }

        internal var emailAddressId: GraphQLID {
          get {
            return snapshot["emailAddressId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "emailAddressId")
          }
        }

        internal var version: Int {
          get {
            return snapshot["version"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "version")
          }
        }

        internal var createdAtEpochMs: Double {
          get {
            return snapshot["createdAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
          }
        }

        internal var updatedAtEpochMs: Double {
          get {
            return snapshot["updatedAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
          }
        }

        internal var sortDateEpochMs: Double {
          get {
            return snapshot["sortDateEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "sortDateEpochMs")
          }
        }

        internal var folderId: GraphQLID {
          get {
            return snapshot["folderId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "folderId")
          }
        }

        internal var previousFolderId: GraphQLID? {
          get {
            return snapshot["previousFolderId"] as? GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "previousFolderId")
          }
        }

        internal var direction: EmailMessageDirection {
          get {
            return snapshot["direction"]! as! EmailMessageDirection
          }
          set {
            snapshot.updateValue(newValue, forKey: "direction")
          }
        }

        internal var seen: Bool {
          get {
            return snapshot["seen"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "seen")
          }
        }

        internal var repliedTo: Bool {
          get {
            return snapshot["repliedTo"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "repliedTo")
          }
        }

        internal var forwarded: Bool {
          get {
            return snapshot["forwarded"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "forwarded")
          }
        }

        internal var state: EmailMessageState {
          get {
            return snapshot["state"]! as! EmailMessageState
          }
          set {
            snapshot.updateValue(newValue, forKey: "state")
          }
        }

        internal var clientRefId: String? {
          get {
            return snapshot["clientRefId"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "clientRefId")
          }
        }

        internal var rfc822Header: Rfc822Header {
          get {
            return Rfc822Header(snapshot: snapshot["rfc822Header"]! as! Snapshot)
          }
          set {
            snapshot.updateValue(newValue.snapshot, forKey: "rfc822Header")
          }
        }

        internal var size: Double {
          get {
            return snapshot["size"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "size")
          }
        }

        internal var encryptionStatus: EmailMessageEncryptionStatus? {
          get {
            return snapshot["encryptionStatus"] as? EmailMessageEncryptionStatus
          }
          set {
            snapshot.updateValue(newValue, forKey: "encryptionStatus")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var sealedEmailMessage: SealedEmailMessage {
            get {
              return SealedEmailMessage(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }

        internal struct Owner: GraphQLSelectionSet {
          internal static let possibleTypes = ["Owner"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(id: String, issuer: String) {
            self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var id: String {
            get {
              return snapshot["id"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          internal var issuer: String {
            get {
              return snapshot["issuer"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "issuer")
            }
          }
        }

        internal struct Rfc822Header: GraphQLSelectionSet {
          internal static let possibleTypes = ["SealedAttribute"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
            GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
            GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
            GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
            self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var algorithm: String {
            get {
              return snapshot["algorithm"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "algorithm")
            }
          }

          internal var keyId: String {
            get {
              return snapshot["keyId"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "keyId")
            }
          }

          internal var plainTextType: String {
            get {
              return snapshot["plainTextType"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "plainTextType")
            }
          }

          internal var base64EncodedSealedData: String {
            get {
              return snapshot["base64EncodedSealedData"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
            }
          }
        }
      }
    }
  }
}

internal final class ListEmailMessagesForEmailFolderIdQuery: GraphQLQuery {
  internal static let operationString =
    "query ListEmailMessagesForEmailFolderId($input: ListEmailMessagesForEmailFolderIdInput!) {\n  listEmailMessagesForEmailFolderId(input: $input) {\n    __typename\n    items {\n      __typename\n      ...SealedEmailMessage\n    }\n    nextToken\n  }\n}"

  internal static var requestString: String { return operationString.appending(SealedEmailMessage.fragmentString) }

  internal var input: ListEmailMessagesForEmailFolderIdInput

  internal init(input: ListEmailMessagesForEmailFolderIdInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("listEmailMessagesForEmailFolderId", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(ListEmailMessagesForEmailFolderId.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(listEmailMessagesForEmailFolderId: ListEmailMessagesForEmailFolderId) {
      self.init(snapshot: ["__typename": "Query", "listEmailMessagesForEmailFolderId": listEmailMessagesForEmailFolderId.snapshot])
    }

    internal var listEmailMessagesForEmailFolderId: ListEmailMessagesForEmailFolderId {
      get {
        return ListEmailMessagesForEmailFolderId(snapshot: snapshot["listEmailMessagesForEmailFolderId"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "listEmailMessagesForEmailFolderId")
      }
    }

    internal struct ListEmailMessagesForEmailFolderId: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailMessageConnection"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.nonNull(.object(Item.selections))))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(items: [Item], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "EmailMessageConnection", "items": items.map { $0.snapshot }, "nextToken": nextToken])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var items: [Item] {
        get {
          return (snapshot["items"] as! [Snapshot]).map { Item(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "items")
        }
      }

      internal var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      internal struct Item: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedEmailMessage"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
          GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("sortDateEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("folderId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("previousFolderId", type: .scalar(GraphQLID.self)),
          GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
          GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("repliedTo", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("forwarded", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
          GraphQLField("clientRefId", type: .scalar(String.self)),
          GraphQLField("rfc822Header", type: .nonNull(.object(Rfc822Header.selections))),
          GraphQLField("size", type: .nonNull(.scalar(Double.self))),
          GraphQLField("encryptionStatus", type: .scalar(EmailMessageEncryptionStatus.self)),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, sortDateEpochMs: Double, folderId: GraphQLID, previousFolderId: GraphQLID? = nil, direction: EmailMessageDirection, seen: Bool, repliedTo: Bool, forwarded: Bool, state: EmailMessageState, clientRefId: String? = nil, rfc822Header: Rfc822Header, size: Double, encryptionStatus: EmailMessageEncryptionStatus? = nil) {
          self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "sortDateEpochMs": sortDateEpochMs, "folderId": folderId, "previousFolderId": previousFolderId, "direction": direction, "seen": seen, "repliedTo": repliedTo, "forwarded": forwarded, "state": state, "clientRefId": clientRefId, "rfc822Header": rfc822Header.snapshot, "size": size, "encryptionStatus": encryptionStatus])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var owner: GraphQLID {
          get {
            return snapshot["owner"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "owner")
          }
        }

        internal var owners: [Owner] {
          get {
            return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
          }
        }

        internal var emailAddressId: GraphQLID {
          get {
            return snapshot["emailAddressId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "emailAddressId")
          }
        }

        internal var version: Int {
          get {
            return snapshot["version"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "version")
          }
        }

        internal var createdAtEpochMs: Double {
          get {
            return snapshot["createdAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
          }
        }

        internal var updatedAtEpochMs: Double {
          get {
            return snapshot["updatedAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
          }
        }

        internal var sortDateEpochMs: Double {
          get {
            return snapshot["sortDateEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "sortDateEpochMs")
          }
        }

        internal var folderId: GraphQLID {
          get {
            return snapshot["folderId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "folderId")
          }
        }

        internal var previousFolderId: GraphQLID? {
          get {
            return snapshot["previousFolderId"] as? GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "previousFolderId")
          }
        }

        internal var direction: EmailMessageDirection {
          get {
            return snapshot["direction"]! as! EmailMessageDirection
          }
          set {
            snapshot.updateValue(newValue, forKey: "direction")
          }
        }

        internal var seen: Bool {
          get {
            return snapshot["seen"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "seen")
          }
        }

        internal var repliedTo: Bool {
          get {
            return snapshot["repliedTo"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "repliedTo")
          }
        }

        internal var forwarded: Bool {
          get {
            return snapshot["forwarded"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "forwarded")
          }
        }

        internal var state: EmailMessageState {
          get {
            return snapshot["state"]! as! EmailMessageState
          }
          set {
            snapshot.updateValue(newValue, forKey: "state")
          }
        }

        internal var clientRefId: String? {
          get {
            return snapshot["clientRefId"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "clientRefId")
          }
        }

        internal var rfc822Header: Rfc822Header {
          get {
            return Rfc822Header(snapshot: snapshot["rfc822Header"]! as! Snapshot)
          }
          set {
            snapshot.updateValue(newValue.snapshot, forKey: "rfc822Header")
          }
        }

        internal var size: Double {
          get {
            return snapshot["size"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "size")
          }
        }

        internal var encryptionStatus: EmailMessageEncryptionStatus? {
          get {
            return snapshot["encryptionStatus"] as? EmailMessageEncryptionStatus
          }
          set {
            snapshot.updateValue(newValue, forKey: "encryptionStatus")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var sealedEmailMessage: SealedEmailMessage {
            get {
              return SealedEmailMessage(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }

        internal struct Owner: GraphQLSelectionSet {
          internal static let possibleTypes = ["Owner"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(id: String, issuer: String) {
            self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var id: String {
            get {
              return snapshot["id"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          internal var issuer: String {
            get {
              return snapshot["issuer"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "issuer")
            }
          }
        }

        internal struct Rfc822Header: GraphQLSelectionSet {
          internal static let possibleTypes = ["SealedAttribute"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
            GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
            GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
            GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
            self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var algorithm: String {
            get {
              return snapshot["algorithm"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "algorithm")
            }
          }

          internal var keyId: String {
            get {
              return snapshot["keyId"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "keyId")
            }
          }

          internal var plainTextType: String {
            get {
              return snapshot["plainTextType"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "plainTextType")
            }
          }

          internal var base64EncodedSealedData: String {
            get {
              return snapshot["base64EncodedSealedData"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
            }
          }
        }
      }
    }
  }
}

internal final class GetEmailAddressBlocklistQuery: GraphQLQuery {
  internal static let operationString =
    "query GetEmailAddressBlocklist($input: GetEmailAddressBlocklistInput!) {\n  getEmailAddressBlocklist(input: $input) {\n    __typename\n    ...GetEmailAddressBlocklistResponse\n  }\n}"

  internal static var requestString: String { return operationString.appending(GetEmailAddressBlocklistResponse.fragmentString).appending(SealedAttribute.fragmentString) }

  internal var input: GetEmailAddressBlocklistInput

  internal init(input: GetEmailAddressBlocklistInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getEmailAddressBlocklist", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(GetEmailAddressBlocklist.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getEmailAddressBlocklist: GetEmailAddressBlocklist) {
      self.init(snapshot: ["__typename": "Query", "getEmailAddressBlocklist": getEmailAddressBlocklist.snapshot])
    }

    internal var getEmailAddressBlocklist: GetEmailAddressBlocklist {
      get {
        return GetEmailAddressBlocklist(snapshot: snapshot["getEmailAddressBlocklist"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "getEmailAddressBlocklist")
      }
    }

    internal struct GetEmailAddressBlocklist: GraphQLSelectionSet {
      internal static let possibleTypes = ["GetEmailAddressBlocklistResponse"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("blockedAddresses", type: .nonNull(.list(.nonNull(.object(BlockedAddress.selections))))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(blockedAddresses: [BlockedAddress]) {
        self.init(snapshot: ["__typename": "GetEmailAddressBlocklistResponse", "blockedAddresses": blockedAddresses.map { $0.snapshot }])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var blockedAddresses: [BlockedAddress] {
        get {
          return (snapshot["blockedAddresses"] as! [Snapshot]).map { BlockedAddress(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "blockedAddresses")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var getEmailAddressBlocklistResponse: GetEmailAddressBlocklistResponse {
          get {
            return GetEmailAddressBlocklistResponse(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct BlockedAddress: GraphQLSelectionSet {
        internal static let possibleTypes = ["BlockedEmailAddress"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("sealedValue", type: .nonNull(.object(SealedValue.selections))),
          GraphQLField("hashedBlockedValue", type: .nonNull(.scalar(String.self))),
          GraphQLField("action", type: .scalar(BlockedAddressAction.self)),
          GraphQLField("emailAddressId", type: .scalar(String.self)),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(sealedValue: SealedValue, hashedBlockedValue: String, action: BlockedAddressAction? = nil, emailAddressId: String? = nil) {
          self.init(snapshot: ["__typename": "BlockedEmailAddress", "sealedValue": sealedValue.snapshot, "hashedBlockedValue": hashedBlockedValue, "action": action, "emailAddressId": emailAddressId])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var sealedValue: SealedValue {
          get {
            return SealedValue(snapshot: snapshot["sealedValue"]! as! Snapshot)
          }
          set {
            snapshot.updateValue(newValue.snapshot, forKey: "sealedValue")
          }
        }

        internal var hashedBlockedValue: String {
          get {
            return snapshot["hashedBlockedValue"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "hashedBlockedValue")
          }
        }

        internal var action: BlockedAddressAction? {
          get {
            return snapshot["action"] as? BlockedAddressAction
          }
          set {
            snapshot.updateValue(newValue, forKey: "action")
          }
        }

        internal var emailAddressId: String? {
          get {
            return snapshot["emailAddressId"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "emailAddressId")
          }
        }

        internal struct SealedValue: GraphQLSelectionSet {
          internal static let possibleTypes = ["SealedAttribute"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
            GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
            GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
            GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
            self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var algorithm: String {
            get {
              return snapshot["algorithm"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "algorithm")
            }
          }

          internal var keyId: String {
            get {
              return snapshot["keyId"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "keyId")
            }
          }

          internal var plainTextType: String {
            get {
              return snapshot["plainTextType"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "plainTextType")
            }
          }

          internal var base64EncodedSealedData: String {
            get {
              return snapshot["base64EncodedSealedData"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
            }
          }

          internal var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          internal struct Fragments {
            internal var snapshot: Snapshot

            internal var sealedAttribute: SealedAttribute {
              get {
                return SealedAttribute(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }
          }
        }
      }
    }
  }
}

internal final class GetKeyRingForEmailQuery: GraphQLQuery {
  internal static let operationString =
    "query GetKeyRingForEmail($keyRingId: String!, $limit: Int, $nextToken: String) {\n  getKeyRingForEmail(keyRingId: $keyRingId, limit: $limit, nextToken: $nextToken) {\n    __typename\n    ...PaginatedPublicKey\n  }\n}"

  internal static var requestString: String { return operationString.appending(PaginatedPublicKey.fragmentString).appending(PublicKey.fragmentString) }

  internal var keyRingId: String
  internal var limit: Int?
  internal var nextToken: String?

  internal init(keyRingId: String, limit: Int? = nil, nextToken: String? = nil) {
    self.keyRingId = keyRingId
    self.limit = limit
    self.nextToken = nextToken
  }

  internal var variables: GraphQLMap? {
    return ["keyRingId": keyRingId, "limit": limit, "nextToken": nextToken]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getKeyRingForEmail", arguments: ["keyRingId": GraphQLVariable("keyRingId"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken")], type: .nonNull(.object(GetKeyRingForEmail.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getKeyRingForEmail: GetKeyRingForEmail) {
      self.init(snapshot: ["__typename": "Query", "getKeyRingForEmail": getKeyRingForEmail.snapshot])
    }

    internal var getKeyRingForEmail: GetKeyRingForEmail {
      get {
        return GetKeyRingForEmail(snapshot: snapshot["getKeyRingForEmail"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "getKeyRingForEmail")
      }
    }

    internal struct GetKeyRingForEmail: GraphQLSelectionSet {
      internal static let possibleTypes = ["PaginatedPublicKey"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.nonNull(.object(Item.selections))))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(items: [Item], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "PaginatedPublicKey", "items": items.map { $0.snapshot }, "nextToken": nextToken])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var items: [Item] {
        get {
          return (snapshot["items"] as! [Snapshot]).map { Item(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "items")
        }
      }

      internal var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var paginatedPublicKey: PaginatedPublicKey {
          get {
            return PaginatedPublicKey(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Item: GraphQLSelectionSet {
        internal static let possibleTypes = ["PublicKey"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyFormat", type: .scalar(KeyFormat.self)),
          GraphQLField("publicKey", type: .nonNull(.scalar(String.self))),
          GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, keyId: String, keyRingId: String, algorithm: String, keyFormat: KeyFormat? = nil, publicKey: String, owner: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
          self.init(snapshot: ["__typename": "PublicKey", "id": id, "keyId": keyId, "keyRingId": keyRingId, "algorithm": algorithm, "keyFormat": keyFormat, "publicKey": publicKey, "owner": owner, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var keyRingId: String {
          get {
            return snapshot["keyRingId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyRingId")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyFormat: KeyFormat? {
          get {
            return snapshot["keyFormat"] as? KeyFormat
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyFormat")
          }
        }

        internal var publicKey: String {
          get {
            return snapshot["publicKey"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "publicKey")
          }
        }

        internal var owner: GraphQLID {
          get {
            return snapshot["owner"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "owner")
          }
        }

        internal var version: Int {
          get {
            return snapshot["version"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "version")
          }
        }

        internal var createdAtEpochMs: Double {
          get {
            return snapshot["createdAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
          }
        }

        internal var updatedAtEpochMs: Double {
          get {
            return snapshot["updatedAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var publicKey: PublicKey {
            get {
              return PublicKey(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }
    }
  }
}

internal final class GetPublicKeyForEmailQuery: GraphQLQuery {
  internal static let operationString =
    "query GetPublicKeyForEmail($keyId: String!) {\n  getPublicKeyForEmail(keyId: $keyId) {\n    __typename\n    ...PublicKey\n  }\n}"

  internal static var requestString: String { return operationString.appending(PublicKey.fragmentString) }

  internal var keyId: String

  internal init(keyId: String) {
    self.keyId = keyId
  }

  internal var variables: GraphQLMap? {
    return ["keyId": keyId]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getPublicKeyForEmail", arguments: ["keyId": GraphQLVariable("keyId")], type: .object(GetPublicKeyForEmail.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getPublicKeyForEmail: GetPublicKeyForEmail? = nil) {
      self.init(snapshot: ["__typename": "Query", "getPublicKeyForEmail": getPublicKeyForEmail.flatMap { $0.snapshot }])
    }

    internal var getPublicKeyForEmail: GetPublicKeyForEmail? {
      get {
        return (snapshot["getPublicKeyForEmail"] as? Snapshot).flatMap { GetPublicKeyForEmail(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "getPublicKeyForEmail")
      }
    }

    internal struct GetPublicKeyForEmail: GraphQLSelectionSet {
      internal static let possibleTypes = ["PublicKey"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyFormat", type: .scalar(KeyFormat.self)),
        GraphQLField("publicKey", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, keyId: String, keyRingId: String, algorithm: String, keyFormat: KeyFormat? = nil, publicKey: String, owner: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "PublicKey", "id": id, "keyId": keyId, "keyRingId": keyRingId, "algorithm": algorithm, "keyFormat": keyFormat, "publicKey": publicKey, "owner": owner, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var keyId: String {
        get {
          return snapshot["keyId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyId")
        }
      }

      internal var keyRingId: String {
        get {
          return snapshot["keyRingId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyRingId")
        }
      }

      internal var algorithm: String {
        get {
          return snapshot["algorithm"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "algorithm")
        }
      }

      internal var keyFormat: KeyFormat? {
        get {
          return snapshot["keyFormat"] as? KeyFormat
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyFormat")
        }
      }

      internal var publicKey: String {
        get {
          return snapshot["publicKey"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "publicKey")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var publicKey: PublicKey {
          get {
            return PublicKey(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal final class GetPublicKeysForEmailQuery: GraphQLQuery {
  internal static let operationString =
    "query GetPublicKeysForEmail($limit: Int, $nextToken: String) {\n  getPublicKeysForEmail(limit: $limit, nextToken: $nextToken) {\n    __typename\n    ...PaginatedPublicKey\n  }\n}"

  internal static var requestString: String { return operationString.appending(PaginatedPublicKey.fragmentString).appending(PublicKey.fragmentString) }

  internal var limit: Int?
  internal var nextToken: String?

  internal init(limit: Int? = nil, nextToken: String? = nil) {
    self.limit = limit
    self.nextToken = nextToken
  }

  internal var variables: GraphQLMap? {
    return ["limit": limit, "nextToken": nextToken]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getPublicKeysForEmail", arguments: ["limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken")], type: .nonNull(.object(GetPublicKeysForEmail.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getPublicKeysForEmail: GetPublicKeysForEmail) {
      self.init(snapshot: ["__typename": "Query", "getPublicKeysForEmail": getPublicKeysForEmail.snapshot])
    }

    internal var getPublicKeysForEmail: GetPublicKeysForEmail {
      get {
        return GetPublicKeysForEmail(snapshot: snapshot["getPublicKeysForEmail"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "getPublicKeysForEmail")
      }
    }

    internal struct GetPublicKeysForEmail: GraphQLSelectionSet {
      internal static let possibleTypes = ["PaginatedPublicKey"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("items", type: .nonNull(.list(.nonNull(.object(Item.selections))))),
        GraphQLField("nextToken", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(items: [Item], nextToken: String? = nil) {
        self.init(snapshot: ["__typename": "PaginatedPublicKey", "items": items.map { $0.snapshot }, "nextToken": nextToken])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var items: [Item] {
        get {
          return (snapshot["items"] as! [Snapshot]).map { Item(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "items")
        }
      }

      internal var nextToken: String? {
        get {
          return snapshot["nextToken"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "nextToken")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var paginatedPublicKey: PaginatedPublicKey {
          get {
            return PaginatedPublicKey(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Item: GraphQLSelectionSet {
        internal static let possibleTypes = ["PublicKey"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyFormat", type: .scalar(KeyFormat.self)),
          GraphQLField("publicKey", type: .nonNull(.scalar(String.self))),
          GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, keyId: String, keyRingId: String, algorithm: String, keyFormat: KeyFormat? = nil, publicKey: String, owner: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
          self.init(snapshot: ["__typename": "PublicKey", "id": id, "keyId": keyId, "keyRingId": keyRingId, "algorithm": algorithm, "keyFormat": keyFormat, "publicKey": publicKey, "owner": owner, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var keyRingId: String {
          get {
            return snapshot["keyRingId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyRingId")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyFormat: KeyFormat? {
          get {
            return snapshot["keyFormat"] as? KeyFormat
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyFormat")
          }
        }

        internal var publicKey: String {
          get {
            return snapshot["publicKey"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "publicKey")
          }
        }

        internal var owner: GraphQLID {
          get {
            return snapshot["owner"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "owner")
          }
        }

        internal var version: Int {
          get {
            return snapshot["version"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "version")
          }
        }

        internal var createdAtEpochMs: Double {
          get {
            return snapshot["createdAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
          }
        }

        internal var updatedAtEpochMs: Double {
          get {
            return snapshot["updatedAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var publicKey: PublicKey {
            get {
              return PublicKey(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }
    }
  }
}

internal final class OnEmailAddressCreatedSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailAddressCreated($owner: ID!) {\n  onEmailAddressCreated(owner: $owner) {\n    __typename\n    ...EmailAddress\n  }\n}"

  internal static var requestString: String { return operationString.appending(EmailAddress.fragmentString).appending(EmailAddressWithoutFolders.fragmentString).appending(SealedAttribute.fragmentString).appending(EmailFolder.fragmentString) }

  internal var owner: GraphQLID

  internal init(owner: GraphQLID) {
    self.owner = owner
  }

  internal var variables: GraphQLMap? {
    return ["owner": owner]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Subscription"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("onEmailAddressCreated", arguments: ["owner": GraphQLVariable("owner")], type: .object(OnEmailAddressCreated.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(onEmailAddressCreated: OnEmailAddressCreated? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onEmailAddressCreated": onEmailAddressCreated.flatMap { $0.snapshot }])
    }

    internal var onEmailAddressCreated: OnEmailAddressCreated? {
      get {
        return (snapshot["onEmailAddressCreated"] as? Snapshot).flatMap { OnEmailAddressCreated(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onEmailAddressCreated")
      }
    }

    internal struct OnEmailAddressCreated: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailAddress"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("identityId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyIds", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("lastReceivedAtEpochMs", type: .scalar(Double.self)),
        GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
        GraphQLField("size", type: .nonNull(.scalar(Double.self))),
        GraphQLField("numberOfEmailMessages", type: .nonNull(.scalar(Int.self))),
        GraphQLField("alias", type: .object(Alias.selections)),
        GraphQLField("folders", type: .nonNull(.list(.nonNull(.object(Folder.selections))))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], identityId: GraphQLID, keyRingId: GraphQLID, keyIds: [String], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, lastReceivedAtEpochMs: Double? = nil, emailAddress: String, size: Double, numberOfEmailMessages: Int, alias: Alias? = nil, folders: [Folder]) {
        self.init(snapshot: ["__typename": "EmailAddress", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "identityId": identityId, "keyRingId": keyRingId, "keyIds": keyIds, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "lastReceivedAtEpochMs": lastReceivedAtEpochMs, "emailAddress": emailAddress, "size": size, "numberOfEmailMessages": numberOfEmailMessages, "alias": alias.flatMap { $0.snapshot }, "folders": folders.map { $0.snapshot }])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      internal var identityId: GraphQLID {
        get {
          return snapshot["identityId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "identityId")
        }
      }

      internal var keyRingId: GraphQLID {
        get {
          return snapshot["keyRingId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyRingId")
        }
      }

      internal var keyIds: [String] {
        get {
          return snapshot["keyIds"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyIds")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var lastReceivedAtEpochMs: Double? {
        get {
          return snapshot["lastReceivedAtEpochMs"] as? Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "lastReceivedAtEpochMs")
        }
      }

      internal var emailAddress: String {
        get {
          return snapshot["emailAddress"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddress")
        }
      }

      internal var size: Double {
        get {
          return snapshot["size"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "size")
        }
      }

      internal var numberOfEmailMessages: Int {
        get {
          return snapshot["numberOfEmailMessages"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "numberOfEmailMessages")
        }
      }

      internal var alias: Alias? {
        get {
          return (snapshot["alias"] as? Snapshot).flatMap { Alias(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "alias")
        }
      }

      internal var folders: [Folder] {
        get {
          return (snapshot["folders"] as! [Snapshot]).map { Folder(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "folders")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var emailAddress: EmailAddress {
          get {
            return EmailAddress(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal var emailAddressWithoutFolders: EmailAddressWithoutFolders {
          get {
            return EmailAddressWithoutFolders(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Owner: GraphQLSelectionSet {
        internal static let possibleTypes = ["Owner"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: String, issuer: String) {
          self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var issuer: String {
          get {
            return snapshot["issuer"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "issuer")
          }
        }
      }

      internal struct Alias: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedAttribute"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
          GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
          self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var plainTextType: String {
          get {
            return snapshot["plainTextType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "plainTextType")
          }
        }

        internal var base64EncodedSealedData: String {
          get {
            return snapshot["base64EncodedSealedData"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var sealedAttribute: SealedAttribute {
            get {
              return SealedAttribute(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }
      }

      internal struct Folder: GraphQLSelectionSet {
        internal static let possibleTypes = ["EmailFolder"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("folderName", type: .nonNull(.scalar(String.self))),
          GraphQLField("size", type: .nonNull(.scalar(Double.self))),
          GraphQLField("unseenCount", type: .nonNull(.scalar(Double.self))),
          GraphQLField("ttl", type: .scalar(Double.self)),
          GraphQLField("customFolderName", type: .object(CustomFolderName.selections)),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddressId: GraphQLID, folderName: String, size: Double, unseenCount: Double, ttl: Double? = nil, customFolderName: CustomFolderName? = nil) {
          self.init(snapshot: ["__typename": "EmailFolder", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddressId": emailAddressId, "folderName": folderName, "size": size, "unseenCount": unseenCount, "ttl": ttl, "customFolderName": customFolderName.flatMap { $0.snapshot }])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var owner: GraphQLID {
          get {
            return snapshot["owner"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "owner")
          }
        }

        internal var owners: [Owner] {
          get {
            return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
          }
        }

        internal var version: Int {
          get {
            return snapshot["version"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "version")
          }
        }

        internal var createdAtEpochMs: Double {
          get {
            return snapshot["createdAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
          }
        }

        internal var updatedAtEpochMs: Double {
          get {
            return snapshot["updatedAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
          }
        }

        internal var emailAddressId: GraphQLID {
          get {
            return snapshot["emailAddressId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "emailAddressId")
          }
        }

        internal var folderName: String {
          get {
            return snapshot["folderName"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "folderName")
          }
        }

        internal var size: Double {
          get {
            return snapshot["size"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "size")
          }
        }

        internal var unseenCount: Double {
          get {
            return snapshot["unseenCount"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "unseenCount")
          }
        }

        internal var ttl: Double? {
          get {
            return snapshot["ttl"] as? Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "ttl")
          }
        }

        internal var customFolderName: CustomFolderName? {
          get {
            return (snapshot["customFolderName"] as? Snapshot).flatMap { CustomFolderName(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "customFolderName")
          }
        }

        internal var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }

        internal struct Fragments {
          internal var snapshot: Snapshot

          internal var emailFolder: EmailFolder {
            get {
              return EmailFolder(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }
        }

        internal struct Owner: GraphQLSelectionSet {
          internal static let possibleTypes = ["Owner"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(String.self))),
            GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(id: String, issuer: String) {
            self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var id: String {
            get {
              return snapshot["id"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          internal var issuer: String {
            get {
              return snapshot["issuer"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "issuer")
            }
          }
        }

        internal struct CustomFolderName: GraphQLSelectionSet {
          internal static let possibleTypes = ["SealedAttribute"]

          internal static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
            GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
            GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
            GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
          ]

          internal var snapshot: Snapshot

          internal init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
            self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
          }

          internal var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          internal var algorithm: String {
            get {
              return snapshot["algorithm"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "algorithm")
            }
          }

          internal var keyId: String {
            get {
              return snapshot["keyId"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "keyId")
            }
          }

          internal var plainTextType: String {
            get {
              return snapshot["plainTextType"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "plainTextType")
            }
          }

          internal var base64EncodedSealedData: String {
            get {
              return snapshot["base64EncodedSealedData"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
            }
          }

          internal var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot += newValue.snapshot
            }
          }

          internal struct Fragments {
            internal var snapshot: Snapshot

            internal var sealedAttribute: SealedAttribute {
              get {
                return SealedAttribute(snapshot: snapshot)
              }
              set {
                snapshot += newValue.snapshot
              }
            }
          }
        }
      }
    }
  }
}

internal final class OnEmailMessageCreatedSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailMessageCreated($owner: ID!) {\n  onEmailMessageCreated(owner: $owner) {\n    __typename\n    ...SealedEmailMessage\n  }\n}"

  internal static var requestString: String { return operationString.appending(SealedEmailMessage.fragmentString) }

  internal var owner: GraphQLID

  internal init(owner: GraphQLID) {
    self.owner = owner
  }

  internal var variables: GraphQLMap? {
    return ["owner": owner]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Subscription"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("onEmailMessageCreated", arguments: ["owner": GraphQLVariable("owner")], type: .object(OnEmailMessageCreated.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(onEmailMessageCreated: OnEmailMessageCreated? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onEmailMessageCreated": onEmailMessageCreated.flatMap { $0.snapshot }])
    }

    internal var onEmailMessageCreated: OnEmailMessageCreated? {
      get {
        return (snapshot["onEmailMessageCreated"] as? Snapshot).flatMap { OnEmailMessageCreated(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onEmailMessageCreated")
      }
    }

    internal struct OnEmailMessageCreated: GraphQLSelectionSet {
      internal static let possibleTypes = ["SealedEmailMessage"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("sortDateEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("folderId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("previousFolderId", type: .scalar(GraphQLID.self)),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("repliedTo", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("forwarded", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("rfc822Header", type: .nonNull(.object(Rfc822Header.selections))),
        GraphQLField("size", type: .nonNull(.scalar(Double.self))),
        GraphQLField("encryptionStatus", type: .scalar(EmailMessageEncryptionStatus.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, sortDateEpochMs: Double, folderId: GraphQLID, previousFolderId: GraphQLID? = nil, direction: EmailMessageDirection, seen: Bool, repliedTo: Bool, forwarded: Bool, state: EmailMessageState, clientRefId: String? = nil, rfc822Header: Rfc822Header, size: Double, encryptionStatus: EmailMessageEncryptionStatus? = nil) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "sortDateEpochMs": sortDateEpochMs, "folderId": folderId, "previousFolderId": previousFolderId, "direction": direction, "seen": seen, "repliedTo": repliedTo, "forwarded": forwarded, "state": state, "clientRefId": clientRefId, "rfc822Header": rfc822Header.snapshot, "size": size, "encryptionStatus": encryptionStatus])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      internal var emailAddressId: GraphQLID {
        get {
          return snapshot["emailAddressId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddressId")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var sortDateEpochMs: Double {
        get {
          return snapshot["sortDateEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "sortDateEpochMs")
        }
      }

      internal var folderId: GraphQLID {
        get {
          return snapshot["folderId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "folderId")
        }
      }

      internal var previousFolderId: GraphQLID? {
        get {
          return snapshot["previousFolderId"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "previousFolderId")
        }
      }

      internal var direction: EmailMessageDirection {
        get {
          return snapshot["direction"]! as! EmailMessageDirection
        }
        set {
          snapshot.updateValue(newValue, forKey: "direction")
        }
      }

      internal var seen: Bool {
        get {
          return snapshot["seen"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "seen")
        }
      }

      internal var repliedTo: Bool {
        get {
          return snapshot["repliedTo"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "repliedTo")
        }
      }

      internal var forwarded: Bool {
        get {
          return snapshot["forwarded"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "forwarded")
        }
      }

      internal var state: EmailMessageState {
        get {
          return snapshot["state"]! as! EmailMessageState
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      internal var clientRefId: String? {
        get {
          return snapshot["clientRefId"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "clientRefId")
        }
      }

      internal var rfc822Header: Rfc822Header {
        get {
          return Rfc822Header(snapshot: snapshot["rfc822Header"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "rfc822Header")
        }
      }

      internal var size: Double {
        get {
          return snapshot["size"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "size")
        }
      }

      internal var encryptionStatus: EmailMessageEncryptionStatus? {
        get {
          return snapshot["encryptionStatus"] as? EmailMessageEncryptionStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "encryptionStatus")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var sealedEmailMessage: SealedEmailMessage {
          get {
            return SealedEmailMessage(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Owner: GraphQLSelectionSet {
        internal static let possibleTypes = ["Owner"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: String, issuer: String) {
          self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var issuer: String {
          get {
            return snapshot["issuer"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "issuer")
          }
        }
      }

      internal struct Rfc822Header: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedAttribute"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
          GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
          self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var plainTextType: String {
          get {
            return snapshot["plainTextType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "plainTextType")
          }
        }

        internal var base64EncodedSealedData: String {
          get {
            return snapshot["base64EncodedSealedData"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
          }
        }
      }
    }
  }
}

internal final class OnEmailMessageCreatedWithDirectionSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailMessageCreatedWithDirection($owner: ID!, $direction: EmailMessageDirection!) {\n  onEmailMessageCreated(owner: $owner, direction: $direction) {\n    __typename\n    ...SealedEmailMessage\n  }\n}"

  internal static var requestString: String { return operationString.appending(SealedEmailMessage.fragmentString) }

  internal var owner: GraphQLID
  internal var direction: EmailMessageDirection

  internal init(owner: GraphQLID, direction: EmailMessageDirection) {
    self.owner = owner
    self.direction = direction
  }

  internal var variables: GraphQLMap? {
    return ["owner": owner, "direction": direction]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Subscription"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("onEmailMessageCreated", arguments: ["owner": GraphQLVariable("owner"), "direction": GraphQLVariable("direction")], type: .object(OnEmailMessageCreated.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(onEmailMessageCreated: OnEmailMessageCreated? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onEmailMessageCreated": onEmailMessageCreated.flatMap { $0.snapshot }])
    }

    internal var onEmailMessageCreated: OnEmailMessageCreated? {
      get {
        return (snapshot["onEmailMessageCreated"] as? Snapshot).flatMap { OnEmailMessageCreated(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onEmailMessageCreated")
      }
    }

    internal struct OnEmailMessageCreated: GraphQLSelectionSet {
      internal static let possibleTypes = ["SealedEmailMessage"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("sortDateEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("folderId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("previousFolderId", type: .scalar(GraphQLID.self)),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("repliedTo", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("forwarded", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("rfc822Header", type: .nonNull(.object(Rfc822Header.selections))),
        GraphQLField("size", type: .nonNull(.scalar(Double.self))),
        GraphQLField("encryptionStatus", type: .scalar(EmailMessageEncryptionStatus.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, sortDateEpochMs: Double, folderId: GraphQLID, previousFolderId: GraphQLID? = nil, direction: EmailMessageDirection, seen: Bool, repliedTo: Bool, forwarded: Bool, state: EmailMessageState, clientRefId: String? = nil, rfc822Header: Rfc822Header, size: Double, encryptionStatus: EmailMessageEncryptionStatus? = nil) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "sortDateEpochMs": sortDateEpochMs, "folderId": folderId, "previousFolderId": previousFolderId, "direction": direction, "seen": seen, "repliedTo": repliedTo, "forwarded": forwarded, "state": state, "clientRefId": clientRefId, "rfc822Header": rfc822Header.snapshot, "size": size, "encryptionStatus": encryptionStatus])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      internal var emailAddressId: GraphQLID {
        get {
          return snapshot["emailAddressId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddressId")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var sortDateEpochMs: Double {
        get {
          return snapshot["sortDateEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "sortDateEpochMs")
        }
      }

      internal var folderId: GraphQLID {
        get {
          return snapshot["folderId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "folderId")
        }
      }

      internal var previousFolderId: GraphQLID? {
        get {
          return snapshot["previousFolderId"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "previousFolderId")
        }
      }

      internal var direction: EmailMessageDirection {
        get {
          return snapshot["direction"]! as! EmailMessageDirection
        }
        set {
          snapshot.updateValue(newValue, forKey: "direction")
        }
      }

      internal var seen: Bool {
        get {
          return snapshot["seen"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "seen")
        }
      }

      internal var repliedTo: Bool {
        get {
          return snapshot["repliedTo"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "repliedTo")
        }
      }

      internal var forwarded: Bool {
        get {
          return snapshot["forwarded"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "forwarded")
        }
      }

      internal var state: EmailMessageState {
        get {
          return snapshot["state"]! as! EmailMessageState
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      internal var clientRefId: String? {
        get {
          return snapshot["clientRefId"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "clientRefId")
        }
      }

      internal var rfc822Header: Rfc822Header {
        get {
          return Rfc822Header(snapshot: snapshot["rfc822Header"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "rfc822Header")
        }
      }

      internal var size: Double {
        get {
          return snapshot["size"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "size")
        }
      }

      internal var encryptionStatus: EmailMessageEncryptionStatus? {
        get {
          return snapshot["encryptionStatus"] as? EmailMessageEncryptionStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "encryptionStatus")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var sealedEmailMessage: SealedEmailMessage {
          get {
            return SealedEmailMessage(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Owner: GraphQLSelectionSet {
        internal static let possibleTypes = ["Owner"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: String, issuer: String) {
          self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var issuer: String {
          get {
            return snapshot["issuer"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "issuer")
          }
        }
      }

      internal struct Rfc822Header: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedAttribute"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
          GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
          self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var plainTextType: String {
          get {
            return snapshot["plainTextType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "plainTextType")
          }
        }

        internal var base64EncodedSealedData: String {
          get {
            return snapshot["base64EncodedSealedData"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
          }
        }
      }
    }
  }
}

internal final class OnEmailMessageDeletedSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailMessageDeleted($owner: ID!) {\n  onEmailMessageDeleted(owner: $owner) {\n    __typename\n    ...SealedEmailMessage\n  }\n}"

  internal static var requestString: String { return operationString.appending(SealedEmailMessage.fragmentString) }

  internal var owner: GraphQLID

  internal init(owner: GraphQLID) {
    self.owner = owner
  }

  internal var variables: GraphQLMap? {
    return ["owner": owner]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Subscription"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("onEmailMessageDeleted", arguments: ["owner": GraphQLVariable("owner")], type: .object(OnEmailMessageDeleted.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(onEmailMessageDeleted: OnEmailMessageDeleted? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onEmailMessageDeleted": onEmailMessageDeleted.flatMap { $0.snapshot }])
    }

    internal var onEmailMessageDeleted: OnEmailMessageDeleted? {
      get {
        return (snapshot["onEmailMessageDeleted"] as? Snapshot).flatMap { OnEmailMessageDeleted(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onEmailMessageDeleted")
      }
    }

    internal struct OnEmailMessageDeleted: GraphQLSelectionSet {
      internal static let possibleTypes = ["SealedEmailMessage"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("sortDateEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("folderId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("previousFolderId", type: .scalar(GraphQLID.self)),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("repliedTo", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("forwarded", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("rfc822Header", type: .nonNull(.object(Rfc822Header.selections))),
        GraphQLField("size", type: .nonNull(.scalar(Double.self))),
        GraphQLField("encryptionStatus", type: .scalar(EmailMessageEncryptionStatus.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, sortDateEpochMs: Double, folderId: GraphQLID, previousFolderId: GraphQLID? = nil, direction: EmailMessageDirection, seen: Bool, repliedTo: Bool, forwarded: Bool, state: EmailMessageState, clientRefId: String? = nil, rfc822Header: Rfc822Header, size: Double, encryptionStatus: EmailMessageEncryptionStatus? = nil) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "sortDateEpochMs": sortDateEpochMs, "folderId": folderId, "previousFolderId": previousFolderId, "direction": direction, "seen": seen, "repliedTo": repliedTo, "forwarded": forwarded, "state": state, "clientRefId": clientRefId, "rfc822Header": rfc822Header.snapshot, "size": size, "encryptionStatus": encryptionStatus])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      internal var emailAddressId: GraphQLID {
        get {
          return snapshot["emailAddressId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddressId")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var sortDateEpochMs: Double {
        get {
          return snapshot["sortDateEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "sortDateEpochMs")
        }
      }

      internal var folderId: GraphQLID {
        get {
          return snapshot["folderId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "folderId")
        }
      }

      internal var previousFolderId: GraphQLID? {
        get {
          return snapshot["previousFolderId"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "previousFolderId")
        }
      }

      internal var direction: EmailMessageDirection {
        get {
          return snapshot["direction"]! as! EmailMessageDirection
        }
        set {
          snapshot.updateValue(newValue, forKey: "direction")
        }
      }

      internal var seen: Bool {
        get {
          return snapshot["seen"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "seen")
        }
      }

      internal var repliedTo: Bool {
        get {
          return snapshot["repliedTo"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "repliedTo")
        }
      }

      internal var forwarded: Bool {
        get {
          return snapshot["forwarded"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "forwarded")
        }
      }

      internal var state: EmailMessageState {
        get {
          return snapshot["state"]! as! EmailMessageState
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      internal var clientRefId: String? {
        get {
          return snapshot["clientRefId"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "clientRefId")
        }
      }

      internal var rfc822Header: Rfc822Header {
        get {
          return Rfc822Header(snapshot: snapshot["rfc822Header"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "rfc822Header")
        }
      }

      internal var size: Double {
        get {
          return snapshot["size"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "size")
        }
      }

      internal var encryptionStatus: EmailMessageEncryptionStatus? {
        get {
          return snapshot["encryptionStatus"] as? EmailMessageEncryptionStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "encryptionStatus")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var sealedEmailMessage: SealedEmailMessage {
          get {
            return SealedEmailMessage(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Owner: GraphQLSelectionSet {
        internal static let possibleTypes = ["Owner"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: String, issuer: String) {
          self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var issuer: String {
          get {
            return snapshot["issuer"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "issuer")
          }
        }
      }

      internal struct Rfc822Header: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedAttribute"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
          GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
          self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var plainTextType: String {
          get {
            return snapshot["plainTextType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "plainTextType")
          }
        }

        internal var base64EncodedSealedData: String {
          get {
            return snapshot["base64EncodedSealedData"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
          }
        }
      }
    }
  }
}

internal final class OnEmailMessageDeletedWithIdSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailMessageDeletedWithId($owner: ID!, $id: ID!) {\n  onEmailMessageDeleted(owner: $owner, id: $id) {\n    __typename\n    ...SealedEmailMessage\n  }\n}"

  internal static var requestString: String { return operationString.appending(SealedEmailMessage.fragmentString) }

  internal var owner: GraphQLID
  internal var id: GraphQLID

  internal init(owner: GraphQLID, id: GraphQLID) {
    self.owner = owner
    self.id = id
  }

  internal var variables: GraphQLMap? {
    return ["owner": owner, "id": id]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Subscription"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("onEmailMessageDeleted", arguments: ["owner": GraphQLVariable("owner"), "id": GraphQLVariable("id")], type: .object(OnEmailMessageDeleted.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(onEmailMessageDeleted: OnEmailMessageDeleted? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onEmailMessageDeleted": onEmailMessageDeleted.flatMap { $0.snapshot }])
    }

    internal var onEmailMessageDeleted: OnEmailMessageDeleted? {
      get {
        return (snapshot["onEmailMessageDeleted"] as? Snapshot).flatMap { OnEmailMessageDeleted(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onEmailMessageDeleted")
      }
    }

    internal struct OnEmailMessageDeleted: GraphQLSelectionSet {
      internal static let possibleTypes = ["SealedEmailMessage"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("sortDateEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("folderId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("previousFolderId", type: .scalar(GraphQLID.self)),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("repliedTo", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("forwarded", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("rfc822Header", type: .nonNull(.object(Rfc822Header.selections))),
        GraphQLField("size", type: .nonNull(.scalar(Double.self))),
        GraphQLField("encryptionStatus", type: .scalar(EmailMessageEncryptionStatus.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, sortDateEpochMs: Double, folderId: GraphQLID, previousFolderId: GraphQLID? = nil, direction: EmailMessageDirection, seen: Bool, repliedTo: Bool, forwarded: Bool, state: EmailMessageState, clientRefId: String? = nil, rfc822Header: Rfc822Header, size: Double, encryptionStatus: EmailMessageEncryptionStatus? = nil) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "sortDateEpochMs": sortDateEpochMs, "folderId": folderId, "previousFolderId": previousFolderId, "direction": direction, "seen": seen, "repliedTo": repliedTo, "forwarded": forwarded, "state": state, "clientRefId": clientRefId, "rfc822Header": rfc822Header.snapshot, "size": size, "encryptionStatus": encryptionStatus])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      internal var emailAddressId: GraphQLID {
        get {
          return snapshot["emailAddressId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddressId")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var sortDateEpochMs: Double {
        get {
          return snapshot["sortDateEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "sortDateEpochMs")
        }
      }

      internal var folderId: GraphQLID {
        get {
          return snapshot["folderId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "folderId")
        }
      }

      internal var previousFolderId: GraphQLID? {
        get {
          return snapshot["previousFolderId"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "previousFolderId")
        }
      }

      internal var direction: EmailMessageDirection {
        get {
          return snapshot["direction"]! as! EmailMessageDirection
        }
        set {
          snapshot.updateValue(newValue, forKey: "direction")
        }
      }

      internal var seen: Bool {
        get {
          return snapshot["seen"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "seen")
        }
      }

      internal var repliedTo: Bool {
        get {
          return snapshot["repliedTo"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "repliedTo")
        }
      }

      internal var forwarded: Bool {
        get {
          return snapshot["forwarded"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "forwarded")
        }
      }

      internal var state: EmailMessageState {
        get {
          return snapshot["state"]! as! EmailMessageState
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      internal var clientRefId: String? {
        get {
          return snapshot["clientRefId"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "clientRefId")
        }
      }

      internal var rfc822Header: Rfc822Header {
        get {
          return Rfc822Header(snapshot: snapshot["rfc822Header"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "rfc822Header")
        }
      }

      internal var size: Double {
        get {
          return snapshot["size"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "size")
        }
      }

      internal var encryptionStatus: EmailMessageEncryptionStatus? {
        get {
          return snapshot["encryptionStatus"] as? EmailMessageEncryptionStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "encryptionStatus")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var sealedEmailMessage: SealedEmailMessage {
          get {
            return SealedEmailMessage(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Owner: GraphQLSelectionSet {
        internal static let possibleTypes = ["Owner"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: String, issuer: String) {
          self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var issuer: String {
          get {
            return snapshot["issuer"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "issuer")
          }
        }
      }

      internal struct Rfc822Header: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedAttribute"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
          GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
          self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var plainTextType: String {
          get {
            return snapshot["plainTextType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "plainTextType")
          }
        }

        internal var base64EncodedSealedData: String {
          get {
            return snapshot["base64EncodedSealedData"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
          }
        }
      }
    }
  }
}

internal final class OnEmailMessageUpdatedSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailMessageUpdated($owner: ID!) {\n  onEmailMessageUpdated(owner: $owner) {\n    __typename\n    ...SealedEmailMessage\n  }\n}"

  internal static var requestString: String { return operationString.appending(SealedEmailMessage.fragmentString) }

  internal var owner: GraphQLID

  internal init(owner: GraphQLID) {
    self.owner = owner
  }

  internal var variables: GraphQLMap? {
    return ["owner": owner]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Subscription"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("onEmailMessageUpdated", arguments: ["owner": GraphQLVariable("owner")], type: .object(OnEmailMessageUpdated.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(onEmailMessageUpdated: OnEmailMessageUpdated? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onEmailMessageUpdated": onEmailMessageUpdated.flatMap { $0.snapshot }])
    }

    internal var onEmailMessageUpdated: OnEmailMessageUpdated? {
      get {
        return (snapshot["onEmailMessageUpdated"] as? Snapshot).flatMap { OnEmailMessageUpdated(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onEmailMessageUpdated")
      }
    }

    internal struct OnEmailMessageUpdated: GraphQLSelectionSet {
      internal static let possibleTypes = ["SealedEmailMessage"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("sortDateEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("folderId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("previousFolderId", type: .scalar(GraphQLID.self)),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("repliedTo", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("forwarded", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("rfc822Header", type: .nonNull(.object(Rfc822Header.selections))),
        GraphQLField("size", type: .nonNull(.scalar(Double.self))),
        GraphQLField("encryptionStatus", type: .scalar(EmailMessageEncryptionStatus.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, sortDateEpochMs: Double, folderId: GraphQLID, previousFolderId: GraphQLID? = nil, direction: EmailMessageDirection, seen: Bool, repliedTo: Bool, forwarded: Bool, state: EmailMessageState, clientRefId: String? = nil, rfc822Header: Rfc822Header, size: Double, encryptionStatus: EmailMessageEncryptionStatus? = nil) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "sortDateEpochMs": sortDateEpochMs, "folderId": folderId, "previousFolderId": previousFolderId, "direction": direction, "seen": seen, "repliedTo": repliedTo, "forwarded": forwarded, "state": state, "clientRefId": clientRefId, "rfc822Header": rfc822Header.snapshot, "size": size, "encryptionStatus": encryptionStatus])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      internal var emailAddressId: GraphQLID {
        get {
          return snapshot["emailAddressId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddressId")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var sortDateEpochMs: Double {
        get {
          return snapshot["sortDateEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "sortDateEpochMs")
        }
      }

      internal var folderId: GraphQLID {
        get {
          return snapshot["folderId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "folderId")
        }
      }

      internal var previousFolderId: GraphQLID? {
        get {
          return snapshot["previousFolderId"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "previousFolderId")
        }
      }

      internal var direction: EmailMessageDirection {
        get {
          return snapshot["direction"]! as! EmailMessageDirection
        }
        set {
          snapshot.updateValue(newValue, forKey: "direction")
        }
      }

      internal var seen: Bool {
        get {
          return snapshot["seen"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "seen")
        }
      }

      internal var repliedTo: Bool {
        get {
          return snapshot["repliedTo"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "repliedTo")
        }
      }

      internal var forwarded: Bool {
        get {
          return snapshot["forwarded"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "forwarded")
        }
      }

      internal var state: EmailMessageState {
        get {
          return snapshot["state"]! as! EmailMessageState
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      internal var clientRefId: String? {
        get {
          return snapshot["clientRefId"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "clientRefId")
        }
      }

      internal var rfc822Header: Rfc822Header {
        get {
          return Rfc822Header(snapshot: snapshot["rfc822Header"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "rfc822Header")
        }
      }

      internal var size: Double {
        get {
          return snapshot["size"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "size")
        }
      }

      internal var encryptionStatus: EmailMessageEncryptionStatus? {
        get {
          return snapshot["encryptionStatus"] as? EmailMessageEncryptionStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "encryptionStatus")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var sealedEmailMessage: SealedEmailMessage {
          get {
            return SealedEmailMessage(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Owner: GraphQLSelectionSet {
        internal static let possibleTypes = ["Owner"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: String, issuer: String) {
          self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var issuer: String {
          get {
            return snapshot["issuer"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "issuer")
          }
        }
      }

      internal struct Rfc822Header: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedAttribute"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
          GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
          self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var plainTextType: String {
          get {
            return snapshot["plainTextType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "plainTextType")
          }
        }

        internal var base64EncodedSealedData: String {
          get {
            return snapshot["base64EncodedSealedData"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
          }
        }
      }
    }
  }
}

internal final class OnEmailMessageUpdatedWithIdSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailMessageUpdatedWithId($owner: ID!, $id: ID!) {\n  onEmailMessageUpdated(owner: $owner, id: $id) {\n    __typename\n    ...SealedEmailMessage\n  }\n}"

  internal static var requestString: String { return operationString.appending(SealedEmailMessage.fragmentString) }

  internal var owner: GraphQLID
  internal var id: GraphQLID

  internal init(owner: GraphQLID, id: GraphQLID) {
    self.owner = owner
    self.id = id
  }

  internal var variables: GraphQLMap? {
    return ["owner": owner, "id": id]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Subscription"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("onEmailMessageUpdated", arguments: ["owner": GraphQLVariable("owner"), "id": GraphQLVariable("id")], type: .object(OnEmailMessageUpdated.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(onEmailMessageUpdated: OnEmailMessageUpdated? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onEmailMessageUpdated": onEmailMessageUpdated.flatMap { $0.snapshot }])
    }

    internal var onEmailMessageUpdated: OnEmailMessageUpdated? {
      get {
        return (snapshot["onEmailMessageUpdated"] as? Snapshot).flatMap { OnEmailMessageUpdated(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onEmailMessageUpdated")
      }
    }

    internal struct OnEmailMessageUpdated: GraphQLSelectionSet {
      internal static let possibleTypes = ["SealedEmailMessage"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("sortDateEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("folderId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("previousFolderId", type: .scalar(GraphQLID.self)),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("repliedTo", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("forwarded", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("rfc822Header", type: .nonNull(.object(Rfc822Header.selections))),
        GraphQLField("size", type: .nonNull(.scalar(Double.self))),
        GraphQLField("encryptionStatus", type: .scalar(EmailMessageEncryptionStatus.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, sortDateEpochMs: Double, folderId: GraphQLID, previousFolderId: GraphQLID? = nil, direction: EmailMessageDirection, seen: Bool, repliedTo: Bool, forwarded: Bool, state: EmailMessageState, clientRefId: String? = nil, rfc822Header: Rfc822Header, size: Double, encryptionStatus: EmailMessageEncryptionStatus? = nil) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "sortDateEpochMs": sortDateEpochMs, "folderId": folderId, "previousFolderId": previousFolderId, "direction": direction, "seen": seen, "repliedTo": repliedTo, "forwarded": forwarded, "state": state, "clientRefId": clientRefId, "rfc822Header": rfc822Header.snapshot, "size": size, "encryptionStatus": encryptionStatus])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      internal var emailAddressId: GraphQLID {
        get {
          return snapshot["emailAddressId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddressId")
        }
      }

      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }

      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      internal var sortDateEpochMs: Double {
        get {
          return snapshot["sortDateEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "sortDateEpochMs")
        }
      }

      internal var folderId: GraphQLID {
        get {
          return snapshot["folderId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "folderId")
        }
      }

      internal var previousFolderId: GraphQLID? {
        get {
          return snapshot["previousFolderId"] as? GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "previousFolderId")
        }
      }

      internal var direction: EmailMessageDirection {
        get {
          return snapshot["direction"]! as! EmailMessageDirection
        }
        set {
          snapshot.updateValue(newValue, forKey: "direction")
        }
      }

      internal var seen: Bool {
        get {
          return snapshot["seen"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "seen")
        }
      }

      internal var repliedTo: Bool {
        get {
          return snapshot["repliedTo"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "repliedTo")
        }
      }

      internal var forwarded: Bool {
        get {
          return snapshot["forwarded"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "forwarded")
        }
      }

      internal var state: EmailMessageState {
        get {
          return snapshot["state"]! as! EmailMessageState
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      internal var clientRefId: String? {
        get {
          return snapshot["clientRefId"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "clientRefId")
        }
      }

      internal var rfc822Header: Rfc822Header {
        get {
          return Rfc822Header(snapshot: snapshot["rfc822Header"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "rfc822Header")
        }
      }

      internal var size: Double {
        get {
          return snapshot["size"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "size")
        }
      }

      internal var encryptionStatus: EmailMessageEncryptionStatus? {
        get {
          return snapshot["encryptionStatus"] as? EmailMessageEncryptionStatus
        }
        set {
          snapshot.updateValue(newValue, forKey: "encryptionStatus")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var sealedEmailMessage: SealedEmailMessage {
          get {
            return SealedEmailMessage(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }

      internal struct Owner: GraphQLSelectionSet {
        internal static let possibleTypes = ["Owner"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(String.self))),
          GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: String, issuer: String) {
          self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var id: String {
          get {
            return snapshot["id"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        internal var issuer: String {
          get {
            return snapshot["issuer"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "issuer")
          }
        }
      }

      internal struct Rfc822Header: GraphQLSelectionSet {
        internal static let possibleTypes = ["SealedAttribute"]

        internal static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
          GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
          self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        internal var plainTextType: String {
          get {
            return snapshot["plainTextType"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "plainTextType")
          }
        }

        internal var base64EncodedSealedData: String {
          get {
            return snapshot["base64EncodedSealedData"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
          }
        }
      }
    }
  }
}

internal struct BlockedAddress: GraphQLFragment {
  internal static let fragmentString =
    "fragment BlockedAddress on BlockedEmailAddress {\n  __typename\n  owner\n  owners {\n    __typename\n    id\n    issuer\n  }\n  version\n  createdAtEpochMs\n  updatedAtEpochMs\n  hashAlgorithm\n  hashedBlockedValue\n  sealedValue {\n    __typename\n    ...SealedAttribute\n  }\n  action\n  emailAddressId\n}"

  internal static let possibleTypes = ["BlockedEmailAddress"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
    GraphQLField("version", type: .nonNull(.scalar(Int.self))),
    GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("hashAlgorithm", type: .nonNull(.scalar(BlockedAddressHashAlgorithm.self))),
    GraphQLField("hashedBlockedValue", type: .nonNull(.scalar(String.self))),
    GraphQLField("sealedValue", type: .nonNull(.object(SealedValue.selections))),
    GraphQLField("action", type: .scalar(BlockedAddressAction.self)),
    GraphQLField("emailAddressId", type: .scalar(String.self)),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(owner: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, hashAlgorithm: BlockedAddressHashAlgorithm, hashedBlockedValue: String, sealedValue: SealedValue, action: BlockedAddressAction? = nil, emailAddressId: String? = nil) {
    self.init(snapshot: ["__typename": "BlockedEmailAddress", "owner": owner, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "hashAlgorithm": hashAlgorithm, "hashedBlockedValue": hashedBlockedValue, "sealedValue": sealedValue.snapshot, "action": action, "emailAddressId": emailAddressId])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var owner: GraphQLID {
    get {
      return snapshot["owner"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "owner")
    }
  }

  internal var owners: [Owner] {
    get {
      return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
    }
  }

  internal var version: Int {
    get {
      return snapshot["version"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "version")
    }
  }

  internal var createdAtEpochMs: Double {
    get {
      return snapshot["createdAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
    }
  }

  internal var updatedAtEpochMs: Double {
    get {
      return snapshot["updatedAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
    }
  }

  internal var hashAlgorithm: BlockedAddressHashAlgorithm {
    get {
      return snapshot["hashAlgorithm"]! as! BlockedAddressHashAlgorithm
    }
    set {
      snapshot.updateValue(newValue, forKey: "hashAlgorithm")
    }
  }

  internal var hashedBlockedValue: String {
    get {
      return snapshot["hashedBlockedValue"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "hashedBlockedValue")
    }
  }

  internal var sealedValue: SealedValue {
    get {
      return SealedValue(snapshot: snapshot["sealedValue"]! as! Snapshot)
    }
    set {
      snapshot.updateValue(newValue.snapshot, forKey: "sealedValue")
    }
  }

  internal var action: BlockedAddressAction? {
    get {
      return snapshot["action"] as? BlockedAddressAction
    }
    set {
      snapshot.updateValue(newValue, forKey: "action")
    }
  }

  internal var emailAddressId: String? {
    get {
      return snapshot["emailAddressId"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "emailAddressId")
    }
  }

  internal struct Owner: GraphQLSelectionSet {
    internal static let possibleTypes = ["Owner"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(String.self))),
      GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(id: String, issuer: String) {
      self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var id: String {
      get {
        return snapshot["id"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "id")
      }
    }

    internal var issuer: String {
      get {
        return snapshot["issuer"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "issuer")
      }
    }
  }

  internal struct SealedValue: GraphQLSelectionSet {
    internal static let possibleTypes = ["SealedAttribute"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
      GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
      GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
      GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
      self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var algorithm: String {
      get {
        return snapshot["algorithm"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "algorithm")
      }
    }

    internal var keyId: String {
      get {
        return snapshot["keyId"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "keyId")
      }
    }

    internal var plainTextType: String {
      get {
        return snapshot["plainTextType"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "plainTextType")
      }
    }

    internal var base64EncodedSealedData: String {
      get {
        return snapshot["base64EncodedSealedData"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
      }
    }

    internal var fragments: Fragments {
      get {
        return Fragments(snapshot: snapshot)
      }
      set {
        snapshot += newValue.snapshot
      }
    }

    internal struct Fragments {
      internal var snapshot: Snapshot

      internal var sealedAttribute: SealedAttribute {
        get {
          return SealedAttribute(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }
    }
  }
}

internal struct BlockAddressesResult: GraphQLFragment {
  internal static let fragmentString =
    "fragment BlockAddressesResult on BlockEmailAddressesBulkUpdateResult {\n  __typename\n  status\n  failedAddresses\n  successAddresses\n}"

  internal static let possibleTypes = ["BlockEmailAddressesBulkUpdateResult"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("status", type: .nonNull(.scalar(UpdateBlockedAddressesStatus.self))),
    GraphQLField("failedAddresses", type: .list(.nonNull(.scalar(String.self)))),
    GraphQLField("successAddresses", type: .list(.nonNull(.scalar(String.self)))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(status: UpdateBlockedAddressesStatus, failedAddresses: [String]? = nil, successAddresses: [String]? = nil) {
    self.init(snapshot: ["__typename": "BlockEmailAddressesBulkUpdateResult", "status": status, "failedAddresses": failedAddresses, "successAddresses": successAddresses])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var status: UpdateBlockedAddressesStatus {
    get {
      return snapshot["status"]! as! UpdateBlockedAddressesStatus
    }
    set {
      snapshot.updateValue(newValue, forKey: "status")
    }
  }

  internal var failedAddresses: [String]? {
    get {
      return snapshot["failedAddresses"] as? [String]
    }
    set {
      snapshot.updateValue(newValue, forKey: "failedAddresses")
    }
  }

  internal var successAddresses: [String]? {
    get {
      return snapshot["successAddresses"] as? [String]
    }
    set {
      snapshot.updateValue(newValue, forKey: "successAddresses")
    }
  }
}

internal struct GetEmailAddressBlocklistResponse: GraphQLFragment {
  internal static let fragmentString =
    "fragment GetEmailAddressBlocklistResponse on GetEmailAddressBlocklistResponse {\n  __typename\n  blockedAddresses {\n    __typename\n    sealedValue {\n      __typename\n      ...SealedAttribute\n    }\n    hashedBlockedValue\n    action\n    emailAddressId\n  }\n}"

  internal static let possibleTypes = ["GetEmailAddressBlocklistResponse"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("blockedAddresses", type: .nonNull(.list(.nonNull(.object(BlockedAddress.selections))))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(blockedAddresses: [BlockedAddress]) {
    self.init(snapshot: ["__typename": "GetEmailAddressBlocklistResponse", "blockedAddresses": blockedAddresses.map { $0.snapshot }])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var blockedAddresses: [BlockedAddress] {
    get {
      return (snapshot["blockedAddresses"] as! [Snapshot]).map { BlockedAddress(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "blockedAddresses")
    }
  }

  internal struct BlockedAddress: GraphQLSelectionSet {
    internal static let possibleTypes = ["BlockedEmailAddress"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("sealedValue", type: .nonNull(.object(SealedValue.selections))),
      GraphQLField("hashedBlockedValue", type: .nonNull(.scalar(String.self))),
      GraphQLField("action", type: .scalar(BlockedAddressAction.self)),
      GraphQLField("emailAddressId", type: .scalar(String.self)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(sealedValue: SealedValue, hashedBlockedValue: String, action: BlockedAddressAction? = nil, emailAddressId: String? = nil) {
      self.init(snapshot: ["__typename": "BlockedEmailAddress", "sealedValue": sealedValue.snapshot, "hashedBlockedValue": hashedBlockedValue, "action": action, "emailAddressId": emailAddressId])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var sealedValue: SealedValue {
      get {
        return SealedValue(snapshot: snapshot["sealedValue"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "sealedValue")
      }
    }

    internal var hashedBlockedValue: String {
      get {
        return snapshot["hashedBlockedValue"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "hashedBlockedValue")
      }
    }

    internal var action: BlockedAddressAction? {
      get {
        return snapshot["action"] as? BlockedAddressAction
      }
      set {
        snapshot.updateValue(newValue, forKey: "action")
      }
    }

    internal var emailAddressId: String? {
      get {
        return snapshot["emailAddressId"] as? String
      }
      set {
        snapshot.updateValue(newValue, forKey: "emailAddressId")
      }
    }

    internal struct SealedValue: GraphQLSelectionSet {
      internal static let possibleTypes = ["SealedAttribute"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
        GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
        self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var algorithm: String {
        get {
          return snapshot["algorithm"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "algorithm")
        }
      }

      internal var keyId: String {
        get {
          return snapshot["keyId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyId")
        }
      }

      internal var plainTextType: String {
        get {
          return snapshot["plainTextType"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "plainTextType")
        }
      }

      internal var base64EncodedSealedData: String {
        get {
          return snapshot["base64EncodedSealedData"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var sealedAttribute: SealedAttribute {
          get {
            return SealedAttribute(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal struct EmailAddressWithoutFolders: GraphQLFragment {
  internal static let fragmentString =
    "fragment EmailAddressWithoutFolders on EmailAddress {\n  __typename\n  id\n  owner\n  owners {\n    __typename\n    id\n    issuer\n  }\n  identityId\n  keyRingId\n  keyIds\n  version\n  createdAtEpochMs\n  updatedAtEpochMs\n  lastReceivedAtEpochMs\n  emailAddress\n  size\n  numberOfEmailMessages\n  alias {\n    __typename\n    ...SealedAttribute\n  }\n}"

  internal static let possibleTypes = ["EmailAddress"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
    GraphQLField("identityId", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("keyRingId", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("keyIds", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
    GraphQLField("version", type: .nonNull(.scalar(Int.self))),
    GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("lastReceivedAtEpochMs", type: .scalar(Double.self)),
    GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
    GraphQLField("size", type: .nonNull(.scalar(Double.self))),
    GraphQLField("numberOfEmailMessages", type: .nonNull(.scalar(Int.self))),
    GraphQLField("alias", type: .object(Alias.selections)),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], identityId: GraphQLID, keyRingId: GraphQLID, keyIds: [String], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, lastReceivedAtEpochMs: Double? = nil, emailAddress: String, size: Double, numberOfEmailMessages: Int, alias: Alias? = nil) {
    self.init(snapshot: ["__typename": "EmailAddress", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "identityId": identityId, "keyRingId": keyRingId, "keyIds": keyIds, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "lastReceivedAtEpochMs": lastReceivedAtEpochMs, "emailAddress": emailAddress, "size": size, "numberOfEmailMessages": numberOfEmailMessages, "alias": alias.flatMap { $0.snapshot }])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var id: GraphQLID {
    get {
      return snapshot["id"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  internal var owner: GraphQLID {
    get {
      return snapshot["owner"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "owner")
    }
  }

  internal var owners: [Owner] {
    get {
      return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
    }
  }

  internal var identityId: GraphQLID {
    get {
      return snapshot["identityId"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "identityId")
    }
  }

  internal var keyRingId: GraphQLID {
    get {
      return snapshot["keyRingId"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "keyRingId")
    }
  }

  internal var keyIds: [String] {
    get {
      return snapshot["keyIds"]! as! [String]
    }
    set {
      snapshot.updateValue(newValue, forKey: "keyIds")
    }
  }

  internal var version: Int {
    get {
      return snapshot["version"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "version")
    }
  }

  internal var createdAtEpochMs: Double {
    get {
      return snapshot["createdAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
    }
  }

  internal var updatedAtEpochMs: Double {
    get {
      return snapshot["updatedAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
    }
  }

  internal var lastReceivedAtEpochMs: Double? {
    get {
      return snapshot["lastReceivedAtEpochMs"] as? Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "lastReceivedAtEpochMs")
    }
  }

  internal var emailAddress: String {
    get {
      return snapshot["emailAddress"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "emailAddress")
    }
  }

  internal var size: Double {
    get {
      return snapshot["size"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "size")
    }
  }

  internal var numberOfEmailMessages: Int {
    get {
      return snapshot["numberOfEmailMessages"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "numberOfEmailMessages")
    }
  }

  internal var alias: Alias? {
    get {
      return (snapshot["alias"] as? Snapshot).flatMap { Alias(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue?.snapshot, forKey: "alias")
    }
  }

  internal struct Owner: GraphQLSelectionSet {
    internal static let possibleTypes = ["Owner"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(String.self))),
      GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(id: String, issuer: String) {
      self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var id: String {
      get {
        return snapshot["id"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "id")
      }
    }

    internal var issuer: String {
      get {
        return snapshot["issuer"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "issuer")
      }
    }
  }

  internal struct Alias: GraphQLSelectionSet {
    internal static let possibleTypes = ["SealedAttribute"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
      GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
      GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
      GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
      self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var algorithm: String {
      get {
        return snapshot["algorithm"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "algorithm")
      }
    }

    internal var keyId: String {
      get {
        return snapshot["keyId"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "keyId")
      }
    }

    internal var plainTextType: String {
      get {
        return snapshot["plainTextType"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "plainTextType")
      }
    }

    internal var base64EncodedSealedData: String {
      get {
        return snapshot["base64EncodedSealedData"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
      }
    }

    internal var fragments: Fragments {
      get {
        return Fragments(snapshot: snapshot)
      }
      set {
        snapshot += newValue.snapshot
      }
    }

    internal struct Fragments {
      internal var snapshot: Snapshot

      internal var sealedAttribute: SealedAttribute {
        get {
          return SealedAttribute(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }
    }
  }
}

internal struct EmailAddress: GraphQLFragment {
  internal static let fragmentString =
    "fragment EmailAddress on EmailAddress {\n  __typename\n  ...EmailAddressWithoutFolders\n  folders {\n    __typename\n    ...EmailFolder\n  }\n}"

  internal static let possibleTypes = ["EmailAddress"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
    GraphQLField("identityId", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("keyRingId", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("keyIds", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
    GraphQLField("version", type: .nonNull(.scalar(Int.self))),
    GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("lastReceivedAtEpochMs", type: .scalar(Double.self)),
    GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
    GraphQLField("size", type: .nonNull(.scalar(Double.self))),
    GraphQLField("numberOfEmailMessages", type: .nonNull(.scalar(Int.self))),
    GraphQLField("alias", type: .object(Alias.selections)),
    GraphQLField("folders", type: .nonNull(.list(.nonNull(.object(Folder.selections))))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], identityId: GraphQLID, keyRingId: GraphQLID, keyIds: [String], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, lastReceivedAtEpochMs: Double? = nil, emailAddress: String, size: Double, numberOfEmailMessages: Int, alias: Alias? = nil, folders: [Folder]) {
    self.init(snapshot: ["__typename": "EmailAddress", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "identityId": identityId, "keyRingId": keyRingId, "keyIds": keyIds, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "lastReceivedAtEpochMs": lastReceivedAtEpochMs, "emailAddress": emailAddress, "size": size, "numberOfEmailMessages": numberOfEmailMessages, "alias": alias.flatMap { $0.snapshot }, "folders": folders.map { $0.snapshot }])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var id: GraphQLID {
    get {
      return snapshot["id"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  internal var owner: GraphQLID {
    get {
      return snapshot["owner"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "owner")
    }
  }

  internal var owners: [Owner] {
    get {
      return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
    }
  }

  internal var identityId: GraphQLID {
    get {
      return snapshot["identityId"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "identityId")
    }
  }

  internal var keyRingId: GraphQLID {
    get {
      return snapshot["keyRingId"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "keyRingId")
    }
  }

  internal var keyIds: [String] {
    get {
      return snapshot["keyIds"]! as! [String]
    }
    set {
      snapshot.updateValue(newValue, forKey: "keyIds")
    }
  }

  internal var version: Int {
    get {
      return snapshot["version"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "version")
    }
  }

  internal var createdAtEpochMs: Double {
    get {
      return snapshot["createdAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
    }
  }

  internal var updatedAtEpochMs: Double {
    get {
      return snapshot["updatedAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
    }
  }

  internal var lastReceivedAtEpochMs: Double? {
    get {
      return snapshot["lastReceivedAtEpochMs"] as? Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "lastReceivedAtEpochMs")
    }
  }

  internal var emailAddress: String {
    get {
      return snapshot["emailAddress"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "emailAddress")
    }
  }

  internal var size: Double {
    get {
      return snapshot["size"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "size")
    }
  }

  internal var numberOfEmailMessages: Int {
    get {
      return snapshot["numberOfEmailMessages"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "numberOfEmailMessages")
    }
  }

  internal var alias: Alias? {
    get {
      return (snapshot["alias"] as? Snapshot).flatMap { Alias(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue?.snapshot, forKey: "alias")
    }
  }

  internal var folders: [Folder] {
    get {
      return (snapshot["folders"] as! [Snapshot]).map { Folder(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "folders")
    }
  }

  internal var fragments: Fragments {
    get {
      return Fragments(snapshot: snapshot)
    }
    set {
      snapshot += newValue.snapshot
    }
  }

  internal struct Fragments {
    internal var snapshot: Snapshot

    internal var emailAddressWithoutFolders: EmailAddressWithoutFolders {
      get {
        return EmailAddressWithoutFolders(snapshot: snapshot)
      }
      set {
        snapshot += newValue.snapshot
      }
    }
  }

  internal struct Owner: GraphQLSelectionSet {
    internal static let possibleTypes = ["Owner"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(String.self))),
      GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(id: String, issuer: String) {
      self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var id: String {
      get {
        return snapshot["id"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "id")
      }
    }

    internal var issuer: String {
      get {
        return snapshot["issuer"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "issuer")
      }
    }
  }

  internal struct Alias: GraphQLSelectionSet {
    internal static let possibleTypes = ["SealedAttribute"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
      GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
      GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
      GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
      self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var algorithm: String {
      get {
        return snapshot["algorithm"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "algorithm")
      }
    }

    internal var keyId: String {
      get {
        return snapshot["keyId"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "keyId")
      }
    }

    internal var plainTextType: String {
      get {
        return snapshot["plainTextType"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "plainTextType")
      }
    }

    internal var base64EncodedSealedData: String {
      get {
        return snapshot["base64EncodedSealedData"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
      }
    }

    internal var fragments: Fragments {
      get {
        return Fragments(snapshot: snapshot)
      }
      set {
        snapshot += newValue.snapshot
      }
    }

    internal struct Fragments {
      internal var snapshot: Snapshot

      internal var sealedAttribute: SealedAttribute {
        get {
          return SealedAttribute(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }
    }
  }

  internal struct Folder: GraphQLSelectionSet {
    internal static let possibleTypes = ["EmailFolder"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
      GraphQLField("version", type: .nonNull(.scalar(Int.self))),
      GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
      GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
      GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("folderName", type: .nonNull(.scalar(String.self))),
      GraphQLField("size", type: .nonNull(.scalar(Double.self))),
      GraphQLField("unseenCount", type: .nonNull(.scalar(Double.self))),
      GraphQLField("ttl", type: .scalar(Double.self)),
      GraphQLField("customFolderName", type: .object(CustomFolderName.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddressId: GraphQLID, folderName: String, size: Double, unseenCount: Double, ttl: Double? = nil, customFolderName: CustomFolderName? = nil) {
      self.init(snapshot: ["__typename": "EmailFolder", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddressId": emailAddressId, "folderName": folderName, "size": size, "unseenCount": unseenCount, "ttl": ttl, "customFolderName": customFolderName.flatMap { $0.snapshot }])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var id: GraphQLID {
      get {
        return snapshot["id"]! as! GraphQLID
      }
      set {
        snapshot.updateValue(newValue, forKey: "id")
      }
    }

    internal var owner: GraphQLID {
      get {
        return snapshot["owner"]! as! GraphQLID
      }
      set {
        snapshot.updateValue(newValue, forKey: "owner")
      }
    }

    internal var owners: [Owner] {
      get {
        return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
      }
    }

    internal var version: Int {
      get {
        return snapshot["version"]! as! Int
      }
      set {
        snapshot.updateValue(newValue, forKey: "version")
      }
    }

    internal var createdAtEpochMs: Double {
      get {
        return snapshot["createdAtEpochMs"]! as! Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
      }
    }

    internal var updatedAtEpochMs: Double {
      get {
        return snapshot["updatedAtEpochMs"]! as! Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
      }
    }

    internal var emailAddressId: GraphQLID {
      get {
        return snapshot["emailAddressId"]! as! GraphQLID
      }
      set {
        snapshot.updateValue(newValue, forKey: "emailAddressId")
      }
    }

    internal var folderName: String {
      get {
        return snapshot["folderName"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "folderName")
      }
    }

    internal var size: Double {
      get {
        return snapshot["size"]! as! Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "size")
      }
    }

    internal var unseenCount: Double {
      get {
        return snapshot["unseenCount"]! as! Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "unseenCount")
      }
    }

    internal var ttl: Double? {
      get {
        return snapshot["ttl"] as? Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "ttl")
      }
    }

    internal var customFolderName: CustomFolderName? {
      get {
        return (snapshot["customFolderName"] as? Snapshot).flatMap { CustomFolderName(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "customFolderName")
      }
    }

    internal var fragments: Fragments {
      get {
        return Fragments(snapshot: snapshot)
      }
      set {
        snapshot += newValue.snapshot
      }
    }

    internal struct Fragments {
      internal var snapshot: Snapshot

      internal var emailFolder: EmailFolder {
        get {
          return EmailFolder(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }
    }

    internal struct Owner: GraphQLSelectionSet {
      internal static let possibleTypes = ["Owner"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
        GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: String, issuer: String) {
        self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var id: String {
        get {
          return snapshot["id"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      internal var issuer: String {
        get {
          return snapshot["issuer"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "issuer")
        }
      }
    }

    internal struct CustomFolderName: GraphQLSelectionSet {
      internal static let possibleTypes = ["SealedAttribute"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
        GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
        self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      internal var algorithm: String {
        get {
          return snapshot["algorithm"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "algorithm")
        }
      }

      internal var keyId: String {
        get {
          return snapshot["keyId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyId")
        }
      }

      internal var plainTextType: String {
        get {
          return snapshot["plainTextType"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "plainTextType")
        }
      }

      internal var base64EncodedSealedData: String {
        get {
          return snapshot["base64EncodedSealedData"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
        }
      }

      internal var fragments: Fragments {
        get {
          return Fragments(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }

      internal struct Fragments {
        internal var snapshot: Snapshot

        internal var sealedAttribute: SealedAttribute {
          get {
            return SealedAttribute(snapshot: snapshot)
          }
          set {
            snapshot += newValue.snapshot
          }
        }
      }
    }
  }
}

internal struct EmailAddressPublicInfo: GraphQLFragment {
  internal static let fragmentString =
    "fragment EmailAddressPublicInfo on EmailAddressPublicInfo {\n  __typename\n  emailAddress\n  keyId\n  publicKey\n}"

  internal static let possibleTypes = ["EmailAddressPublicInfo"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
    GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
    GraphQLField("publicKey", type: .nonNull(.scalar(String.self))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(emailAddress: String, keyId: String, publicKey: String) {
    self.init(snapshot: ["__typename": "EmailAddressPublicInfo", "emailAddress": emailAddress, "keyId": keyId, "publicKey": publicKey])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var emailAddress: String {
    get {
      return snapshot["emailAddress"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "emailAddress")
    }
  }

  internal var keyId: String {
    get {
      return snapshot["keyId"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "keyId")
    }
  }

  internal var publicKey: String {
    get {
      return snapshot["publicKey"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "publicKey")
    }
  }
}

internal struct EmailConfigurationData: GraphQLFragment {
  internal static let fragmentString =
    "fragment EmailConfigurationData on EmailConfigurationData {\n  __typename\n  deleteEmailMessagesLimit\n  updateEmailMessagesLimit\n  emailMessageMaxInboundMessageSize\n  emailMessageMaxOutboundMessageSize\n  emailMessageRecipientsLimit\n  encryptedEmailMessageRecipientsLimit\n}"

  internal static let possibleTypes = ["EmailConfigurationData"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("deleteEmailMessagesLimit", type: .nonNull(.scalar(Int.self))),
    GraphQLField("updateEmailMessagesLimit", type: .nonNull(.scalar(Int.self))),
    GraphQLField("emailMessageMaxInboundMessageSize", type: .nonNull(.scalar(Int.self))),
    GraphQLField("emailMessageMaxOutboundMessageSize", type: .nonNull(.scalar(Int.self))),
    GraphQLField("emailMessageRecipientsLimit", type: .nonNull(.scalar(Int.self))),
    GraphQLField("encryptedEmailMessageRecipientsLimit", type: .nonNull(.scalar(Int.self))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(deleteEmailMessagesLimit: Int, updateEmailMessagesLimit: Int, emailMessageMaxInboundMessageSize: Int, emailMessageMaxOutboundMessageSize: Int, emailMessageRecipientsLimit: Int, encryptedEmailMessageRecipientsLimit: Int) {
    self.init(snapshot: ["__typename": "EmailConfigurationData", "deleteEmailMessagesLimit": deleteEmailMessagesLimit, "updateEmailMessagesLimit": updateEmailMessagesLimit, "emailMessageMaxInboundMessageSize": emailMessageMaxInboundMessageSize, "emailMessageMaxOutboundMessageSize": emailMessageMaxOutboundMessageSize, "emailMessageRecipientsLimit": emailMessageRecipientsLimit, "encryptedEmailMessageRecipientsLimit": encryptedEmailMessageRecipientsLimit])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var deleteEmailMessagesLimit: Int {
    get {
      return snapshot["deleteEmailMessagesLimit"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "deleteEmailMessagesLimit")
    }
  }

  internal var updateEmailMessagesLimit: Int {
    get {
      return snapshot["updateEmailMessagesLimit"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "updateEmailMessagesLimit")
    }
  }

  internal var emailMessageMaxInboundMessageSize: Int {
    get {
      return snapshot["emailMessageMaxInboundMessageSize"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "emailMessageMaxInboundMessageSize")
    }
  }

  internal var emailMessageMaxOutboundMessageSize: Int {
    get {
      return snapshot["emailMessageMaxOutboundMessageSize"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "emailMessageMaxOutboundMessageSize")
    }
  }

  internal var emailMessageRecipientsLimit: Int {
    get {
      return snapshot["emailMessageRecipientsLimit"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "emailMessageRecipientsLimit")
    }
  }

  internal var encryptedEmailMessageRecipientsLimit: Int {
    get {
      return snapshot["encryptedEmailMessageRecipientsLimit"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "encryptedEmailMessageRecipientsLimit")
    }
  }
}

internal struct EmailFolder: GraphQLFragment {
  internal static let fragmentString =
    "fragment EmailFolder on EmailFolder {\n  __typename\n  id\n  owner\n  owners {\n    __typename\n    id\n    issuer\n  }\n  version\n  createdAtEpochMs\n  updatedAtEpochMs\n  emailAddressId\n  folderName\n  size\n  unseenCount\n  ttl\n  customFolderName {\n    __typename\n    ...SealedAttribute\n  }\n}"

  internal static let possibleTypes = ["EmailFolder"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
    GraphQLField("version", type: .nonNull(.scalar(Int.self))),
    GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("folderName", type: .nonNull(.scalar(String.self))),
    GraphQLField("size", type: .nonNull(.scalar(Double.self))),
    GraphQLField("unseenCount", type: .nonNull(.scalar(Double.self))),
    GraphQLField("ttl", type: .scalar(Double.self)),
    GraphQLField("customFolderName", type: .object(CustomFolderName.selections)),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddressId: GraphQLID, folderName: String, size: Double, unseenCount: Double, ttl: Double? = nil, customFolderName: CustomFolderName? = nil) {
    self.init(snapshot: ["__typename": "EmailFolder", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddressId": emailAddressId, "folderName": folderName, "size": size, "unseenCount": unseenCount, "ttl": ttl, "customFolderName": customFolderName.flatMap { $0.snapshot }])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var id: GraphQLID {
    get {
      return snapshot["id"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  internal var owner: GraphQLID {
    get {
      return snapshot["owner"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "owner")
    }
  }

  internal var owners: [Owner] {
    get {
      return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
    }
  }

  internal var version: Int {
    get {
      return snapshot["version"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "version")
    }
  }

  internal var createdAtEpochMs: Double {
    get {
      return snapshot["createdAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
    }
  }

  internal var updatedAtEpochMs: Double {
    get {
      return snapshot["updatedAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
    }
  }

  internal var emailAddressId: GraphQLID {
    get {
      return snapshot["emailAddressId"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "emailAddressId")
    }
  }

  internal var folderName: String {
    get {
      return snapshot["folderName"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "folderName")
    }
  }

  internal var size: Double {
    get {
      return snapshot["size"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "size")
    }
  }

  internal var unseenCount: Double {
    get {
      return snapshot["unseenCount"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "unseenCount")
    }
  }

  internal var ttl: Double? {
    get {
      return snapshot["ttl"] as? Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "ttl")
    }
  }

  internal var customFolderName: CustomFolderName? {
    get {
      return (snapshot["customFolderName"] as? Snapshot).flatMap { CustomFolderName(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue?.snapshot, forKey: "customFolderName")
    }
  }

  internal struct Owner: GraphQLSelectionSet {
    internal static let possibleTypes = ["Owner"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(String.self))),
      GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(id: String, issuer: String) {
      self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var id: String {
      get {
        return snapshot["id"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "id")
      }
    }

    internal var issuer: String {
      get {
        return snapshot["issuer"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "issuer")
      }
    }
  }

  internal struct CustomFolderName: GraphQLSelectionSet {
    internal static let possibleTypes = ["SealedAttribute"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
      GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
      GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
      GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
      self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var algorithm: String {
      get {
        return snapshot["algorithm"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "algorithm")
      }
    }

    internal var keyId: String {
      get {
        return snapshot["keyId"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "keyId")
      }
    }

    internal var plainTextType: String {
      get {
        return snapshot["plainTextType"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "plainTextType")
      }
    }

    internal var base64EncodedSealedData: String {
      get {
        return snapshot["base64EncodedSealedData"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
      }
    }

    internal var fragments: Fragments {
      get {
        return Fragments(snapshot: snapshot)
      }
      set {
        snapshot += newValue.snapshot
      }
    }

    internal struct Fragments {
      internal var snapshot: Snapshot

      internal var sealedAttribute: SealedAttribute {
        get {
          return SealedAttribute(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }
    }
  }
}

internal struct Owner: GraphQLFragment {
  internal static let fragmentString =
    "fragment Owner on Owner {\n  __typename\n  id\n  issuer\n}"

  internal static let possibleTypes = ["Owner"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(String.self))),
    GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(id: String, issuer: String) {
    self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var id: String {
    get {
      return snapshot["id"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  internal var issuer: String {
    get {
      return snapshot["issuer"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "issuer")
    }
  }
}

internal struct PaginatedPublicKey: GraphQLFragment {
  internal static let fragmentString =
    "fragment PaginatedPublicKey on PaginatedPublicKey {\n  __typename\n  items {\n    __typename\n    ...PublicKey\n  }\n  nextToken\n}"

  internal static let possibleTypes = ["PaginatedPublicKey"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("items", type: .nonNull(.list(.nonNull(.object(Item.selections))))),
    GraphQLField("nextToken", type: .scalar(String.self)),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(items: [Item], nextToken: String? = nil) {
    self.init(snapshot: ["__typename": "PaginatedPublicKey", "items": items.map { $0.snapshot }, "nextToken": nextToken])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var items: [Item] {
    get {
      return (snapshot["items"] as! [Snapshot]).map { Item(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "items")
    }
  }

  internal var nextToken: String? {
    get {
      return snapshot["nextToken"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "nextToken")
    }
  }

  internal struct Item: GraphQLSelectionSet {
    internal static let possibleTypes = ["PublicKey"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
      GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
      GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
      GraphQLField("keyFormat", type: .scalar(KeyFormat.self)),
      GraphQLField("publicKey", type: .nonNull(.scalar(String.self))),
      GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("version", type: .nonNull(.scalar(Int.self))),
      GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
      GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(id: GraphQLID, keyId: String, keyRingId: String, algorithm: String, keyFormat: KeyFormat? = nil, publicKey: String, owner: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
      self.init(snapshot: ["__typename": "PublicKey", "id": id, "keyId": keyId, "keyRingId": keyRingId, "algorithm": algorithm, "keyFormat": keyFormat, "publicKey": publicKey, "owner": owner, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var id: GraphQLID {
      get {
        return snapshot["id"]! as! GraphQLID
      }
      set {
        snapshot.updateValue(newValue, forKey: "id")
      }
    }

    internal var keyId: String {
      get {
        return snapshot["keyId"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "keyId")
      }
    }

    internal var keyRingId: String {
      get {
        return snapshot["keyRingId"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "keyRingId")
      }
    }

    internal var algorithm: String {
      get {
        return snapshot["algorithm"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "algorithm")
      }
    }

    internal var keyFormat: KeyFormat? {
      get {
        return snapshot["keyFormat"] as? KeyFormat
      }
      set {
        snapshot.updateValue(newValue, forKey: "keyFormat")
      }
    }

    internal var publicKey: String {
      get {
        return snapshot["publicKey"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "publicKey")
      }
    }

    internal var owner: GraphQLID {
      get {
        return snapshot["owner"]! as! GraphQLID
      }
      set {
        snapshot.updateValue(newValue, forKey: "owner")
      }
    }

    internal var version: Int {
      get {
        return snapshot["version"]! as! Int
      }
      set {
        snapshot.updateValue(newValue, forKey: "version")
      }
    }

    internal var createdAtEpochMs: Double {
      get {
        return snapshot["createdAtEpochMs"]! as! Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
      }
    }

    internal var updatedAtEpochMs: Double {
      get {
        return snapshot["updatedAtEpochMs"]! as! Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
      }
    }

    internal var fragments: Fragments {
      get {
        return Fragments(snapshot: snapshot)
      }
      set {
        snapshot += newValue.snapshot
      }
    }

    internal struct Fragments {
      internal var snapshot: Snapshot

      internal var publicKey: PublicKey {
        get {
          return PublicKey(snapshot: snapshot)
        }
        set {
          snapshot += newValue.snapshot
        }
      }
    }
  }
}

internal struct PublicKey: GraphQLFragment {
  internal static let fragmentString =
    "fragment PublicKey on PublicKey {\n  __typename\n  id\n  keyId\n  keyRingId\n  algorithm\n  keyFormat\n  publicKey\n  owner\n  version\n  createdAtEpochMs\n  updatedAtEpochMs\n}"

  internal static let possibleTypes = ["PublicKey"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
    GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
    GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
    GraphQLField("keyFormat", type: .scalar(KeyFormat.self)),
    GraphQLField("publicKey", type: .nonNull(.scalar(String.self))),
    GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("version", type: .nonNull(.scalar(Int.self))),
    GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(id: GraphQLID, keyId: String, keyRingId: String, algorithm: String, keyFormat: KeyFormat? = nil, publicKey: String, owner: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
    self.init(snapshot: ["__typename": "PublicKey", "id": id, "keyId": keyId, "keyRingId": keyRingId, "algorithm": algorithm, "keyFormat": keyFormat, "publicKey": publicKey, "owner": owner, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var id: GraphQLID {
    get {
      return snapshot["id"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  internal var keyId: String {
    get {
      return snapshot["keyId"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "keyId")
    }
  }

  internal var keyRingId: String {
    get {
      return snapshot["keyRingId"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "keyRingId")
    }
  }

  internal var algorithm: String {
    get {
      return snapshot["algorithm"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "algorithm")
    }
  }

  internal var keyFormat: KeyFormat? {
    get {
      return snapshot["keyFormat"] as? KeyFormat
    }
    set {
      snapshot.updateValue(newValue, forKey: "keyFormat")
    }
  }

  internal var publicKey: String {
    get {
      return snapshot["publicKey"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "publicKey")
    }
  }

  internal var owner: GraphQLID {
    get {
      return snapshot["owner"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "owner")
    }
  }

  internal var version: Int {
    get {
      return snapshot["version"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "version")
    }
  }

  internal var createdAtEpochMs: Double {
    get {
      return snapshot["createdAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
    }
  }

  internal var updatedAtEpochMs: Double {
    get {
      return snapshot["updatedAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
    }
  }
}

internal struct SealedAttribute: GraphQLFragment {
  internal static let fragmentString =
    "fragment SealedAttribute on SealedAttribute {\n  __typename\n  algorithm\n  keyId\n  plainTextType\n  base64EncodedSealedData\n}"

  internal static let possibleTypes = ["SealedAttribute"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
    GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
    GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
    GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
    self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var algorithm: String {
    get {
      return snapshot["algorithm"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "algorithm")
    }
  }

  internal var keyId: String {
    get {
      return snapshot["keyId"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "keyId")
    }
  }

  internal var plainTextType: String {
    get {
      return snapshot["plainTextType"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "plainTextType")
    }
  }

  internal var base64EncodedSealedData: String {
    get {
      return snapshot["base64EncodedSealedData"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
    }
  }
}

internal struct SealedEmailMessage: GraphQLFragment {
  internal static let fragmentString =
    "fragment SealedEmailMessage on SealedEmailMessage {\n  __typename\n  id\n  owner\n  owners {\n    __typename\n    id\n    issuer\n  }\n  emailAddressId\n  version\n  createdAtEpochMs\n  updatedAtEpochMs\n  sortDateEpochMs\n  folderId\n  previousFolderId\n  direction\n  seen\n  repliedTo\n  forwarded\n  state\n  clientRefId\n  rfc822Header {\n    __typename\n    algorithm\n    keyId\n    plainTextType\n    base64EncodedSealedData\n  }\n  size\n  encryptionStatus\n}"

  internal static let possibleTypes = ["SealedEmailMessage"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
    GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("version", type: .nonNull(.scalar(Int.self))),
    GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("sortDateEpochMs", type: .nonNull(.scalar(Double.self))),
    GraphQLField("folderId", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("previousFolderId", type: .scalar(GraphQLID.self)),
    GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
    GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("repliedTo", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("forwarded", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
    GraphQLField("clientRefId", type: .scalar(String.self)),
    GraphQLField("rfc822Header", type: .nonNull(.object(Rfc822Header.selections))),
    GraphQLField("size", type: .nonNull(.scalar(Double.self))),
    GraphQLField("encryptionStatus", type: .scalar(EmailMessageEncryptionStatus.self)),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(id: GraphQLID, owner: GraphQLID, owners: [Owner], emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, sortDateEpochMs: Double, folderId: GraphQLID, previousFolderId: GraphQLID? = nil, direction: EmailMessageDirection, seen: Bool, repliedTo: Bool, forwarded: Bool, state: EmailMessageState, clientRefId: String? = nil, rfc822Header: Rfc822Header, size: Double, encryptionStatus: EmailMessageEncryptionStatus? = nil) {
    self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "owner": owner, "owners": owners.map { $0.snapshot }, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "sortDateEpochMs": sortDateEpochMs, "folderId": folderId, "previousFolderId": previousFolderId, "direction": direction, "seen": seen, "repliedTo": repliedTo, "forwarded": forwarded, "state": state, "clientRefId": clientRefId, "rfc822Header": rfc822Header.snapshot, "size": size, "encryptionStatus": encryptionStatus])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var id: GraphQLID {
    get {
      return snapshot["id"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  internal var owner: GraphQLID {
    get {
      return snapshot["owner"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "owner")
    }
  }

  internal var owners: [Owner] {
    get {
      return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
    }
    set {
      snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
    }
  }

  internal var emailAddressId: GraphQLID {
    get {
      return snapshot["emailAddressId"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "emailAddressId")
    }
  }

  internal var version: Int {
    get {
      return snapshot["version"]! as! Int
    }
    set {
      snapshot.updateValue(newValue, forKey: "version")
    }
  }

  internal var createdAtEpochMs: Double {
    get {
      return snapshot["createdAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
    }
  }

  internal var updatedAtEpochMs: Double {
    get {
      return snapshot["updatedAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
    }
  }

  internal var sortDateEpochMs: Double {
    get {
      return snapshot["sortDateEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "sortDateEpochMs")
    }
  }

  internal var folderId: GraphQLID {
    get {
      return snapshot["folderId"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "folderId")
    }
  }

  internal var previousFolderId: GraphQLID? {
    get {
      return snapshot["previousFolderId"] as? GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "previousFolderId")
    }
  }

  internal var direction: EmailMessageDirection {
    get {
      return snapshot["direction"]! as! EmailMessageDirection
    }
    set {
      snapshot.updateValue(newValue, forKey: "direction")
    }
  }

  internal var seen: Bool {
    get {
      return snapshot["seen"]! as! Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "seen")
    }
  }

  internal var repliedTo: Bool {
    get {
      return snapshot["repliedTo"]! as! Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "repliedTo")
    }
  }

  internal var forwarded: Bool {
    get {
      return snapshot["forwarded"]! as! Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "forwarded")
    }
  }

  internal var state: EmailMessageState {
    get {
      return snapshot["state"]! as! EmailMessageState
    }
    set {
      snapshot.updateValue(newValue, forKey: "state")
    }
  }

  internal var clientRefId: String? {
    get {
      return snapshot["clientRefId"] as? String
    }
    set {
      snapshot.updateValue(newValue, forKey: "clientRefId")
    }
  }

  internal var rfc822Header: Rfc822Header {
    get {
      return Rfc822Header(snapshot: snapshot["rfc822Header"]! as! Snapshot)
    }
    set {
      snapshot.updateValue(newValue.snapshot, forKey: "rfc822Header")
    }
  }

  internal var size: Double {
    get {
      return snapshot["size"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "size")
    }
  }

  internal var encryptionStatus: EmailMessageEncryptionStatus? {
    get {
      return snapshot["encryptionStatus"] as? EmailMessageEncryptionStatus
    }
    set {
      snapshot.updateValue(newValue, forKey: "encryptionStatus")
    }
  }

  internal struct Owner: GraphQLSelectionSet {
    internal static let possibleTypes = ["Owner"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(String.self))),
      GraphQLField("issuer", type: .nonNull(.scalar(String.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(id: String, issuer: String) {
      self.init(snapshot: ["__typename": "Owner", "id": id, "issuer": issuer])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var id: String {
      get {
        return snapshot["id"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "id")
      }
    }

    internal var issuer: String {
      get {
        return snapshot["issuer"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "issuer")
      }
    }
  }

  internal struct Rfc822Header: GraphQLSelectionSet {
    internal static let possibleTypes = ["SealedAttribute"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
      GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
      GraphQLField("plainTextType", type: .nonNull(.scalar(String.self))),
      GraphQLField("base64EncodedSealedData", type: .nonNull(.scalar(String.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(algorithm: String, keyId: String, plainTextType: String, base64EncodedSealedData: String) {
      self.init(snapshot: ["__typename": "SealedAttribute", "algorithm": algorithm, "keyId": keyId, "plainTextType": plainTextType, "base64EncodedSealedData": base64EncodedSealedData])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var algorithm: String {
      get {
        return snapshot["algorithm"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "algorithm")
      }
    }

    internal var keyId: String {
      get {
        return snapshot["keyId"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "keyId")
      }
    }

    internal var plainTextType: String {
      get {
        return snapshot["plainTextType"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "plainTextType")
      }
    }

    internal var base64EncodedSealedData: String {
      get {
        return snapshot["base64EncodedSealedData"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "base64EncodedSealedData")
      }
    }
  }
}

internal struct SendEmailMessageResult: GraphQLFragment {
  internal static let fragmentString =
    "fragment SendEmailMessageResult on SendEmailMessageResult {\n  __typename\n  id\n  createdAtEpochMs\n}"

  internal static let possibleTypes = ["SendEmailMessageResult"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(id: GraphQLID, createdAtEpochMs: Double) {
    self.init(snapshot: ["__typename": "SendEmailMessageResult", "id": id, "createdAtEpochMs": createdAtEpochMs])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var id: GraphQLID {
    get {
      return snapshot["id"]! as! GraphQLID
    }
    set {
      snapshot.updateValue(newValue, forKey: "id")
    }
  }

  internal var createdAtEpochMs: Double {
    get {
      return snapshot["createdAtEpochMs"]! as! Double
    }
    set {
      snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
    }
  }
}

internal struct UpdateEmailMessagesResult: GraphQLFragment {
  internal static let fragmentString =
    "fragment UpdateEmailMessagesResult on UpdateEmailMessagesV2Result {\n  __typename\n  status\n  failedMessages {\n    __typename\n    id\n    errorType\n  }\n  successMessages {\n    __typename\n    id\n    createdAtEpochMs\n    updatedAtEpochMs\n  }\n}"

  internal static let possibleTypes = ["UpdateEmailMessagesV2Result"]

  internal static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("status", type: .nonNull(.scalar(UpdateEmailMessagesStatus.self))),
    GraphQLField("failedMessages", type: .list(.nonNull(.object(FailedMessage.selections)))),
    GraphQLField("successMessages", type: .list(.nonNull(.object(SuccessMessage.selections)))),
  ]

  internal var snapshot: Snapshot

  internal init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  internal init(status: UpdateEmailMessagesStatus, failedMessages: [FailedMessage]? = nil, successMessages: [SuccessMessage]? = nil) {
    self.init(snapshot: ["__typename": "UpdateEmailMessagesV2Result", "status": status, "failedMessages": failedMessages.flatMap { $0.map { $0.snapshot } }, "successMessages": successMessages.flatMap { $0.map { $0.snapshot } }])
  }

  internal var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  internal var status: UpdateEmailMessagesStatus {
    get {
      return snapshot["status"]! as! UpdateEmailMessagesStatus
    }
    set {
      snapshot.updateValue(newValue, forKey: "status")
    }
  }

  internal var failedMessages: [FailedMessage]? {
    get {
      return (snapshot["failedMessages"] as? [Snapshot]).flatMap { $0.map { FailedMessage(snapshot: $0) } }
    }
    set {
      snapshot.updateValue(newValue.flatMap { $0.map { $0.snapshot } }, forKey: "failedMessages")
    }
  }

  internal var successMessages: [SuccessMessage]? {
    get {
      return (snapshot["successMessages"] as? [Snapshot]).flatMap { $0.map { SuccessMessage(snapshot: $0) } }
    }
    set {
      snapshot.updateValue(newValue.flatMap { $0.map { $0.snapshot } }, forKey: "successMessages")
    }
  }

  internal struct FailedMessage: GraphQLSelectionSet {
    internal static let possibleTypes = ["UpdatedEmailMessageFailure"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("errorType", type: .nonNull(.scalar(String.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(id: GraphQLID, errorType: String) {
      self.init(snapshot: ["__typename": "UpdatedEmailMessageFailure", "id": id, "errorType": errorType])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var id: GraphQLID {
      get {
        return snapshot["id"]! as! GraphQLID
      }
      set {
        snapshot.updateValue(newValue, forKey: "id")
      }
    }

    internal var errorType: String {
      get {
        return snapshot["errorType"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "errorType")
      }
    }
  }

  internal struct SuccessMessage: GraphQLSelectionSet {
    internal static let possibleTypes = ["UpdatedEmailMessageSuccess"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
      GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(id: GraphQLID, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
      self.init(snapshot: ["__typename": "UpdatedEmailMessageSuccess", "id": id, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
    }

    internal var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    internal var id: GraphQLID {
      get {
        return snapshot["id"]! as! GraphQLID
      }
      set {
        snapshot.updateValue(newValue, forKey: "id")
      }
    }

    internal var createdAtEpochMs: Double {
      get {
        return snapshot["createdAtEpochMs"]! as! Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
      }
    }

    internal var updatedAtEpochMs: Double {
      get {
        return snapshot["updatedAtEpochMs"]! as! Double
      }
      set {
        snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
      }
    }
  }
}
}