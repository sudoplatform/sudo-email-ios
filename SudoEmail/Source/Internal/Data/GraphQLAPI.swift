// swiftlint:disable all
//  This file was automatically generated and should not be edited.

import AWSAppSync

/// Input definition to search for available email addresses by search.
internal struct SearchEmailAddressInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(localPart: String, domain: Optional<String?> = nil, limit: Optional<Int?> = nil) {
    graphQLMap = ["localPart": localPart, "domain": domain, "limit": limit]
  }

  /// Local part of the email address.
  internal var localPart: String {
    get {
      return graphQLMap["localPart"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "localPart")
    }
  }

  /// Domain of the email to search for.
  internal var domain: Optional<String?> {
    get {
      return graphQLMap["domain"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "domain")
    }
  }

  /// Limit the number of search results.
  internal var limit: Optional<Int?> {
    get {
      return graphQLMap["limit"] as! Optional<Int?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "limit")
    }
  }
}

internal struct EmailAddressFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(address: Optional<StringFilterInput?> = nil, and: Optional<[EmailAddressFilterInput?]?> = nil, or: Optional<[EmailAddressFilterInput?]?> = nil, not: Optional<EmailAddressFilterInput?> = nil) {
    graphQLMap = ["address": address, "and": and, "or": or, "not": not]
  }

  internal var address: Optional<StringFilterInput?> {
    get {
      return graphQLMap["address"] as! Optional<StringFilterInput?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address")
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

internal struct StringFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(ne: Optional<String?> = nil, eq: Optional<String?> = nil, contains: Optional<String?> = nil, notContains: Optional<String?> = nil, beginsWith: Optional<String?> = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "contains": contains, "notContains": notContains, "beginsWith": beginsWith]
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

  internal var contains: Optional<String?> {
    get {
      return graphQLMap["contains"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  internal var notContains: Optional<String?> {
    get {
      return graphQLMap["notContains"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
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

/// Possible directions for a email message.
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

/// Possible states for an email message.
/// QUEUED      - Outbound message queued sending upstream.
/// SENT        - Outbound message sent upstream.
/// DELIVERED   - Outbound message acknowledged as delivered upstream.
/// UNDELIVERED - Outbound message acknowledged as undelivered upstream.
/// FAILED      - Outbound message acknowledged as failed upstream.
/// RECEIVED    - Inbound message stored locally.
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

internal struct EmailMessageFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(keyId: Optional<IDFilterInput?> = nil, direction: Optional<EmailMessageDirectionFilterInput?> = nil, seen: Optional<BooleanFilterInput?> = nil, state: Optional<EmailMessageStateFilterInput?> = nil, and: Optional<[EmailMessageFilterInput?]?> = nil, or: Optional<[EmailMessageFilterInput?]?> = nil, not: Optional<EmailMessageFilterInput?> = nil) {
    graphQLMap = ["keyId": keyId, "direction": direction, "seen": seen, "state": state, "and": and, "or": or, "not": not]
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

internal struct IDFilterInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(ne: Optional<GraphQLID?> = nil, eq: Optional<GraphQLID?> = nil, contains: Optional<GraphQLID?> = nil, notContains: Optional<GraphQLID?> = nil, beginsWith: Optional<GraphQLID?> = nil) {
    graphQLMap = ["ne": ne, "eq": eq, "contains": contains, "notContains": notContains, "beginsWith": beginsWith]
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

  internal var contains: Optional<GraphQLID?> {
    get {
      return graphQLMap["contains"] as! Optional<GraphQLID?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "contains")
    }
  }

  internal var notContains: Optional<GraphQLID?> {
    get {
      return graphQLMap["notContains"] as! Optional<GraphQLID?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "notContains")
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

/// Input definition to provision a email address.
internal struct ProvisionEmailAddressInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(address: String, keyRingId: String, ownerProofs: [String]) {
    graphQLMap = ["address": address, "keyRingId": keyRingId, "ownerProofs": ownerProofs]
  }

  /// Address in format 'local-part@dmain' of the email to provision.
  internal var address: String {
    get {
      return graphQLMap["address"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address")
    }
  }

  /// Key ring ID that dictates which keys the child resources of this email address will be encrypted with.
  internal var keyRingId: String {
    get {
      return graphQLMap["keyRingId"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "keyRingId")
    }
  }

  /// Ownership proof tokens
  internal var ownerProofs: [String] {
    get {
      return graphQLMap["ownerProofs"] as! [String]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "ownerProofs")
    }
  }
}

/// Input definition to delete an email address.
internal struct DeprovisionEmailAddressInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(address: String) {
    graphQLMap = ["address": address]
  }

  /// Address in format 'local-part@dmain' of the email to delete.
  internal var address: String {
    get {
      return graphQLMap["address"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address")
    }
  }
}

/// Input definition to send a message.
internal struct SendEmailMessageInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(address: String, message: S3EmailObjectInput, clientRefId: Optional<String?> = nil) {
    graphQLMap = ["address": address, "message": message, "clientRefId": clientRefId]
  }

  /// Source email address.
  internal var address: String {
    get {
      return graphQLMap["address"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "address")
    }
  }

  /// Pointer to S3 Media object posted to S3 by client.
  internal var message: S3EmailObjectInput {
    get {
      return graphQLMap["message"] as! S3EmailObjectInput
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "message")
    }
  }

  /// ID used for the client to subscribe to specific events.
  internal var clientRefId: Optional<String?> {
    get {
      return graphQLMap["clientRefId"] as! Optional<String?>
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "clientRefId")
    }
  }
}

/// Representation of the S3 Email Object.
internal struct S3EmailObjectInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(key: String, bucket: String, region: String) {
    graphQLMap = ["key": key, "bucket": bucket, "region": region]
  }

  /// Key of object in S3.
  internal var key: String {
    get {
      return graphQLMap["key"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "key")
    }
  }

  /// Name of S3 bucket.
  internal var bucket: String {
    get {
      return graphQLMap["bucket"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "bucket")
    }
  }

  /// Region S3 bucket is located in.
  internal var region: String {
    get {
      return graphQLMap["region"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "region")
    }
  }
}

/// Input definition to delete a message.
internal struct DeleteEmailMessageInput: GraphQLMapConvertible {
  internal var graphQLMap: GraphQLMap

  internal init(id: GraphQLID) {
    graphQLMap = ["id": id]
  }

  /// v4 UUID assigned to message record.
  internal var id: GraphQLID {
    get {
      return graphQLMap["id"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
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

    /// Returns an array of supported domains.
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

internal final class SearchForEmailAddressQuery: GraphQLQuery {
  internal static let operationString =
    "query SearchForEmailAddress($input: SearchEmailAddressInput!) {\n  searchForEmailAddress(input: $input) {\n    __typename\n    localPart\n    domain\n    results\n    limit\n  }\n}"

  internal var input: SearchEmailAddressInput

  internal init(input: SearchEmailAddressInput) {
    self.input = input
  }

  internal var variables: GraphQLMap? {
    return ["input": input]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("searchForEmailAddress", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(SearchForEmailAddress.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(searchForEmailAddress: SearchForEmailAddress) {
      self.init(snapshot: ["__typename": "Query", "searchForEmailAddress": searchForEmailAddress.snapshot])
    }

    /// Search for available email address(es) for given criteria.
    internal var searchForEmailAddress: SearchForEmailAddress {
      get {
        return SearchForEmailAddress(snapshot: snapshot["searchForEmailAddress"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "searchForEmailAddress")
      }
    }

    internal struct SearchForEmailAddress: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailAddressSearch"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("localPart", type: .nonNull(.scalar(String.self))),
        GraphQLField("domain", type: .scalar(String.self)),
        GraphQLField("results", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("limit", type: .scalar(Int.self)),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(localPart: String, domain: String? = nil, results: [String], limit: Int? = nil) {
        self.init(snapshot: ["__typename": "EmailAddressSearch", "localPart": localPart, "domain": domain, "results": results, "limit": limit])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Local part of the email address.
      internal var localPart: String {
        get {
          return snapshot["localPart"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "localPart")
        }
      }

      /// Domain of the email address.
      internal var domain: String? {
        get {
          return snapshot["domain"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "domain")
        }
      }

      /// Array of available email addresses.
      internal var results: [String] {
        get {
          return snapshot["results"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "results")
        }
      }

      /// Limit the number of search results.
      internal var limit: Int? {
        get {
          return snapshot["limit"] as? Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "limit")
        }
      }
    }
  }
}

internal final class GetEmailAddressQuery: GraphQLQuery {
  internal static let operationString =
    "query GetEmailAddress($address: String!) {\n  getEmailAddress(address: $address) {\n    __typename\n    owner\n    owners {\n      __typename\n      id\n      issuer\n    }\n    address\n    identityId\n    keyRingId\n    createdAtEpochMs\n    updatedAtEpochMs\n    version\n  }\n}"

  internal var address: String

  internal init(address: String) {
    self.address = address
  }

  internal var variables: GraphQLMap? {
    return ["address": address]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getEmailAddress", arguments: ["address": GraphQLVariable("address")], type: .object(GetEmailAddress.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getEmailAddress: GetEmailAddress? = nil) {
      self.init(snapshot: ["__typename": "Query", "getEmailAddress": getEmailAddress.flatMap { $0.snapshot }])
    }

    /// Get an email address record by address.
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
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("identityId", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: GraphQLID, owners: [Owner], address: String, identityId: String, keyRingId: String, createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Int) {
        self.init(snapshot: ["__typename": "EmailAddress", "owner": owner, "owners": owners.map { $0.snapshot }, "address": address, "identityId": identityId, "keyRingId": keyRingId, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// v4 UUID of user that owns the email address resource.
      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      /// Array of owner Ids that are extracted from the owner proofs to tie an email address to a Sudo.
      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      /// Address in format 'local-part@dmain' of the email.
      internal var address: String {
        get {
          return snapshot["address"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "address")
        }
      }

      /// The identityId of the user that owns the email address resource.
      internal var identityId: String {
        get {
          return snapshot["identityId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "identityId")
        }
      }

      /// Key ring ID that dictates which keys the child resources of this email address will be encrypted with.
      internal var keyRingId: String {
        get {
          return snapshot["keyRingId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyRingId")
        }
      }

      /// Time in milliseconds since 1970-01-01T00:00:00Z when object was created.
      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      /// Time in milliseconds since 1970-01-01T00:00:00Z when object was last updated.
      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      /// Version of this email address record, increments on update.
      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
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
    "query ListEmailAddresses($filter: EmailAddressFilterInput, $limit: Int, $nextToken: String) {\n  listEmailAddresses(filter: $filter, limit: $limit, nextToken: $nextToken) {\n    __typename\n    items {\n      __typename\n      owner\n      owners {\n        __typename\n        id\n        issuer\n      }\n      address\n      identityId\n      keyRingId\n      createdAtEpochMs\n      updatedAtEpochMs\n      version\n    }\n    nextToken\n  }\n}"

  internal var filter: EmailAddressFilterInput?
  internal var limit: Int?
  internal var nextToken: String?

  internal init(filter: EmailAddressFilterInput? = nil, limit: Int? = nil, nextToken: String? = nil) {
    self.filter = filter
    self.limit = limit
    self.nextToken = nextToken
  }

  internal var variables: GraphQLMap? {
    return ["filter": filter, "limit": limit, "nextToken": nextToken]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("listEmailAddresses", arguments: ["filter": GraphQLVariable("filter"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken")], type: .nonNull(.object(ListEmailAddress.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(listEmailAddresses: ListEmailAddress) {
      self.init(snapshot: ["__typename": "Query", "listEmailAddresses": listEmailAddresses.snapshot])
    }

    /// Returns a list of email addresses.
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
          GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
          GraphQLField("address", type: .nonNull(.scalar(String.self))),
          GraphQLField("identityId", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(owner: GraphQLID, owners: [Owner], address: String, identityId: String, keyRingId: String, createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Int) {
          self.init(snapshot: ["__typename": "EmailAddress", "owner": owner, "owners": owners.map { $0.snapshot }, "address": address, "identityId": identityId, "keyRingId": keyRingId, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// v4 UUID of user that owns the email address resource.
        internal var owner: GraphQLID {
          get {
            return snapshot["owner"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "owner")
          }
        }

        /// Array of owner Ids that are extracted from the owner proofs to tie an email address to a Sudo.
        internal var owners: [Owner] {
          get {
            return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
          }
        }

        /// Address in format 'local-part@dmain' of the email.
        internal var address: String {
          get {
            return snapshot["address"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "address")
          }
        }

        /// The identityId of the user that owns the email address resource.
        internal var identityId: String {
          get {
            return snapshot["identityId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "identityId")
          }
        }

        /// Key ring ID that dictates which keys the child resources of this email address will be encrypted with.
        internal var keyRingId: String {
          get {
            return snapshot["keyRingId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyRingId")
          }
        }

        /// Time in milliseconds since 1970-01-01T00:00:00Z when object was created.
        internal var createdAtEpochMs: Double {
          get {
            return snapshot["createdAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
          }
        }

        /// Time in milliseconds since 1970-01-01T00:00:00Z when object was last updated.
        internal var updatedAtEpochMs: Double {
          get {
            return snapshot["updatedAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
          }
        }

        /// Version of this email address record, increments on update.
        internal var version: Int {
          get {
            return snapshot["version"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "version")
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
    "query GetEmailMessage($id: ID!, $keyId: String!) {\n  getEmailMessage(id: $id, keyId: $keyId) {\n    __typename\n    id\n    sealedId\n    owner\n    address\n    from\n    to\n    cc\n    bcc\n    direction\n    subject\n    seen\n    state\n    algorithm\n    keyId\n    clientRefId\n    createdAtEpochMs\n    updatedAtEpochMs\n    version\n  }\n}"

  internal var id: GraphQLID
  internal var keyId: String

  internal init(id: GraphQLID, keyId: String) {
    self.id = id
    self.keyId = keyId
  }

  internal var variables: GraphQLMap? {
    return ["id": id, "keyId": keyId]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("getEmailMessage", arguments: ["id": GraphQLVariable("id"), "keyId": GraphQLVariable("keyId")], type: .object(GetEmailMessage.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(getEmailMessage: GetEmailMessage? = nil) {
      self.init(snapshot: ["__typename": "Query", "getEmailMessage": getEmailMessage.flatMap { $0.snapshot }])
    }

    /// Get an email message record by ID.
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
        GraphQLField("sealedId", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("from", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("to", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("cc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("bcc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("subject", type: .scalar(String.self)),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, sealedId: String, owner: GraphQLID, address: String, from: [String], to: [String], cc: [String], bcc: [String], direction: EmailMessageDirection, subject: String? = nil, seen: Bool, state: EmailMessageState, algorithm: String, keyId: String, clientRefId: String? = nil, createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Int) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "sealedId": sealedId, "owner": owner, "address": address, "from": from, "to": to, "cc": cc, "bcc": bcc, "direction": direction, "subject": subject, "seen": seen, "state": state, "algorithm": algorithm, "keyId": keyId, "clientRefId": clientRefId, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// UNSEALED: v4 UUID assigned to message record.
      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      /// UNSEALED: v4 UUID composite key.
      internal var sealedId: String {
        get {
          return snapshot["sealedId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "sealedId")
        }
      }

      /// UNSEALED: v4 UUID of user that owns the message resource.
      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      /// UNSEALED: The email address related to the message resource.
      internal var address: String {
        get {
          return snapshot["address"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "address")
        }
      }

      /// SEALED: from email address(es).
      internal var from: [String] {
        get {
          return snapshot["from"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "from")
        }
      }

      /// SEALED: to email address(es).
      internal var to: [String] {
        get {
          return snapshot["to"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "to")
        }
      }

      /// SEALED: cc email address(es).
      internal var cc: [String] {
        get {
          return snapshot["cc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "cc")
        }
      }

      /// SEALED: bcc email address(es).
      internal var bcc: [String] {
        get {
          return snapshot["bcc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "bcc")
        }
      }

      /// UNSEALED: Direction of message.
      internal var direction: EmailMessageDirection {
        get {
          return snapshot["direction"]! as! EmailMessageDirection
        }
        set {
          snapshot.updateValue(newValue, forKey: "direction")
        }
      }

      /// SEALED: Email message subject.
      internal var subject: String? {
        get {
          return snapshot["subject"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "subject")
        }
      }

      /// UNSEALED: Has this message been marked as seen on client.
      internal var seen: Bool {
        get {
          return snapshot["seen"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "seen")
        }
      }

      /// UNSEALED: State of message record.
      internal var state: EmailMessageState {
        get {
          return snapshot["state"]! as! EmailMessageState
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      /// UNSEALED: Algorithm descriptor describing internal and symmetric key encryption, e.g RSAEncryptionOAEPSHA256AESGCM.
      internal var algorithm: String {
        get {
          return snapshot["algorithm"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "algorithm")
        }
      }

      /// UNSEALED: Client generated key ID for the internal key.
      internal var keyId: String {
        get {
          return snapshot["keyId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyId")
        }
      }

      /// UNSEALED: ID used for the client to subscribe to specific events.
      internal var clientRefId: String? {
        get {
          return snapshot["clientRefId"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "clientRefId")
        }
      }

      /// UNSEALED: Time in milliseconds since 1970-01-01T00:00:00Z when object was created.
      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      /// UNSEALED: Time in milliseconds since 1970-01-01T00:00:00Z when object was last updated.
      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      /// UNSEALED: Version of this object, increments on update.
      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }
    }
  }
}

internal final class ListEmailMessagesQuery: GraphQLQuery {
  internal static let operationString =
    "query ListEmailMessages($filter: EmailMessageFilterInput, $limit: Int, $nextToken: String) {\n  listEmailMessages(filter: $filter, limit: $limit, nextToken: $nextToken) {\n    __typename\n    items {\n      __typename\n      id\n      sealedId\n      owner\n      address\n      from\n      to\n      cc\n      bcc\n      direction\n      subject\n      seen\n      state\n      algorithm\n      keyId\n      clientRefId\n      createdAtEpochMs\n      updatedAtEpochMs\n      version\n    }\n    nextToken\n  }\n}"

  internal var filter: EmailMessageFilterInput?
  internal var limit: Int?
  internal var nextToken: String?

  internal init(filter: EmailMessageFilterInput? = nil, limit: Int? = nil, nextToken: String? = nil) {
    self.filter = filter
    self.limit = limit
    self.nextToken = nextToken
  }

  internal var variables: GraphQLMap? {
    return ["filter": filter, "limit": limit, "nextToken": nextToken]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Query"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("listEmailMessages", arguments: ["filter": GraphQLVariable("filter"), "limit": GraphQLVariable("limit"), "nextToken": GraphQLVariable("nextToken")], type: .nonNull(.object(ListEmailMessage.selections))),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(listEmailMessages: ListEmailMessage) {
      self.init(snapshot: ["__typename": "Query", "listEmailMessages": listEmailMessages.snapshot])
    }

    /// Returns a list of email messages.
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
          GraphQLField("sealedId", type: .nonNull(.scalar(String.self))),
          GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("address", type: .nonNull(.scalar(String.self))),
          GraphQLField("from", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("to", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("cc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("bcc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
          GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
          GraphQLField("subject", type: .scalar(String.self)),
          GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
          GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
          GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
          GraphQLField("clientRefId", type: .scalar(String.self)),
          GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
          GraphQLField("version", type: .nonNull(.scalar(Int.self))),
        ]

        internal var snapshot: Snapshot

        internal init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        internal init(id: GraphQLID, sealedId: String, owner: GraphQLID, address: String, from: [String], to: [String], cc: [String], bcc: [String], direction: EmailMessageDirection, subject: String? = nil, seen: Bool, state: EmailMessageState, algorithm: String, keyId: String, clientRefId: String? = nil, createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Int) {
          self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "sealedId": sealedId, "owner": owner, "address": address, "from": from, "to": to, "cc": cc, "bcc": bcc, "direction": direction, "subject": subject, "seen": seen, "state": state, "algorithm": algorithm, "keyId": keyId, "clientRefId": clientRefId, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version])
        }

        internal var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// UNSEALED: v4 UUID assigned to message record.
        internal var id: GraphQLID {
          get {
            return snapshot["id"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "id")
          }
        }

        /// UNSEALED: v4 UUID composite key.
        internal var sealedId: String {
          get {
            return snapshot["sealedId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "sealedId")
          }
        }

        /// UNSEALED: v4 UUID of user that owns the message resource.
        internal var owner: GraphQLID {
          get {
            return snapshot["owner"]! as! GraphQLID
          }
          set {
            snapshot.updateValue(newValue, forKey: "owner")
          }
        }

        /// UNSEALED: The email address related to the message resource.
        internal var address: String {
          get {
            return snapshot["address"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "address")
          }
        }

        /// SEALED: from email address(es).
        internal var from: [String] {
          get {
            return snapshot["from"]! as! [String]
          }
          set {
            snapshot.updateValue(newValue, forKey: "from")
          }
        }

        /// SEALED: to email address(es).
        internal var to: [String] {
          get {
            return snapshot["to"]! as! [String]
          }
          set {
            snapshot.updateValue(newValue, forKey: "to")
          }
        }

        /// SEALED: cc email address(es).
        internal var cc: [String] {
          get {
            return snapshot["cc"]! as! [String]
          }
          set {
            snapshot.updateValue(newValue, forKey: "cc")
          }
        }

        /// SEALED: bcc email address(es).
        internal var bcc: [String] {
          get {
            return snapshot["bcc"]! as! [String]
          }
          set {
            snapshot.updateValue(newValue, forKey: "bcc")
          }
        }

        /// UNSEALED: Direction of message.
        internal var direction: EmailMessageDirection {
          get {
            return snapshot["direction"]! as! EmailMessageDirection
          }
          set {
            snapshot.updateValue(newValue, forKey: "direction")
          }
        }

        /// SEALED: Email message subject.
        internal var subject: String? {
          get {
            return snapshot["subject"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "subject")
          }
        }

        /// UNSEALED: Has this message been marked as seen on client.
        internal var seen: Bool {
          get {
            return snapshot["seen"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "seen")
          }
        }

        /// UNSEALED: State of message record.
        internal var state: EmailMessageState {
          get {
            return snapshot["state"]! as! EmailMessageState
          }
          set {
            snapshot.updateValue(newValue, forKey: "state")
          }
        }

        /// UNSEALED: Algorithm descriptor describing internal and symmetric key encryption, e.g RSAEncryptionOAEPSHA256AESGCM.
        internal var algorithm: String {
          get {
            return snapshot["algorithm"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "algorithm")
          }
        }

        /// UNSEALED: Client generated key ID for the internal key.
        internal var keyId: String {
          get {
            return snapshot["keyId"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "keyId")
          }
        }

        /// UNSEALED: ID used for the client to subscribe to specific events.
        internal var clientRefId: String? {
          get {
            return snapshot["clientRefId"] as? String
          }
          set {
            snapshot.updateValue(newValue, forKey: "clientRefId")
          }
        }

        /// UNSEALED: Time in milliseconds since 1970-01-01T00:00:00Z when object was created.
        internal var createdAtEpochMs: Double {
          get {
            return snapshot["createdAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
          }
        }

        /// UNSEALED: Time in milliseconds since 1970-01-01T00:00:00Z when object was last updated.
        internal var updatedAtEpochMs: Double {
          get {
            return snapshot["updatedAtEpochMs"]! as! Double
          }
          set {
            snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
          }
        }

        /// UNSEALED: Version of this object, increments on update.
        internal var version: Int {
          get {
            return snapshot["version"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "version")
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
    "mutation ProvisionEmailAddress($input: ProvisionEmailAddressInput!) {\n  provisionEmailAddress(input: $input) {\n    __typename\n    owner\n    owners {\n      __typename\n      id\n      issuer\n    }\n    address\n    identityId\n    keyRingId\n    createdAtEpochMs\n    updatedAtEpochMs\n    version\n  }\n}"

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

    /// Provision email address.
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
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("identityId", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: GraphQLID, owners: [Owner], address: String, identityId: String, keyRingId: String, createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Int) {
        self.init(snapshot: ["__typename": "EmailAddress", "owner": owner, "owners": owners.map { $0.snapshot }, "address": address, "identityId": identityId, "keyRingId": keyRingId, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// v4 UUID of user that owns the email address resource.
      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      /// Array of owner Ids that are extracted from the owner proofs to tie an email address to a Sudo.
      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      /// Address in format 'local-part@dmain' of the email.
      internal var address: String {
        get {
          return snapshot["address"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "address")
        }
      }

      /// The identityId of the user that owns the email address resource.
      internal var identityId: String {
        get {
          return snapshot["identityId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "identityId")
        }
      }

      /// Key ring ID that dictates which keys the child resources of this email address will be encrypted with.
      internal var keyRingId: String {
        get {
          return snapshot["keyRingId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyRingId")
        }
      }

      /// Time in milliseconds since 1970-01-01T00:00:00Z when object was created.
      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      /// Time in milliseconds since 1970-01-01T00:00:00Z when object was last updated.
      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      /// Version of this email address record, increments on update.
      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
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
    "mutation DeprovisionEmailAddress($input: DeprovisionEmailAddressInput!) {\n  deprovisionEmailAddress(input: $input) {\n    __typename\n    owner\n    owners {\n      __typename\n      id\n      issuer\n    }\n    address\n    identityId\n    keyRingId\n    createdAtEpochMs\n    updatedAtEpochMs\n    version\n  }\n}"

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

    /// Deprovision email address.
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
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("identityId", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: GraphQLID, owners: [Owner], address: String, identityId: String, keyRingId: String, createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Int) {
        self.init(snapshot: ["__typename": "EmailAddress", "owner": owner, "owners": owners.map { $0.snapshot }, "address": address, "identityId": identityId, "keyRingId": keyRingId, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// v4 UUID of user that owns the email address resource.
      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      /// Array of owner Ids that are extracted from the owner proofs to tie an email address to a Sudo.
      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      /// Address in format 'local-part@dmain' of the email.
      internal var address: String {
        get {
          return snapshot["address"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "address")
        }
      }

      /// The identityId of the user that owns the email address resource.
      internal var identityId: String {
        get {
          return snapshot["identityId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "identityId")
        }
      }

      /// Key ring ID that dictates which keys the child resources of this email address will be encrypted with.
      internal var keyRingId: String {
        get {
          return snapshot["keyRingId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyRingId")
        }
      }

      /// Time in milliseconds since 1970-01-01T00:00:00Z when object was created.
      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      /// Time in milliseconds since 1970-01-01T00:00:00Z when object was last updated.
      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      /// Version of this email address record, increments on update.
      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
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

    /// Send email message.
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

    /// Delete email message.
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

internal final class OnEmailAddressSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailAddress($owner: String!) {\n  onEmailAddress(owner: $owner) {\n    __typename\n    owner\n    owners {\n      __typename\n      id\n      issuer\n    }\n    address\n    identityId\n    keyRingId\n    createdAtEpochMs\n    updatedAtEpochMs\n    version\n  }\n}"

  internal var owner: String

  internal init(owner: String) {
    self.owner = owner
  }

  internal var variables: GraphQLMap? {
    return ["owner": owner]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Subscription"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("onEmailAddress", arguments: ["owner": GraphQLVariable("owner")], type: .object(OnEmailAddress.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(onEmailAddress: OnEmailAddress? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onEmailAddress": onEmailAddress.flatMap { $0.snapshot }])
    }

    /// Owner id for the current logged in user.
    /// ID used for the client to subscribe to specific provision events.
    internal var onEmailAddress: OnEmailAddress? {
      get {
        return (snapshot["onEmailAddress"] as? Snapshot).flatMap { OnEmailAddress(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "onEmailAddress")
      }
    }

    internal struct OnEmailAddress: GraphQLSelectionSet {
      internal static let possibleTypes = ["EmailAddress"]

      internal static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("owners", type: .nonNull(.list(.nonNull(.object(Owner.selections))))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("identityId", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyRingId", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(owner: GraphQLID, owners: [Owner], address: String, identityId: String, keyRingId: String, createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Int) {
        self.init(snapshot: ["__typename": "EmailAddress", "owner": owner, "owners": owners.map { $0.snapshot }, "address": address, "identityId": identityId, "keyRingId": keyRingId, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// v4 UUID of user that owns the email address resource.
      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      /// Array of owner Ids that are extracted from the owner proofs to tie an email address to a Sudo.
      internal var owners: [Owner] {
        get {
          return (snapshot["owners"] as! [Snapshot]).map { Owner(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue.map { $0.snapshot }, forKey: "owners")
        }
      }

      /// Address in format 'local-part@dmain' of the email.
      internal var address: String {
        get {
          return snapshot["address"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "address")
        }
      }

      /// The identityId of the user that owns the email address resource.
      internal var identityId: String {
        get {
          return snapshot["identityId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "identityId")
        }
      }

      /// Key ring ID that dictates which keys the child resources of this email address will be encrypted with.
      internal var keyRingId: String {
        get {
          return snapshot["keyRingId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyRingId")
        }
      }

      /// Time in milliseconds since 1970-01-01T00:00:00Z when object was created.
      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      /// Time in milliseconds since 1970-01-01T00:00:00Z when object was last updated.
      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      /// Version of this email address record, increments on update.
      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
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
    "subscription OnEmailMessageCreated($owner: String!) {\n  onEmailMessageCreated(owner: $owner) {\n    __typename\n    id\n    sealedId\n    owner\n    address\n    from\n    to\n    cc\n    bcc\n    direction\n    subject\n    seen\n    state\n    algorithm\n    keyId\n    clientRefId\n    createdAtEpochMs\n    updatedAtEpochMs\n    version\n  }\n}"

  internal var owner: String

  internal init(owner: String) {
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

    /// Owner id for the current logged in user.
    /// EmailMessageDirection used for the client to subscribe to inbound or outbound specific message events.
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
        GraphQLField("sealedId", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("from", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("to", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("cc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("bcc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("subject", type: .scalar(String.self)),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, sealedId: String, owner: GraphQLID, address: String, from: [String], to: [String], cc: [String], bcc: [String], direction: EmailMessageDirection, subject: String? = nil, seen: Bool, state: EmailMessageState, algorithm: String, keyId: String, clientRefId: String? = nil, createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Int) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "sealedId": sealedId, "owner": owner, "address": address, "from": from, "to": to, "cc": cc, "bcc": bcc, "direction": direction, "subject": subject, "seen": seen, "state": state, "algorithm": algorithm, "keyId": keyId, "clientRefId": clientRefId, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// UNSEALED: v4 UUID assigned to message record.
      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      /// UNSEALED: v4 UUID composite key.
      internal var sealedId: String {
        get {
          return snapshot["sealedId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "sealedId")
        }
      }

      /// UNSEALED: v4 UUID of user that owns the message resource.
      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      /// UNSEALED: The email address related to the message resource.
      internal var address: String {
        get {
          return snapshot["address"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "address")
        }
      }

      /// SEALED: from email address(es).
      internal var from: [String] {
        get {
          return snapshot["from"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "from")
        }
      }

      /// SEALED: to email address(es).
      internal var to: [String] {
        get {
          return snapshot["to"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "to")
        }
      }

      /// SEALED: cc email address(es).
      internal var cc: [String] {
        get {
          return snapshot["cc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "cc")
        }
      }

      /// SEALED: bcc email address(es).
      internal var bcc: [String] {
        get {
          return snapshot["bcc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "bcc")
        }
      }

      /// UNSEALED: Direction of message.
      internal var direction: EmailMessageDirection {
        get {
          return snapshot["direction"]! as! EmailMessageDirection
        }
        set {
          snapshot.updateValue(newValue, forKey: "direction")
        }
      }

      /// SEALED: Email message subject.
      internal var subject: String? {
        get {
          return snapshot["subject"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "subject")
        }
      }

      /// UNSEALED: Has this message been marked as seen on client.
      internal var seen: Bool {
        get {
          return snapshot["seen"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "seen")
        }
      }

      /// UNSEALED: State of message record.
      internal var state: EmailMessageState {
        get {
          return snapshot["state"]! as! EmailMessageState
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      /// UNSEALED: Algorithm descriptor describing internal and symmetric key encryption, e.g RSAEncryptionOAEPSHA256AESGCM.
      internal var algorithm: String {
        get {
          return snapshot["algorithm"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "algorithm")
        }
      }

      /// UNSEALED: Client generated key ID for the internal key.
      internal var keyId: String {
        get {
          return snapshot["keyId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyId")
        }
      }

      /// UNSEALED: ID used for the client to subscribe to specific events.
      internal var clientRefId: String? {
        get {
          return snapshot["clientRefId"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "clientRefId")
        }
      }

      /// UNSEALED: Time in milliseconds since 1970-01-01T00:00:00Z when object was created.
      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      /// UNSEALED: Time in milliseconds since 1970-01-01T00:00:00Z when object was last updated.
      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      /// UNSEALED: Version of this object, increments on update.
      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }
    }
  }
}

internal final class OnEmailMessageCreatedWithDirectionSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailMessageCreatedWithDirection($owner: String!, $direction: EmailMessageDirection!) {\n  onEmailMessageCreated(owner: $owner, direction: $direction) {\n    __typename\n    id\n    sealedId\n    owner\n    address\n    from\n    to\n    cc\n    bcc\n    direction\n    subject\n    seen\n    state\n    algorithm\n    keyId\n    clientRefId\n    createdAtEpochMs\n    updatedAtEpochMs\n    version\n  }\n}"

  internal var owner: String
  internal var direction: EmailMessageDirection

  internal init(owner: String, direction: EmailMessageDirection) {
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

    /// Owner id for the current logged in user.
    /// EmailMessageDirection used for the client to subscribe to inbound or outbound specific message events.
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
        GraphQLField("sealedId", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("from", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("to", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("cc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("bcc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("subject", type: .scalar(String.self)),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, sealedId: String, owner: GraphQLID, address: String, from: [String], to: [String], cc: [String], bcc: [String], direction: EmailMessageDirection, subject: String? = nil, seen: Bool, state: EmailMessageState, algorithm: String, keyId: String, clientRefId: String? = nil, createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Int) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "sealedId": sealedId, "owner": owner, "address": address, "from": from, "to": to, "cc": cc, "bcc": bcc, "direction": direction, "subject": subject, "seen": seen, "state": state, "algorithm": algorithm, "keyId": keyId, "clientRefId": clientRefId, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// UNSEALED: v4 UUID assigned to message record.
      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      /// UNSEALED: v4 UUID composite key.
      internal var sealedId: String {
        get {
          return snapshot["sealedId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "sealedId")
        }
      }

      /// UNSEALED: v4 UUID of user that owns the message resource.
      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      /// UNSEALED: The email address related to the message resource.
      internal var address: String {
        get {
          return snapshot["address"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "address")
        }
      }

      /// SEALED: from email address(es).
      internal var from: [String] {
        get {
          return snapshot["from"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "from")
        }
      }

      /// SEALED: to email address(es).
      internal var to: [String] {
        get {
          return snapshot["to"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "to")
        }
      }

      /// SEALED: cc email address(es).
      internal var cc: [String] {
        get {
          return snapshot["cc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "cc")
        }
      }

      /// SEALED: bcc email address(es).
      internal var bcc: [String] {
        get {
          return snapshot["bcc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "bcc")
        }
      }

      /// UNSEALED: Direction of message.
      internal var direction: EmailMessageDirection {
        get {
          return snapshot["direction"]! as! EmailMessageDirection
        }
        set {
          snapshot.updateValue(newValue, forKey: "direction")
        }
      }

      /// SEALED: Email message subject.
      internal var subject: String? {
        get {
          return snapshot["subject"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "subject")
        }
      }

      /// UNSEALED: Has this message been marked as seen on client.
      internal var seen: Bool {
        get {
          return snapshot["seen"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "seen")
        }
      }

      /// UNSEALED: State of message record.
      internal var state: EmailMessageState {
        get {
          return snapshot["state"]! as! EmailMessageState
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      /// UNSEALED: Algorithm descriptor describing internal and symmetric key encryption, e.g RSAEncryptionOAEPSHA256AESGCM.
      internal var algorithm: String {
        get {
          return snapshot["algorithm"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "algorithm")
        }
      }

      /// UNSEALED: Client generated key ID for the internal key.
      internal var keyId: String {
        get {
          return snapshot["keyId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyId")
        }
      }

      /// UNSEALED: ID used for the client to subscribe to specific events.
      internal var clientRefId: String? {
        get {
          return snapshot["clientRefId"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "clientRefId")
        }
      }

      /// UNSEALED: Time in milliseconds since 1970-01-01T00:00:00Z when object was created.
      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      /// UNSEALED: Time in milliseconds since 1970-01-01T00:00:00Z when object was last updated.
      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      /// UNSEALED: Version of this object, increments on update.
      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }
    }
  }
}

internal final class OnEmailMessageDeletedSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailMessageDeleted($owner: String!) {\n  onEmailMessageDeleted(owner: $owner) {\n    __typename\n    id\n    sealedId\n    owner\n    address\n    from\n    to\n    cc\n    bcc\n    direction\n    subject\n    seen\n    state\n    algorithm\n    keyId\n    clientRefId\n    createdAtEpochMs\n    updatedAtEpochMs\n    version\n  }\n}"

  internal var owner: String

  internal init(owner: String) {
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

    /// Owner id for the current logged in user.
    /// ID of the message that was deleted
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
        GraphQLField("sealedId", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("from", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("to", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("cc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("bcc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("subject", type: .scalar(String.self)),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, sealedId: String, owner: GraphQLID, address: String, from: [String], to: [String], cc: [String], bcc: [String], direction: EmailMessageDirection, subject: String? = nil, seen: Bool, state: EmailMessageState, algorithm: String, keyId: String, clientRefId: String? = nil, createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Int) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "sealedId": sealedId, "owner": owner, "address": address, "from": from, "to": to, "cc": cc, "bcc": bcc, "direction": direction, "subject": subject, "seen": seen, "state": state, "algorithm": algorithm, "keyId": keyId, "clientRefId": clientRefId, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// UNSEALED: v4 UUID assigned to message record.
      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      /// UNSEALED: v4 UUID composite key.
      internal var sealedId: String {
        get {
          return snapshot["sealedId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "sealedId")
        }
      }

      /// UNSEALED: v4 UUID of user that owns the message resource.
      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      /// UNSEALED: The email address related to the message resource.
      internal var address: String {
        get {
          return snapshot["address"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "address")
        }
      }

      /// SEALED: from email address(es).
      internal var from: [String] {
        get {
          return snapshot["from"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "from")
        }
      }

      /// SEALED: to email address(es).
      internal var to: [String] {
        get {
          return snapshot["to"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "to")
        }
      }

      /// SEALED: cc email address(es).
      internal var cc: [String] {
        get {
          return snapshot["cc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "cc")
        }
      }

      /// SEALED: bcc email address(es).
      internal var bcc: [String] {
        get {
          return snapshot["bcc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "bcc")
        }
      }

      /// UNSEALED: Direction of message.
      internal var direction: EmailMessageDirection {
        get {
          return snapshot["direction"]! as! EmailMessageDirection
        }
        set {
          snapshot.updateValue(newValue, forKey: "direction")
        }
      }

      /// SEALED: Email message subject.
      internal var subject: String? {
        get {
          return snapshot["subject"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "subject")
        }
      }

      /// UNSEALED: Has this message been marked as seen on client.
      internal var seen: Bool {
        get {
          return snapshot["seen"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "seen")
        }
      }

      /// UNSEALED: State of message record.
      internal var state: EmailMessageState {
        get {
          return snapshot["state"]! as! EmailMessageState
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      /// UNSEALED: Algorithm descriptor describing internal and symmetric key encryption, e.g RSAEncryptionOAEPSHA256AESGCM.
      internal var algorithm: String {
        get {
          return snapshot["algorithm"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "algorithm")
        }
      }

      /// UNSEALED: Client generated key ID for the internal key.
      internal var keyId: String {
        get {
          return snapshot["keyId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyId")
        }
      }

      /// UNSEALED: ID used for the client to subscribe to specific events.
      internal var clientRefId: String? {
        get {
          return snapshot["clientRefId"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "clientRefId")
        }
      }

      /// UNSEALED: Time in milliseconds since 1970-01-01T00:00:00Z when object was created.
      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      /// UNSEALED: Time in milliseconds since 1970-01-01T00:00:00Z when object was last updated.
      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      /// UNSEALED: Version of this object, increments on update.
      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }
    }
  }
}

internal final class OnEmailMessageDeletedWithIdSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailMessageDeletedWithId($owner: String!, $id: ID!) {\n  onEmailMessageDeleted(owner: $owner, id: $id) {\n    __typename\n    id\n    sealedId\n    owner\n    address\n    from\n    to\n    cc\n    bcc\n    direction\n    subject\n    seen\n    state\n    algorithm\n    keyId\n    clientRefId\n    createdAtEpochMs\n    updatedAtEpochMs\n    version\n  }\n}"

  internal var owner: String
  internal var id: GraphQLID

  internal init(owner: String, id: GraphQLID) {
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

    /// Owner id for the current logged in user.
    /// ID of the message that was deleted
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
        GraphQLField("sealedId", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("from", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("to", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("cc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("bcc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("subject", type: .scalar(String.self)),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, sealedId: String, owner: GraphQLID, address: String, from: [String], to: [String], cc: [String], bcc: [String], direction: EmailMessageDirection, subject: String? = nil, seen: Bool, state: EmailMessageState, algorithm: String, keyId: String, clientRefId: String? = nil, createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Int) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "sealedId": sealedId, "owner": owner, "address": address, "from": from, "to": to, "cc": cc, "bcc": bcc, "direction": direction, "subject": subject, "seen": seen, "state": state, "algorithm": algorithm, "keyId": keyId, "clientRefId": clientRefId, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// UNSEALED: v4 UUID assigned to message record.
      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      /// UNSEALED: v4 UUID composite key.
      internal var sealedId: String {
        get {
          return snapshot["sealedId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "sealedId")
        }
      }

      /// UNSEALED: v4 UUID of user that owns the message resource.
      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      /// UNSEALED: The email address related to the message resource.
      internal var address: String {
        get {
          return snapshot["address"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "address")
        }
      }

      /// SEALED: from email address(es).
      internal var from: [String] {
        get {
          return snapshot["from"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "from")
        }
      }

      /// SEALED: to email address(es).
      internal var to: [String] {
        get {
          return snapshot["to"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "to")
        }
      }

      /// SEALED: cc email address(es).
      internal var cc: [String] {
        get {
          return snapshot["cc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "cc")
        }
      }

      /// SEALED: bcc email address(es).
      internal var bcc: [String] {
        get {
          return snapshot["bcc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "bcc")
        }
      }

      /// UNSEALED: Direction of message.
      internal var direction: EmailMessageDirection {
        get {
          return snapshot["direction"]! as! EmailMessageDirection
        }
        set {
          snapshot.updateValue(newValue, forKey: "direction")
        }
      }

      /// SEALED: Email message subject.
      internal var subject: String? {
        get {
          return snapshot["subject"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "subject")
        }
      }

      /// UNSEALED: Has this message been marked as seen on client.
      internal var seen: Bool {
        get {
          return snapshot["seen"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "seen")
        }
      }

      /// UNSEALED: State of message record.
      internal var state: EmailMessageState {
        get {
          return snapshot["state"]! as! EmailMessageState
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      /// UNSEALED: Algorithm descriptor describing internal and symmetric key encryption, e.g RSAEncryptionOAEPSHA256AESGCM.
      internal var algorithm: String {
        get {
          return snapshot["algorithm"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "algorithm")
        }
      }

      /// UNSEALED: Client generated key ID for the internal key.
      internal var keyId: String {
        get {
          return snapshot["keyId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyId")
        }
      }

      /// UNSEALED: ID used for the client to subscribe to specific events.
      internal var clientRefId: String? {
        get {
          return snapshot["clientRefId"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "clientRefId")
        }
      }

      /// UNSEALED: Time in milliseconds since 1970-01-01T00:00:00Z when object was created.
      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      /// UNSEALED: Time in milliseconds since 1970-01-01T00:00:00Z when object was last updated.
      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      /// UNSEALED: Version of this object, increments on update.
      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }
    }
  }
}

internal final class OnEmailMessageDeletedWithSealedIdSubscription: GraphQLSubscription {
  internal static let operationString =
    "subscription OnEmailMessageDeletedWithSealedId($owner: String!, $sealedId: String!) {\n  onEmailMessageDeleted(owner: $owner, sealedId: $sealedId) {\n    __typename\n    id\n    sealedId\n    owner\n    address\n    from\n    to\n    cc\n    bcc\n    direction\n    subject\n    seen\n    state\n    algorithm\n    keyId\n    clientRefId\n    createdAtEpochMs\n    updatedAtEpochMs\n    version\n  }\n}"

  internal var owner: String
  internal var sealedId: String

  internal init(owner: String, sealedId: String) {
    self.owner = owner
    self.sealedId = sealedId
  }

  internal var variables: GraphQLMap? {
    return ["owner": owner, "sealedId": sealedId]
  }

  internal struct Data: GraphQLSelectionSet {
    internal static let possibleTypes = ["Subscription"]

    internal static let selections: [GraphQLSelection] = [
      GraphQLField("onEmailMessageDeleted", arguments: ["owner": GraphQLVariable("owner"), "sealedId": GraphQLVariable("sealedId")], type: .object(OnEmailMessageDeleted.selections)),
    ]

    internal var snapshot: Snapshot

    internal init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    internal init(onEmailMessageDeleted: OnEmailMessageDeleted? = nil) {
      self.init(snapshot: ["__typename": "Subscription", "onEmailMessageDeleted": onEmailMessageDeleted.flatMap { $0.snapshot }])
    }

    /// Owner id for the current logged in user.
    /// ID of the message that was deleted
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
        GraphQLField("sealedId", type: .nonNull(.scalar(String.self))),
        GraphQLField("owner", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("address", type: .nonNull(.scalar(String.self))),
        GraphQLField("from", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("to", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("cc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("bcc", type: .nonNull(.list(.nonNull(.scalar(String.self))))),
        GraphQLField("direction", type: .nonNull(.scalar(EmailMessageDirection.self))),
        GraphQLField("subject", type: .scalar(String.self)),
        GraphQLField("seen", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("state", type: .nonNull(.scalar(EmailMessageState.self))),
        GraphQLField("algorithm", type: .nonNull(.scalar(String.self))),
        GraphQLField("keyId", type: .nonNull(.scalar(String.self))),
        GraphQLField("clientRefId", type: .scalar(String.self)),
        GraphQLField("createdAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("updatedAtEpochMs", type: .nonNull(.scalar(Double.self))),
        GraphQLField("version", type: .nonNull(.scalar(Int.self))),
      ]

      internal var snapshot: Snapshot

      internal init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      internal init(id: GraphQLID, sealedId: String, owner: GraphQLID, address: String, from: [String], to: [String], cc: [String], bcc: [String], direction: EmailMessageDirection, subject: String? = nil, seen: Bool, state: EmailMessageState, algorithm: String, keyId: String, clientRefId: String? = nil, createdAtEpochMs: Double, updatedAtEpochMs: Double, version: Int) {
        self.init(snapshot: ["__typename": "SealedEmailMessage", "id": id, "sealedId": sealedId, "owner": owner, "address": address, "from": from, "to": to, "cc": cc, "bcc": bcc, "direction": direction, "subject": subject, "seen": seen, "state": state, "algorithm": algorithm, "keyId": keyId, "clientRefId": clientRefId, "createdAtEpochMs": createdAtEpochMs, "updatedAtEpochMs": updatedAtEpochMs, "version": version])
      }

      internal var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// UNSEALED: v4 UUID assigned to message record.
      internal var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      /// UNSEALED: v4 UUID composite key.
      internal var sealedId: String {
        get {
          return snapshot["sealedId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "sealedId")
        }
      }

      /// UNSEALED: v4 UUID of user that owns the message resource.
      internal var owner: GraphQLID {
        get {
          return snapshot["owner"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "owner")
        }
      }

      /// UNSEALED: The email address related to the message resource.
      internal var address: String {
        get {
          return snapshot["address"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "address")
        }
      }

      /// SEALED: from email address(es).
      internal var from: [String] {
        get {
          return snapshot["from"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "from")
        }
      }

      /// SEALED: to email address(es).
      internal var to: [String] {
        get {
          return snapshot["to"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "to")
        }
      }

      /// SEALED: cc email address(es).
      internal var cc: [String] {
        get {
          return snapshot["cc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "cc")
        }
      }

      /// SEALED: bcc email address(es).
      internal var bcc: [String] {
        get {
          return snapshot["bcc"]! as! [String]
        }
        set {
          snapshot.updateValue(newValue, forKey: "bcc")
        }
      }

      /// UNSEALED: Direction of message.
      internal var direction: EmailMessageDirection {
        get {
          return snapshot["direction"]! as! EmailMessageDirection
        }
        set {
          snapshot.updateValue(newValue, forKey: "direction")
        }
      }

      /// SEALED: Email message subject.
      internal var subject: String? {
        get {
          return snapshot["subject"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "subject")
        }
      }

      /// UNSEALED: Has this message been marked as seen on client.
      internal var seen: Bool {
        get {
          return snapshot["seen"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "seen")
        }
      }

      /// UNSEALED: State of message record.
      internal var state: EmailMessageState {
        get {
          return snapshot["state"]! as! EmailMessageState
        }
        set {
          snapshot.updateValue(newValue, forKey: "state")
        }
      }

      /// UNSEALED: Algorithm descriptor describing internal and symmetric key encryption, e.g RSAEncryptionOAEPSHA256AESGCM.
      internal var algorithm: String {
        get {
          return snapshot["algorithm"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "algorithm")
        }
      }

      /// UNSEALED: Client generated key ID for the internal key.
      internal var keyId: String {
        get {
          return snapshot["keyId"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "keyId")
        }
      }

      /// UNSEALED: ID used for the client to subscribe to specific events.
      internal var clientRefId: String? {
        get {
          return snapshot["clientRefId"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "clientRefId")
        }
      }

      /// UNSEALED: Time in milliseconds since 1970-01-01T00:00:00Z when object was created.
      internal var createdAtEpochMs: Double {
        get {
          return snapshot["createdAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "createdAtEpochMs")
        }
      }

      /// UNSEALED: Time in milliseconds since 1970-01-01T00:00:00Z when object was last updated.
      internal var updatedAtEpochMs: Double {
        get {
          return snapshot["updatedAtEpochMs"]! as! Double
        }
        set {
          snapshot.updateValue(newValue, forKey: "updatedAtEpochMs")
        }
      }

      /// UNSEALED: Version of this object, increments on update.
      internal var version: Int {
        get {
          return snapshot["version"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "version")
        }
      }
    }
  }
}
