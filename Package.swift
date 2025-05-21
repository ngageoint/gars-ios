// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "GARS",
    platforms: [.macOS(.v11), .iOS(.v13)],
    products: [
        .library(
            name: "GARS",
            targets: ["GARS"])
    ],
    dependencies: [
        .package(url: "https://github.com/ngageoint/grid-ios", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "GARS",
            dependencies: [
                .product(name: "Grid", package: "grid-ios")
            ],
            path: "gars-ios",
            resources: [
                .copy("gars.plist"),
            ]
        ),
        .testTarget(
            name: "GARSTests",
            dependencies: [
                "GARS"
            ],
            path: "gars-iosTests"
        )
    ]
)
