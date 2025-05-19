// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "SQLCipher-SPM",
    platforms: [
        .iOS(.v12), .watchOS(.v4), .tvOS(.v12), .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SQLCipher",
            targets: [
                "SQLCipherC"
            ]
        ),
    ],
    targets: [
        .target(
            name: "SQLCipherC",
            dependencies: ["SQLCipherStatic"]
        ),
        .binaryTarget(
            name: "SQLCipherStatic",
            path: "SQLCipher.xcframework"
        ),
    ]
)
