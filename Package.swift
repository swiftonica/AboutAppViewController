// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AboutAppViewController",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "AboutAppViewController",
            targets: ["AboutAppViewController"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AboutAppViewController",
            dependencies: []
        ),
        .testTarget(
            name: "AboutAppViewControllerTests",
            dependencies: ["AboutAppViewController"]
        )
    ]
)
