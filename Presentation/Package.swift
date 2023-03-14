// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Presentation",
            targets: ["Presentation"]
        ),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "Domain", path: "../Domain"),
//        .package(url: "https://github.com/mischa-hildebrand/AlignedCollectionViewFlowLayout.git", from: "1.1.2")
    ],
    targets: [
        .target(
            name: "Presentation",
            dependencies: [
                "Core",
                "Domain"
            ]
        ),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Presentation"]
        ),
    ]
)
