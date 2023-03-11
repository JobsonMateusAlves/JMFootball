// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Data",
            targets: ["Data"]
        ),
    ],
    dependencies: [
        .package(name: "Core", path: "../Core"),
        .package(name: "Domain", path: "../Domain"),
        .package(url: "https://github.com/groue/GRDB.swift.git", from: "5.24.1")
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: [
                "Core",
                "Domain",
                .product(
                    name: "GRDB",
                    package: "GRDB.swift"
                )
            ]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"]
        ),
    ]
)
