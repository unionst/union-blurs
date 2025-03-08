// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "iBlurView",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "iBlurView",
            targets: ["iBlurView"]
        ),
    ],
    targets: [
        .target(
            name: "iBlurView"
        ),
    ]
)
