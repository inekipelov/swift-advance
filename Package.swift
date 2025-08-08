// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-advance",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "SwiftAdvance", targets: ["SwiftAdvance"]),
    ],
    dependencies: [
        .package(url: "https://github.com/inekipelov/swift-result-advance.git", from: "0.1.1"),
    .package(url: "https://github.com/inekipelov/swift-codable-advance.git", from: "0.1.4"),
    .package(url: "https://github.com/inekipelov/swift-collection-advance.git", from: "0.1.8"),
    ],
    targets: [
        .target(
            name: "SwiftAdvance",
            dependencies: [
                .product(name: "ResultAdvance", package: "swift-result-advance"),
                .product(name: "CodableAdvance", package: "swift-codable-advance"),
                .product(name: "CollectionAdvance", package: "swift-collection-advance")
            ],
            path: "Sources"
        ),
        .testTarget(name: "SwiftAdvanceTests", dependencies: ["SwiftAdvance"], path: "Tests"),
    ]
)
