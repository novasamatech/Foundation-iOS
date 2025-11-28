// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let name = "Foundation-iOS"
let package = Package(
    name: name,
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: name,
            targets: [name]),
    ],
    dependencies: [
        .package(url: "https://github.com/novasamatech/Keystore-iOS", exact: "1.1.0"),
        .package(url: "https://github.com/Brightify/Cuckoo", exact: "1.10.4")
    ],
    targets: [
        .target(
            name: name,
            dependencies: [
                "Keystore-iOS"
            ],
            path: "Foundation-iOS/Classes"
        ),
        .testTarget(
            name: "Tests",
            dependencies: [
                "Foundation-iOS",
                .product(name: "Cuckoo", package: "Cuckoo")
            ],
            path: "Tests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
