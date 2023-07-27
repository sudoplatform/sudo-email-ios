//
// Copyright © 2023 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import AWSCore

/// Disables Cyclomatic Dependency for `AWSRegionType` as the kit has no control over `AWSRegionType`.
// swiftlint:disable cyclomatic_complexity

extension AWSRegionType {
    init?(string: String) {
        switch string {
        case "us-east-1": self = .USEast1
        case "us-east-2": self = .USEast2
        case "us-west-1": self = .USWest1
        case "us-west-2": self = .USWest2
        case "ap-east-1": self = .APEast1
        case "ap-south-1": self = .APSouth1
        case "ap-northeast-1": self = .APNortheast1
        case "ap-northeast-2": self = .APNortheast2
        case "ap-southeast-1": self = .APSoutheast1
        case "ap-southeast-2": self = .APSoutheast2
        case "ap-southeast-3": self = .APSoutheast3
        case "ca-central-1": self = .CACentral1
        case "cn-north-1": self = .CNNorth1
        case "cn-northwest-1": self = .CNNorthWest1
        case "eu-central-1": self = .EUCentral1
        case "eu-west-1": self = .EUWest1
        case "eu-west-2": self = .EUWest2
        case "eu-west-3": self = .EUWest3
        case "eu-north-1": self = .EUNorth1
        case "me-central-1": self = .MECentral1
        case "me-south-1": self = .MESouth1
        case "sa-east-1": self = .SAEast1
        case "us-gov-east-1": self = .USGovEast1
        case "us-gov-west-1": self = .USGovWest1
        default:
            return nil
        }
    }

    /// Retuns the string value, or `nil` if unsupported / API has evolved.
    var string: String? {
        switch self {
        case .USEast1:
            return "us-east-1"
        case .USEast2:
            return "us-east-2"
        case .USWest1:
            return "us-west-1"
        case .USWest2:
            return "us-west-2"
        case .APEast1:
            return "ap-east-1"
        case .APSouth1:
            return "ap-south-1"
        case .APNortheast1:
            return "ap-northeast-1"
        case .APNortheast2:
            return "ap-northeast-2"
        case .APSoutheast1:
            return "ap-southeast-1"
        case .APSoutheast2:
            return "ap-southeast-2"
        case .CACentral1:
            return "ca-central-1"
        case .CNNorth1:
            return "cn-north-1"
        case .CNNorthWest1:
            return "cn-northwest-1"
        case .EUCentral1:
            return "eu-central-1"
        case .EUWest1:
            return "eu-west-1"
        case .EUWest2:
            return "eu-west-2"
        case .EUWest3:
            return "eu-west-3"
        case .EUNorth1:
            return "eu-north-1"
        case .MECentral1:
            return "me-central-1"
        case .MESouth1:
            return "me-south-1"
        case .SAEast1:
            return "sa-east-1"
        case .USGovEast1:
            return "us-gov-east-1"
        case .USGovWest1:
            return "us-gov-west-1"
        case .AFSouth1:
            return "af-south-1"
        case .EUSouth1:
            return "eu-south-1"
        case .APSoutheast3:
            return "ap-southeast-3"
        case .Unknown:
            fallthrough
        @unknown default:
            return nil
        }
    }
}

extension AWSRegionType: Decodable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let stringValue = try container.decode(String.self)
        guard let value = AWSRegionType.init(string: stringValue) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Value not supported: \(stringValue)")
        }
        self = value
    }

}
