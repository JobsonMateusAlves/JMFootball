// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Presentation",
            targets: ["Presentation"]),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "Domain", path: "../Domain"),
    ],
    targets: [
        .target(
            name: "Presentation",
            dependencies: []),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Presentation"]),
    ]
)
