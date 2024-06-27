//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

/// JSON decodable representation of polymporphic notification as encrypted in the push notification payload
enum EmailServiceNotification: Decodable, Equatable {

    case messageReceived(MessageReceivedNotification)
    case unknown(_ type: String)

    enum CodingKeys: String, CodingKey {
        case type
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let type = try? values.decode(EmailServiceNotificationType.self, forKey: .type)
        
        switch type {
        case .messageReceived:
            let messageReceivedNotification = try MessageReceivedNotification(from: decoder) 
            self = .messageReceived(messageReceivedNotification)
        case nil:
            let typeString: String? = try? values.decodeIfPresent(String.self, forKey: .type)
            let type: String = typeString ?? "unknown"
            self = .unknown(type)
        }
    }

    static func == (lhs: EmailServiceNotification, rhs: EmailServiceNotification) -> Bool {
        switch lhs {
        case .messageReceived(let lhs):
            switch rhs {
            case .messageReceived(let rhs):
                return lhs == rhs
            default:
                return false
            }
        case .unknown(let lhs):
            switch rhs {
            case .unknown(let rhs):
                return lhs == rhs
            default:
                return false
            }
        }
    }
}
