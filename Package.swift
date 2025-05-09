// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "SQLCipher-SPM",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "SQLCipher",
            targets: [
                "SQLCipher"
            ]
        ),
    ],
    targets: [
        .package(
            name: "SQLCipher",
            path: "SQLCipher.framework.zip"
        )
    ]
)