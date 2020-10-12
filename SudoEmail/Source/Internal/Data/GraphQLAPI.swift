// swiftlint:disable all
//  This file was automatically generated and should not be edited.

import AWSAppSync

internal struct CheckEmailAddressAvailabilityInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(localParts: [String], domains: Optional<[String]?> = nil) {
    graphQLMap = ["localParts": localParts, "domains": domains]
  }

  internal var localParts: [String] {
    get {
      return graphQLMap["localParts"] as! [String]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "localParts")
    }
  }

  internal var domains: Optional<[String]?> {
    get {
      return graphQLMap["domains"] as! Optional<[String]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "domains")
    }
  }
}

internal struct ListEmailAddressesInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(sudoId: Optional<String?> = nil, filter: Optional<EmailAddressFilterInput?> = nil, limit: Optional<Int?> = nil, nextToken: Optional<String?> = nil) {
    graphQLMap = ["sudoId": sudoId, "filter": filter, "limit": limit, "nextToken": nextToken]
  }

  internal var sudoId: Optional<String?> {
    get {
      return graphQLMap["sudoId"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sudoId")
    }
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

  internal init(id: Optional<IDFilterInput?> = nil, sudoId: Optional<IDFilterInput?> = nil, identityId: Optional<IDFilterInput?> = nil, keyRingId: Optional<IDFilterInput?> = nil, emailAddress: Optional<StringFilterInput?> = nil, and: Optional<[EmailAddressFilterInput?]?> = nil, or: Optional<[EmailAddressFilterInput?]?> = nil, not: Optional<EmailAddressFilterInput?> = nil) {
    graphQLMap = ["id": id, "sudoId": sudoId, "identityId": identityId, "keyRingId": keyRingId, "emailAddress": emailAddress, "and": and, "or": or, "not": not]
  }

  internal var id: Optional<IDFilterInput?> {
    get {
      return graphQLMap["id"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  internal var sudoId: Optional<IDFilterInput?> {
    get {
      return graphQLMap["sudoId"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sudoId")
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

  internal var emailAddress: Optional<StringFilterInput?> {
    get {
      return graphQLMap["emailAddress"] as! Optional<StringFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddress")
    }
  }

  internal var and: Optional<[EmailAddressFilterInput?]?> {
    get {
      return graphQLMap["and"] as! Optional<[EmailAddressFilterInput?]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
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

  internal var not: Optional<EmailAddressFilterInput?> {
    get {
      return graphQLMap["not"] as! Optional<EmailAddressFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
    }
  }
}

internal struct IDFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(ne: Optional<GraphQLID?> = nil, eq: Optional<GraphQLID?> = nil, beginsWith: Optional<GraphQLID?> = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "beginsWith": beginsWith]
  }

  internal var ne: Optional<GraphQLID?> {
    get {
      return graphQLMap["ne"] as! Optional<GraphQLID?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
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

  internal var beginsWith: Optional<GraphQLID?> {
    get {
      return graphQLMap["beginsWith"] as! Optional<GraphQLID?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
    }
  }
}

internal struct StringFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(ne: Optional<String?> = nil, eq: Optional<String?> = nil, beginsWith: Optional<String?> = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "beginsWith": beginsWith]
  }

  internal var ne: Optional<String?> {
    get {
      return graphQLMap["ne"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
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

  internal var beginsWith: Optional<String?> {
    get {
      return graphQLMap["beginsWith"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "beginsWith")
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
  case queued
  case sent
  case delivered
  case undelivered
  case failed
  case received
  /// Auto generated constant for unknown enum values
  case unknown(RawValue)

  internal init?(rawValue: RawValue) {
    switch rawValue {
      case "QUEUED": self = .queued
      case "SENT": self = .sent
      case "DELIVERED": self = .delivered
      case "UNDELIVERED": self = .undelivered
      case "FAILED": self = .failed
      case "RECEIVED": self = .received
      default: self = .unknown(rawValue)
    }
  }

  internal var rawValue: RawValue {
    switch self {
      case .queued: return "QUEUED"
      case .sent: return "SENT"
      case .delivered: return "DELIVERED"
      case .undelivered: return "UNDELIVERED"
      case .failed: return "FAILED"
      case .received: return "RECEIVED"
      case .unknown(let value): return value
    }
  }

  internal static func == (lhs: EmailMessageState, rhs: EmailMessageState) -> Bool {
    switch (lhs, rhs) {
      case (.queued, .queued): return true
      case (.sent, .sent): return true
      case (.delivered, .delivered): return true
      case (.undelivered, .undelivered): return true
      case (.failed, .failed): return true
      case (.received, .received): return true
      case (.unknown(let lhsValue), .unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

internal struct ListEmailMessagesInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(sudoId: Optional<GraphQLID?> = nil, emailAddressId: Optional<GraphQLID?> = nil, filter: Optional<EmailMessageFilterInput?> = nil, limit: Optional<Int?> = nil, nextToken: Optional<String?> = nil) {
    graphQLMap = ["sudoId": sudoId, "emailAddressId": emailAddressId, "filter": filter, "limit": limit, "nextToken": nextToken]
  }

  internal var sudoId: Optional<GraphQLID?> {
    get {
      return graphQLMap["sudoId"] as! Optional<GraphQLID?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sudoId")
    }
  }

  internal var emailAddressId: Optional<GraphQLID?> {
    get {
      return graphQLMap["emailAddressId"] as! Optional<GraphQLID?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddressId")
    }
  }

  internal var filter: Optional<EmailMessageFilterInput?> {
    get {
      return graphQLMap["filter"] as! Optional<EmailMessageFilterInput?>
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

internal struct EmailMessageFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(id: Optional<IDFilterInput?> = nil, messageId: Optional<IDFilterInput?> = nil, sudoId: Optional<IDFilterInput?> = nil, emailAddressId: Optional<IDFilterInput?> = nil, algorithm: Optional<StringFilterInput?> = nil, keyId: Optional<IDFilterInput?> = nil, direction: Optional<EmailMessageDirectionFilterInput?> = nil, seen: Optional<BooleanFilterInput?> = nil, clientRefId: Optional<IDFilterInput?> = nil, state: Optional<EmailMessageStateFilterInput?> = nil, and: Optional<[EmailMessageFilterInput?]?> = nil, or: Optional<[EmailMessageFilterInput?]?> = nil, not: Optional<EmailMessageFilterInput?> = nil) {
    graphQLMap = ["id": id, "messageId": messageId, "sudoId": sudoId, "emailAddressId": emailAddressId, "algorithm": algorithm, "keyId": keyId, "direction": direction, "seen": seen, "clientRefId": clientRefId, "state": state, "and": and, "or": or, "not": not]
  }

  internal var id: Optional<IDFilterInput?> {
    get {
      return graphQLMap["id"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
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

  internal var sudoId: Optional<IDFilterInput?> {
    get {
      return graphQLMap["sudoId"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sudoId")
    }
  }

  internal var emailAddressId: Optional<IDFilterInput?> {
    get {
      return graphQLMap["emailAddressId"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddressId")
    }
  }

  internal var algorithm: Optional<StringFilterInput?> {
    get {
      return graphQLMap["algorithm"] as! Optional<StringFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "algorithm")
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

  internal var direction: Optional<EmailMessageDirectionFilterInput?> {
    get {
      return graphQLMap["direction"] as! Optional<EmailMessageDirectionFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "direction")
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

  internal var clientRefId: Optional<IDFilterInput?> {
    get {
      return graphQLMap["clientRefId"] as! Optional<IDFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "clientRefId")
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

  internal var and: Optional<[EmailMessageFilterInput?]?> {
    get {
      return graphQLMap["and"] as! Optional<[EmailMessageFilterInput?]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "and")
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

  internal var not: Optional<EmailMessageFilterInput?> {
    get {
      return graphQLMap["not"] as! Optional<EmailMessageFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "not")
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

  internal init(ne: Optional<Bool?> = nil, eq: Optional<Bool?> = nil) {
    graphQLMap = ["ne": ne, "eq": eq]
  }

  internal var ne: Optional<Bool?> {
    get {
      return graphQLMap["ne"] as! Optional<Bool?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
  }

  internal var eq: Optional<Bool?> {
    get {
      return graphQLMap["eq"] as! Optional<Bool?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "eq")
    }
  }
}

internal struct EmailMessageStateFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(ne: Optional<EmailMessageState?> = nil, eq: Optional<EmailMessageState?> = nil, `in`: Optional<[EmailMessageState?]?> = nil, notIn: Optional<[EmailMessageState?]?> = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "in": `in`, "notIn": notIn]
  }

  internal var ne: Optional<EmailMessageState?> {
    get {
      return graphQLMap["ne"] as! Optional<EmailMessageState?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ne")
    }
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

  internal var notIn: Optional<[EmailMessageState?]?> {
    get {
      return graphQLMap["notIn"] as! Optional<[EmailMessageState?]?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notIn")
    }
  }
}

internal struct ProvisionEmailAddressInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(emailAddress: String, keyRingId: String, ownershipProofTokens: [String]) {
    graphQLMap = ["emailAddress": emailAddress, "keyRingId": keyRingId, "ownershipProofTokens": ownershipProofTokens]
  }

  internal var emailAddress: String {
    get {
      return graphQLMap["emailAddress"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "emailAddress")
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

  internal var ownershipProofTokens: [String] {
    get {
      return graphQLMap["ownershipProofTokens"] as! [String]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ownershipProofTokens")
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

internal struct SendEmailMessageInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(emailAddressId: GraphQLID, message: S3EmailObjectInput, clientRefId: Optional<String?> = nil) {
    graphQLMap = ["emailAddressId": emailAddressId, "message": message, "clientRefId": clientRefId]
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

  internal var clientRefId: Optional<String?> {
    get {
      return graphQLMap["clientRefId"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "clientRefId")
    }
  }
}

internal struct S3EmailObjectInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(key: String, bucket: String, region: String) {
    graphQLMap = ["key": key, "bucket": bucket, "region": region]
  }

  internal var key: String {
    get {
      return graphQLMap["key"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "key")
    }
  }

  internal var bucket: String {
    get {
      return graphQLMap["bucket"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "bucket")
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

internal struct DeleteEmailMessageInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(messageId: GraphQLID) {
    graphQLMap = ["messageId": messageId]
  }

  internal var messageId: GraphQLID {
    get {
      return graphQLMap["messageId"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "messageId")
    }
  }
}

internal struct CreatePublicKeyInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(keyId: String, keyRingId: String, algorithm: String, publicKey: String) {
    graphQLMap = ["keyId": keyId, "keyRingId": keyRingId, "algorithm": algorithm, "publicKey": publicKey]
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

  internal var algorithm: String {
    get {
      return graphQLMap["algorithm"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "algorithm")
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

internal struct DeletePublicKeyInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(keyId: String) {
    graphQLMap = ["keyId": keyId]
  }

  internal var keyId: String {
    get {
      return graphQLMap["keyId"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "keyId")
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
    "query GetEmailAddress($id: String!) {\n  getEmailAddress(id: $id) {\n    __typename\n    id\n    userId\n    sudoId\n    identityId\n    keyRingId\n    owners {\n      __typename\n      id\n      issuer\n    }\n    version\n    createdAtEpochMs\n    updatedAtEpochMs\n    emailAddress\n  }\n}"

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
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("userId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("sudoId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("identityId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, userId: GraphQLID, sudoId: GraphQLID, identityId: GraphQLID, keyRingId: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddress: String) {
        self.init(snapshot: ["__typename": "EmailAddress", "id": id, "userId": userId, "sudoId": sudoId, "identityId": identityId, "keyRingId": keyRingId, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddress": emailAddress])
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

      internal var userId: GraphQLID {
        get {
          return snapshot["userId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "userId")
        }
      }

      internal var sudoId: GraphQLID {
        get {
          return snapshot["sudoId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "sudoId")
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

      internal var emailAddress: String {
        get {
          return snapshot["emailAddress"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddress")
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
    }
  }
}

internal final class ListEmailAddressesQuery: GraphQLQuery {
  internal static let operationString =
    "query ListEmailAddresses($input: ListEmailAddressesInput!) {\n  listEmailAddresses(input: $input) {\n    __typename\n    items {\n      __typename\n      id\n      userId\n      sudoId\n      identityId\n      keyRingId\n      owners {\n        __typename\n        id\n        issuer\n      }\n      version\n      createdAtEpochMs\n      updatedAtEpochMs\n      emailAddress\n    }\n    nextToken\n  }\n}"

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
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("userId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("sudoId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("identityId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("keyRingId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, userId: GraphQLID, sudoId: GraphQLID, identityId: GraphQLID, keyRingId: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddress: String) {
          self.init(snapshot: ["__typename": "EmailAddress", "id": id, "userId": userId, "sudoId": sudoId, "identityId": identityId, "keyRingId": keyRingId, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddress": emailAddress])
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

        internal var userId: GraphQLID {
          get {
            return snapshot["userId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "userId")
          }
        }

        internal var sudoId: GraphQLID {
          get {
            return snapshot["sudoId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "sudoId")
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

        internal var emailAddress: String {
          get {
            return snapshot["emailAddress"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "emailAddress")
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
      }
    }
  }
}

internal final class GetEmailMessageQuery: GraphQLQuery {
  internal static let operationString =
    "query GetEmailMessage($id: ID!) {\n  getEmailMessage(id: $id) {\n    __typename\n    id\n    messageId\n    userId\n    sudoId\n    emailAddressId\n    version\n    createdAtEpochMs\n    updatedAtEpochMs\n    algorithm\n    keyId\n    direction\n    seen\n    state\n    clientRefId\n    from\n    replyTo\n    to\n    cc\n    bcc\n    subject\n  }\n}"

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
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("messageId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("userId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("sudoId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("from", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("replyTo", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("to", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("cc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("bcc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("subject", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, messageId: GraphQLID, userId: GraphQLID, sudoId: GraphQLID, emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, algorithm: String, keyId: String, direction: EmailMessageDirection, seen: Bool, state: EmailMessageState, clientRefId: String? = nil, from: [String], replyTo: [String], to: [String], cc: [String], bcc: [String], subject: String? = nil) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "messageId": messageId, "userId": userId, "sudoId": sudoId, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "algorithm": algorithm, "keyId": keyId, "direction": direction, "seen": seen, "state": state, "clientRefId": clientRefId, "from": from, "replyTo": replyTo, "to": to, "cc": cc, "bcc": bcc, "subject": subject])
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

      internal var messageId: GraphQLID {
        get {
          return snapshot["messageId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "messageId")
        }
      }

      internal var userId: GraphQLID {
        get {
          return snapshot["userId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "userId")
        }
      }

      internal var sudoId: GraphQLID {
        get {
          return snapshot["sudoId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "sudoId")
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

      internal var from: [String] {
        get {
          return snapshot["from"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "from")
        }
      }

      internal var replyTo: [String] {
        get {
          return snapshot["replyTo"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "replyTo")
        }
      }

      internal var to: [String] {
        get {
          return snapshot["to"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "to")
        }
      }

      internal var cc: [String] {
        get {
          return snapshot["cc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "cc")
        }
      }

      internal var bcc: [String] {
        get {
          return snapshot["bcc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "bcc")
        }
      }

      internal var subject: String? {
        get {
          return snapshot["subject"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "subject")
        }
      }
    }
  }
}

internal final class ListEmailMessagesQuery: GraphQLQuery {
  internal static let operationString =
    "query ListEmailMessages($input: ListEmailMessagesInput!) {\n  listEmailMessages(input: $input) {\n    __typename\n    items {\n      __typename\n      id\n      messageId\n      userId\n      sudoId\n      emailAddressId\n      version\n      createdAtEpochMs\n      updatedAtEpochMs\n      algorithm\n      keyId\n      direction\n      seen\n      state\n      clientRefId\n      from\n      replyTo\n      to\n      cc\n      bcc\n      subject\n    }\n    nextToken\n  }\n}"

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
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("messageId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("userId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("sudoId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
          GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
          GraphQLField("clientRefId", type: .scalar(String.self)),
          GraphQLField("from", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("replyTo", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("to", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("cc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("bcc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("subject", type: .scalar(String.self)),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, messageId: GraphQLID, userId: GraphQLID, sudoId: GraphQLID, emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, algorithm: String, keyId: String, direction: EmailMessageDirection, seen: Bool, state: EmailMessageState, clientRefId: String? = nil, from: [String], replyTo: [String], to: [String], cc: [String], bcc: [String], subject: String? = nil) {
          self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "messageId": messageId, "userId": userId, "sudoId": sudoId, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "algorithm": algorithm, "keyId": keyId, "direction": direction, "seen": seen, "state": state, "clientRefId": clientRefId, "from": from, "replyTo": replyTo, "to": to, "cc": cc, "bcc": bcc, "subject": subject])
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

        internal var messageId: GraphQLID {
          get {
            return snapshot["messageId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "messageId")
          }
        }

        internal var userId: GraphQLID {
          get {
            return snapshot["userId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "userId")
          }
        }

        internal var sudoId: GraphQLID {
          get {
            return snapshot["sudoId"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "sudoId")
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

        internal var from: [String] {
          get {
            return snapshot["from"]! as! [String]
          }
          set {
            snapshot.updateValue(newValue, forKey: "from")
          }
        }

        internal var replyTo: [String] {
          get {
            return snapshot["replyTo"]! as! [String]
          }
          set {
            snapshot.updateValue(newValue, forKey: "replyTo")
          }
        }

        internal var to: [String] {
          get {
            return snapshot["to"]! as! [String]
          }
          set {
            snapshot.updateValue(newValue, forKey: "to")
          }
        }

        internal var cc: [String] {
          get {
            return snapshot["cc"]! as! [String]
          }
          set {
            snapshot.updateValue(newValue, forKey: "cc")
          }
        }

        internal var bcc: [String] {
          get {
            return snapshot["bcc"]! as! [String]
          }
          set {
            snapshot.updateValue(newValue, forKey: "bcc")
          }
        }

        internal var subject: String? {
          get {
            return snapshot["subject"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "subject")
          }
        }
      }
    }
  }
}

internal final class GetPublicKeyForEmailQuery: GraphQLQuery {
  internal static let operationString =
    "query GetPublicKeyForEmail($keyId: String!) {\n  getPublicKeyForEmail(keyId: $keyId) {\n    __typename\n    id\n    keyId\n    keyRingId\n    algorithm\n    publicKey\n    owner\n    version\n    createdAtEpochMs\n    updatedAtEpochMs\n  }\n}"

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
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
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

      internal init(id: GraphQLID, keyId: String, keyRingId: String, algorithm: String, publicKey: String, owner: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "PublicKey", "id": id, "keyId": keyId, "keyRingId": keyRingId, "algorithm": algorithm, "publicKey": publicKey, "owner": owner, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
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
  }
}

internal final class GetPublicKeysForEmailQuery: GraphQLQuery {
  internal static let operationString =
    "query GetPublicKeysForEmail($limit: Int, $nextToken: String) {\n  getPublicKeysForEmail(limit: $limit, nextToken: $nextToken) {\n    __typename\n    items {\n      __typename\n      id\n      keyId\n      keyRingId\n      algorithm\n      publicKey\n      owner\n      version\n      createdAtEpochMs\n      updatedAtEpochMs\n    }\n    nextToken\n  }\n}"

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
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
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

        internal init(id: GraphQLID, keyId: String, keyRingId: String, algorithm: String, publicKey: String, owner: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
          self.init(snapshot: ["__typename": "PublicKey", "id": id, "keyId": keyId, "keyRingId": keyRingId, "algorithm": algorithm, "publicKey": publicKey, "owner": owner, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
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
    }
  }
}

internal final class GetKeyRingForEmailQuery: GraphQLQuery {
  internal static let operationString =
    "query GetKeyRingForEmail($keyRingId: String!, $limit: Int, $nextToken: String) {\n  getKeyRingForEmail(keyRingId: $keyRingId, limit: $limit, nextToken: $nextToken) {\n    __typename\n    items {\n      __typename\n      id\n      keyId\n      keyRingId\n      algorithm\n      publicKey\n      owner\n      version\n      createdAtEpochMs\n      updatedAtEpochMs\n    }\n    nextToken\n  }\n}"

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
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
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

        internal init(id: GraphQLID, keyId: String, keyRingId: String, algorithm: String, publicKey: String, owner: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
          self.init(snapshot: ["__typename": "PublicKey", "id": id, "keyId": keyId, "keyRingId": keyRingId, "algorithm": algorithm, "publicKey": publicKey, "owner": owner, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
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
    }
  }
}

internal final class ProvisionEmailAddressMutation: GraphQLMutation {
  internal static let operationString =
    "mutation ProvisionEmailAddress($input: ProvisionEmailAddressInput!) {\n  provisionEmailAddress(input: $input) {\n    __typename\n    id\n    userId\n    sudoId\n    identityId\n    keyRingId\n    owners {\n      __typename\n      id\n      issuer\n    }\n    version\n    createdAtEpochMs\n    updatedAtEpochMs\n    emailAddress\n  }\n}"

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
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("userId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("sudoId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("identityId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, userId: GraphQLID, sudoId: GraphQLID, identityId: GraphQLID, keyRingId: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddress: String) {
        self.init(snapshot: ["__typename": "EmailAddress", "id": id, "userId": userId, "sudoId": sudoId, "identityId": identityId, "keyRingId": keyRingId, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddress": emailAddress])
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

      internal var userId: GraphQLID {
        get {
          return snapshot["userId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "userId")
        }
      }

      internal var sudoId: GraphQLID {
        get {
          return snapshot["sudoId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "sudoId")
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

      internal var emailAddress: String {
        get {
          return snapshot["emailAddress"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddress")
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
    }
  }
}

internal final class DeprovisionEmailAddressMutation: GraphQLMutation {
  internal static let operationString =
    "mutation DeprovisionEmailAddress($input: DeprovisionEmailAddressInput!) {\n  deprovisionEmailAddress(input: $input) {\n    __typename\n    id\n    userId\n    sudoId\n    identityId\n    keyRingId\n    owners {\n      __typename\n      id\n      issuer\n    }\n    version\n    createdAtEpochMs\n    updatedAtEpochMs\n    emailAddress\n  }\n}"

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
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("userId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("sudoId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("identityId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, userId: GraphQLID, sudoId: GraphQLID, identityId: GraphQLID, keyRingId: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddress: String) {
        self.init(snapshot: ["__typename": "EmailAddress", "id": id, "userId": userId, "sudoId": sudoId, "identityId": identityId, "keyRingId": keyRingId, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddress": emailAddress])
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

      internal var userId: GraphQLID {
        get {
          return snapshot["userId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "userId")
        }
      }

      internal var sudoId: GraphQLID {
        get {
          return snapshot["sudoId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "sudoId")
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

      internal var emailAddress: String {
        get {
          return snapshot["emailAddress"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddress")
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
    }
  }
}

internal final class SendEmailMessageMutation: GraphQLMutation {
  internal static let operationString =
    "mutation SendEmailMessage($input: SendEmailMessageInput!) {\n  sendEmailMessage(input: $input)\n}"

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
      GraphQLField("sendEmailMessage", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.scalar(GraphQLID.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(sendEmailMessage: GraphQLID) {
      self.init(snapshot: ["__typename": "Mutation", "sendEmailMessage": sendEmailMessage])
    }

    internal var sendEmailMessage: GraphQLID {
      get {
        return snapshot["sendEmailMessage"]! as! GraphQLID
      }
      set {
        snapshot.updateValue(newValue, forKey: "sendEmailMessage")
      }
    }
  }
}

internal final class DeleteEmailMessageMutation: GraphQLMutation {
  internal static let operationString =
    "mutation DeleteEmailMessage($input: DeleteEmailMessageInput!) {\n  deleteEmailMessage(input: $input)\n}"

  internal var input: DeleteEmailMessageInput

  internal init(input: DeleteEmailMessageInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("deleteEmailMessage", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.scalar(GraphQLID.self))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(deleteEmailMessage: GraphQLID) {
      self.init(snapshot: ["__typename": "Mutation", "deleteEmailMessage": deleteEmailMessage])
    }

    internal var deleteEmailMessage: GraphQLID {
      get {
        return snapshot["deleteEmailMessage"]! as! GraphQLID
      }
      set {
        snapshot.updateValue(newValue, forKey: "deleteEmailMessage")
      }
    }
  }
}

internal final class CreatePublicKeyForEmailMutation: GraphQLMutation {
  internal static let operationString =
    "mutation CreatePublicKeyForEmail($input: CreatePublicKeyInput!) {\n  createPublicKeyForEmail(input: $input) {\n    __typename\n    id\n    keyId\n    keyRingId\n    algorithm\n    publicKey\n    owner\n    version\n    createdAtEpochMs\n    updatedAtEpochMs\n  }\n}"

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
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
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

      internal init(id: GraphQLID, keyId: String, keyRingId: String, algorithm: String, publicKey: String, owner: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "PublicKey", "id": id, "keyId": keyId, "keyRingId": keyRingId, "algorithm": algorithm, "publicKey": publicKey, "owner": owner, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
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
  }
}

internal final class DeletePublicKeyForEmailMutation: GraphQLMutation {
  internal static let operationString =
    "mutation DeletePublicKeyForEmail($input: DeletePublicKeyInput) {\n  deletePublicKeyForEmail(input: $input) {\n    __typename\n    id\n    keyId\n    keyRingId\n    algorithm\n    publicKey\n    owner\n    version\n    createdAtEpochMs\n    updatedAtEpochMs\n  }\n}"

  internal var input: DeletePublicKeyInput?

  internal init(input: DeletePublicKeyInput? = nil) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Mutation"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("deletePublicKeyForEmail", arguments: ["input": GraphQLVariable("input")], type: .object(DeletePublicKeyForEmail.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(deletePublicKeyForEmail: DeletePublicKeyForEmail? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "deletePublicKeyForEmail": deletePublicKeyForEmail.flatMap { $0.snapshot }])
    }

    internal var deletePublicKeyForEmail: DeletePublicKeyForEmail? {
      get {
        return (snapshot["deletePublicKeyForEmail"] as? Snapshot).flatMap { DeletePublicKeyForEmail(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "deletePublicKeyForEmail")
      }
    }

    internal struct DeletePublicKeyForEmail: GraphQLSelectionSet {
      internal static let possibleTypes = ["PublicKey"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
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

      internal init(id: GraphQLID, keyId: String, keyRingId: String, algorithm: String, publicKey: String, owner: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double) {
        self.init(snapshot: ["__typename": "PublicKey", "id": id, "keyId": keyId, "keyRingId": keyRingId, "algorithm": algorithm, "publicKey": publicKey, "owner": owner, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs])
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
  }
}

internal final class OnEmailAddressCreatedSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailAddressCreated($userId: ID!) {\n  onEmailAddressCreated(userId: $userId) {\n    __typename\n    id\n    userId\n    sudoId\n    identityId\n    keyRingId\n    owners {\n      __typename\n      id\n      issuer\n    }\n    version\n    createdAtEpochMs\n    updatedAtEpochMs\n    emailAddress\n  }\n}"

  internal var userId: GraphQLID

  internal init(userId: GraphQLID) {
    self.userId = userId
  }

  internal var variables: GraphQLMap? {
    return ["userId": userId]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Subscription"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("onEmailAddressCreated", arguments: ["userId": GraphQLVariable("userId")], type: .object(OnEmailAddressCreated.selections)),
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
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("userId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("sudoId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("identityId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, userId: GraphQLID, sudoId: GraphQLID, identityId: GraphQLID, keyRingId: GraphQLID, owners: [Owner], version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, emailAddress: String) {
        self.init(snapshot: ["__typename": "EmailAddress", "id": id, "userId": userId, "sudoId": sudoId, "identityId": identityId, "keyRingId": keyRingId, "owners": owners.map { $0.snapshot }, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "emailAddress": emailAddress])
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

      internal var userId: GraphQLID {
        get {
          return snapshot["userId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "userId")
        }
      }

      internal var sudoId: GraphQLID {
        get {
          return snapshot["sudoId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "sudoId")
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

      internal var emailAddress: String {
        get {
          return snapshot["emailAddress"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "emailAddress")
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
    }
  }
}

internal final class OnEmailMessageCreatedSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailMessageCreated($userId: String!) {\n  onEmailMessageCreated(userId: $userId) {\n    __typename\n    id\n    messageId\n    userId\n    sudoId\n    emailAddressId\n    version\n    createdAtEpochMs\n    updatedAtEpochMs\n    algorithm\n    keyId\n    direction\n    seen\n    state\n    clientRefId\n    from\n    replyTo\n    to\n    cc\n    bcc\n    subject\n  }\n}"

  internal var userId: String

  internal init(userId: String) {
    self.userId = userId
  }

  internal var variables: GraphQLMap? {
    return ["userId": userId]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Subscription"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("onEmailMessageCreated", arguments: ["userId": GraphQLVariable("userId")], type: .object(OnEmailMessageCreated.selections)),
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
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("messageId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("userId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("sudoId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("from", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("replyTo", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("to", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("cc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("bcc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("subject", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, messageId: GraphQLID, userId: GraphQLID, sudoId: GraphQLID, emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, algorithm: String, keyId: String, direction: EmailMessageDirection, seen: Bool, state: EmailMessageState, clientRefId: String? = nil, from: [String], replyTo: [String], to: [String], cc: [String], bcc: [String], subject: String? = nil) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "messageId": messageId, "userId": userId, "sudoId": sudoId, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "algorithm": algorithm, "keyId": keyId, "direction": direction, "seen": seen, "state": state, "clientRefId": clientRefId, "from": from, "replyTo": replyTo, "to": to, "cc": cc, "bcc": bcc, "subject": subject])
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

      internal var messageId: GraphQLID {
        get {
          return snapshot["messageId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "messageId")
        }
      }

      internal var userId: GraphQLID {
        get {
          return snapshot["userId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "userId")
        }
      }

      internal var sudoId: GraphQLID {
        get {
          return snapshot["sudoId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "sudoId")
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

      internal var from: [String] {
        get {
          return snapshot["from"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "from")
        }
      }

      internal var replyTo: [String] {
        get {
          return snapshot["replyTo"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "replyTo")
        }
      }

      internal var to: [String] {
        get {
          return snapshot["to"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "to")
        }
      }

      internal var cc: [String] {
        get {
          return snapshot["cc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "cc")
        }
      }

      internal var bcc: [String] {
        get {
          return snapshot["bcc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "bcc")
        }
      }

      internal var subject: String? {
        get {
          return snapshot["subject"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "subject")
        }
      }
    }
  }
}

internal final class OnEmailMessageCreatedWithDirectionSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailMessageCreatedWithDirection($userId: String!, $direction: EmailMessageDirection!) {\n  onEmailMessageCreated(userId: $userId, direction: $direction) {\n    __typename\n    id\n    messageId\n    userId\n    sudoId\n    emailAddressId\n    version\n    createdAtEpochMs\n    updatedAtEpochMs\n    algorithm\n    keyId\n    direction\n    seen\n    state\n    clientRefId\n    from\n    replyTo\n    to\n    cc\n    bcc\n    subject\n  }\n}"

  internal var userId: String
  internal var direction: EmailMessageDirection

  internal init(userId: String, direction: EmailMessageDirection) {
    self.userId = userId
    self.direction = direction
  }

  internal var variables: GraphQLMap? {
    return ["userId": userId, "direction": direction]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Subscription"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("onEmailMessageCreated", arguments: ["userId": GraphQLVariable("userId"), "direction": GraphQLVariable("direction")], type: .object(OnEmailMessageCreated.selections)),
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
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("messageId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("userId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("sudoId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("from", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("replyTo", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("to", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("cc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("bcc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("subject", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, messageId: GraphQLID, userId: GraphQLID, sudoId: GraphQLID, emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, algorithm: String, keyId: String, direction: EmailMessageDirection, seen: Bool, state: EmailMessageState, clientRefId: String? = nil, from: [String], replyTo: [String], to: [String], cc: [String], bcc: [String], subject: String? = nil) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "messageId": messageId, "userId": userId, "sudoId": sudoId, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "algorithm": algorithm, "keyId": keyId, "direction": direction, "seen": seen, "state": state, "clientRefId": clientRefId, "from": from, "replyTo": replyTo, "to": to, "cc": cc, "bcc": bcc, "subject": subject])
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

      internal var messageId: GraphQLID {
        get {
          return snapshot["messageId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "messageId")
        }
      }

      internal var userId: GraphQLID {
        get {
          return snapshot["userId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "userId")
        }
      }

      internal var sudoId: GraphQLID {
        get {
          return snapshot["sudoId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "sudoId")
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

      internal var from: [String] {
        get {
          return snapshot["from"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "from")
        }
      }

      internal var replyTo: [String] {
        get {
          return snapshot["replyTo"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "replyTo")
        }
      }

      internal var to: [String] {
        get {
          return snapshot["to"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "to")
        }
      }

      internal var cc: [String] {
        get {
          return snapshot["cc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "cc")
        }
      }

      internal var bcc: [String] {
        get {
          return snapshot["bcc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "bcc")
        }
      }

      internal var subject: String? {
        get {
          return snapshot["subject"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "subject")
        }
      }
    }
  }
}

internal final class OnEmailMessageDeletedWithIdSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailMessageDeletedWithId($userId: ID!, $id: ID!) {\n  onEmailMessageDeleted(userId: $userId, id: $id) {\n    __typename\n    id\n    messageId\n    userId\n    sudoId\n    emailAddressId\n    version\n    createdAtEpochMs\n    updatedAtEpochMs\n    algorithm\n    keyId\n    direction\n    seen\n    state\n    clientRefId\n    from\n    replyTo\n    to\n    cc\n    bcc\n    subject\n  }\n}"

  internal var userId: GraphQLID
  internal var id: GraphQLID

  internal init(userId: GraphQLID, id: GraphQLID) {
    self.userId = userId
    self.id = id
  }

  internal var variables: GraphQLMap? {
    return ["userId": userId, "id": id]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Subscription"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("onEmailMessageDeleted", arguments: ["userId": GraphQLVariable("userId"), "id": GraphQLVariable("id")], type: .object(OnEmailMessageDeleted.selections)),
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
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("messageId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("userId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("sudoId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("from", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("replyTo", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("to", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("cc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("bcc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("subject", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, messageId: GraphQLID, userId: GraphQLID, sudoId: GraphQLID, emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, algorithm: String, keyId: String, direction: EmailMessageDirection, seen: Bool, state: EmailMessageState, clientRefId: String? = nil, from: [String], replyTo: [String], to: [String], cc: [String], bcc: [String], subject: String? = nil) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "messageId": messageId, "userId": userId, "sudoId": sudoId, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "algorithm": algorithm, "keyId": keyId, "direction": direction, "seen": seen, "state": state, "clientRefId": clientRefId, "from": from, "replyTo": replyTo, "to": to, "cc": cc, "bcc": bcc, "subject": subject])
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

      internal var messageId: GraphQLID {
        get {
          return snapshot["messageId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "messageId")
        }
      }

      internal var userId: GraphQLID {
        get {
          return snapshot["userId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "userId")
        }
      }

      internal var sudoId: GraphQLID {
        get {
          return snapshot["sudoId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "sudoId")
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

      internal var from: [String] {
        get {
          return snapshot["from"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "from")
        }
      }

      internal var replyTo: [String] {
        get {
          return snapshot["replyTo"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "replyTo")
        }
      }

      internal var to: [String] {
        get {
          return snapshot["to"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "to")
        }
      }

      internal var cc: [String] {
        get {
          return snapshot["cc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "cc")
        }
      }

      internal var bcc: [String] {
        get {
          return snapshot["bcc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "bcc")
        }
      }

      internal var subject: String? {
        get {
          return snapshot["subject"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "subject")
        }
      }
    }
  }
}

internal final class OnEmailMessageDeletedSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailMessageDeleted($userId: ID!) {\n  onEmailMessageDeleted(userId: $userId) {\n    __typename\n    id\n    messageId\n    userId\n    sudoId\n    emailAddressId\n    version\n    createdAtEpochMs\n    updatedAtEpochMs\n    algorithm\n    keyId\n    direction\n    seen\n    state\n    clientRefId\n    from\n    replyTo\n    to\n    cc\n    bcc\n    subject\n  }\n}"

  internal var userId: GraphQLID

  internal init(userId: GraphQLID) {
    self.userId = userId
  }

  internal var variables: GraphQLMap? {
    return ["userId": userId]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Subscription"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("onEmailMessageDeleted", arguments: ["userId": GraphQLVariable("userId")], type: .object(OnEmailMessageDeleted.selections)),
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
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("messageId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("userId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("sudoId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("emailAddressId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("from", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("replyTo", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("to", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("cc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("bcc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("subject", type: .scalar(String.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, messageId: GraphQLID, userId: GraphQLID, sudoId: GraphQLID, emailAddressId: GraphQLID, version: Int, createdAtEpochMs: Double, updatedAtEpochMs: Double, algorithm: String, keyId: String, direction: EmailMessageDirection, seen: Bool, state: EmailMessageState, clientRefId: String? = nil, from: [String], replyTo: [String], to: [String], cc: [String], bcc: [String], subject: String? = nil) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "messageId": messageId, "userId": userId, "sudoId": sudoId, "emailAddressId": emailAddressId, "version": version, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "algorithm": algorithm, "keyId": keyId, "direction": direction, "seen": seen, "state": state, "clientRefId": clientRefId, "from": from, "replyTo": replyTo, "to": to, "cc": cc, "bcc": bcc, "subject": subject])
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

      internal var messageId: GraphQLID {
        get {
          return snapshot["messageId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "messageId")
        }
      }

      internal var userId: GraphQLID {
        get {
          return snapshot["userId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "userId")
        }
      }

      internal var sudoId: GraphQLID {
        get {
          return snapshot["sudoId"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "sudoId")
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

      internal var from: [String] {
        get {
          return snapshot["from"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "from")
        }
      }

      internal var replyTo: [String] {
        get {
          return snapshot["replyTo"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "replyTo")
        }
      }

      internal var to: [String] {
        get {
          return snapshot["to"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "to")
        }
      }

      internal var cc: [String] {
        get {
          return snapshot["cc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "cc")
        }
      }

      internal var bcc: [String] {
        get {
          return snapshot["bcc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "bcc")
        }
      }

      internal var subject: String? {
        get {
          return snapshot["subject"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "subject")
        }
      }
    }
  }
}
