//
// Copyright © 2024 Anonyome Labs, Inc. All rights reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation
import SudoNotification

// JSON logic rule matching email service notification types we do not know how to handle
// This string is compared across platforms and must match across them all.
let defaultFirstRuleString = """
{"!=":[{"var":"meta.type"},"\(EmailServiceNotificationType.messageReceived.rawValue)"]}
"""

// Notification filter rule excluding email service notification types we do not know how to handle
let defaultFirstRule = NotificationFilterItem(
    name: Constants.serviceName,
    status: false,
    rules: defaultFirstRuleString
)

// JSON logic rule that always evaluates to true
let defaultLastRuleString = """
{"==":[1,1]}
"""

// Notification filter defaulting to enable
let defaultLastRule = NotificationFilterItem(
    name: Constants.serviceName,
    status: true,
    rules: defaultLastRuleString
)

public extension NotificationConfiguration {

    // MARK: - Extensions

    ///
    /// Extension function to ensure a [NotificationConfiguration] is initialized for
    /// receipt of email service notifications.
    ///
    /// - Returns: New NotificationConfiguration with updated rules
    ///
    func initEmailNotifications() -> NotificationConfiguration {
        var newConfigs = configs.filter { $0.name != Constants.serviceName }
        
        let emServiceConfigs = configs
            .filter { $0.name == Constants.serviceName }
            // Filter out any current or historic default rules.
            // We'll add current default rules back in
            .filter { $0.rules != defaultFirstRuleString && $0.rules != defaultLastRuleString }
            
        newConfigs.append(defaultFirstRule)
        newConfigs.append(contentsOf: emServiceConfigs)
        newConfigs.append(defaultLastRule)


        return NotificationConfiguration(configs: newConfigs)
    }

    ///
    /// Extension function to add rules to a [NotificationConfiguration] for enabling
    /// or disabling notifications for a particular email address ID.
    ///
    /// Once all notification configurations across all Sudo platform SDKs have
    /// been performed, call the
    /// `SudoNotificationClient.setNotificationConfiguration`
    /// to set the full notification configuration for your application.
    ///
    /// - Parameters:
    ///   - emailAddressId: ID of email address to set notification enablement for
    ///   - enabled: Whether or not notifications are to be enabled or disabled for the
    ///     email address with the specified ID.
    ///
    /// - Returns: New NotificationConfiguration with updated rules
    ///
    func setEmailNotificationsForAddressId(emailAddressId: String, enabled: Bool) -> NotificationConfiguration {
        // Start with any rules for other services
        var newRules = configs
            .filter { $0.name != Constants.serviceName }

        // Then find all the email service rules except our defaults and
        // any existing rule matching this email address ID.
        let newEmServiceRules = configs
            .filter { $0.name == Constants.serviceName }
            // Filter out any current or historic default rules.
            // We'll add current default rules back in
            .filter { $0.rules != defaultFirstRuleString && $0.rules != defaultLastRuleString }
            // Filter out any rule specific to our emailAddressId
            .filter { !isRuleMatchingEmailAddressId(rule: $0.rules, emailAddressId: emailAddressId) }

        // Re-add DEFAULT_FIRST_RULE
        newRules.append(defaultFirstRule)

        // Re-add email service rules for other addresses
        newRules.append(contentsOf: newEmServiceRules)

        // If we're disabling notifications for this email address then
        // add an explicit rule for that
        if (!enabled) {
            let newJsonRule = """
                {"==":[{"var":"meta.emailAddressId"},"\(emailAddressId)"]}
                """
            newRules.append(
                NotificationFilterItem(
                    name: Constants.serviceName,
                    status: false,
                    rules: newJsonRule
                )
            )
        }

        // Re-add the default catch all enabling rule
        newRules.append(defaultLastRule)

        return NotificationConfiguration(configs: newRules)
    }

    ///
    /// Determine whether or not notifications for a particular email address are enabled
    ///
    /// - Parameters:
    ///   - forEmailAddressWithId: ID of email address to determine notification enablement status for
    ///
    /// - Returns: Whether or not notifications are enabled for the particular email address with given iD
    ///
    func areNotificationsEnabled(forEmailAddressWithId emailAddressId: String) -> Bool {
        let disablingRule = configs.first {
            $0.name == Constants.serviceName &&
            $0.status == NotificationConfiguration.disabledStatus &&
            isRuleMatchingEmailAddressId(rule: $0.rules, emailAddressId: emailAddressId)
        }

        return disablingRule == nil
    }

    // MARK: - Helpers

    internal func isRuleMatchingEmailAddressId(rule: String?, emailAddressId: String) -> Bool {
        guard let rule = rule?.data(using: .utf8) else {
            return false
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: rule, options: []) as? [String: Any] else {
            return false
        }

        let equality = json["=="]
        guard let array = equality as? [Any], array.count == 2 else {
            return false
        }
        
        let lhs = array[0]
        let rhs = array[1]

        // "var meta.emailAddressId == emailAddressId
        if (lhs is [String:Any] && rhs is String) {
            guard let lhs = lhs as? [String:Any],
                  let rhs = rhs as? String,
                  let v = lhs["var"] as? String else {
                return false
            }
            if (v == "meta.emailAddressId" && rhs == emailAddressId) {
                return true
            }
        }

        // "emailAddressId == var meta.emailAddressId
        else if (rhs is [String:Any] && lhs is String) {
            guard let lhs = lhs as? String,
                  let rhs = rhs as? [String:Any],
                  let v = rhs["var"] as? String else {
                return false
            }
            if (v == "meta.emailAddressId" && lhs == emailAddressId) {
                return true
            }
        }
        
        return false
    }
}
