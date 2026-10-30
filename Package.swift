// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SudoEmail",
    platforms: [
        .iOS(.v18),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SudoEmail",
            targets: ["SudoEmail"]),
        .library(
            name: "SudoEmailNotificationExtension",
            targets: ["SudoEmailNotificationExtension"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sudoplatform/sudo-api-client-ios", from: "14.0.0"),
        .package(url: "https://github.com/sudoplatform/sudo-config-manager-ios", from: "6.0.1"),
        .package(url: "https://github.com/sudoplatform/sudo-logging-ios", from: "3.0.0"),
        .package(url: "https://github.com/sudoplatform/sudo-key-manager-ios", from: "5.0.0"),
        .package(url: "https://github.com/sudoplatform/sudo-notification-ios", from: "6.0.0"),
        .package(url: "https://github.com/sudoplatform/sudo-user-ios", from: "19.0.0"),
        .package(url: "https://github.com/aws-amplify/amplify-swift", from: "2.58.3"),
        .package(url: "https://github.com/awslabs/aws-sdk-swift", from: "1.6.71"),
        // Explicitly depend on smithy-swift so the required Smithy products are linked
        // into the final binary. smithy-swift is already a transitive dependency of
        // aws-sdk-swift; declaring it here makes the link explicit and pins a version
        // (0.191.0+) that compiles cleanly under the Swift 6 toolchain used in CI.
        .package(url: "https://github.com/smithy-lang/smithy-swift", from: "0.191.0"),
        .package(url: "https://github.com/anonyome/mailcore2", from: "2.0.0"),
        .package(url: "https://github.com/1024jp/GzipSwift", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "SudoEmailCommon",
            dependencies: [                
                .product(name: "SudoLogging", package: "sudo-logging-ios"),
                .product(name: "SudoKeyManager", package: "sudo-key-manager-ios"),
            ],
            path: "SudoEmailCommon/",
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),
        .target(
            name: "SudoEmail",
            dependencies: [                
                .product(name: "Amplify", package: "amplify-swift"),
                .product(name: "AWSAPIPlugin", package: "amplify-swift"),
                .product(name: "AWSS3StoragePlugin", package: "amplify-swift"),
                .product(name: "AWSCognitoAuthPlugin", package: "amplify-swift"),
                .product(name: "AWSPluginsCore", package: "amplify-swift"),
                .product(name: "AWSS3", package: "aws-sdk-swift"),
                .product(name: "SudoLogging", package: "sudo-logging-ios"),
                .product(name: "SudoConfigManager", package: "sudo-config-manager-ios"),
                .product(name: "SudoKeyManager", package: "sudo-key-manager-ios"),
                .product(name: "SudoUser", package: "sudo-user-ios"),
                .product(name: "SudoApiClient", package: "sudo-api-client-ios"),
                .product(name: "SudoNotification", package: "sudo-notification-ios"),
                .product(name: "MailCore2", package: "mailcore2"),
                .product(name: "Gzip", package: "GzipSwift"),
                .target(name: "SudoEmailCommon")
            ],
            path: "SudoEmail/",
            swiftSettings: [.swiftLanguageMode(.v5)]
        ),
        .target(
            name: "SudoEmailNotificationExtension",
            dependencies: [                
                .product(name: "SudoLogging", package: "sudo-logging-ios"),
                .product(name: "SudoKeyManager", package: "sudo-key-manager-ios"),
                .product(name: "SudoNotificationExtension", package: "sudo-notification-ios"),
                .target(name: "SudoEmailCommon")
            ],
            path: "SudoEmailNotificationExtension/",
            swiftSettings: [.swiftLanguageMode(.v5)]
        )
    ]
)
