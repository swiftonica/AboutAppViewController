// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AboutAppViewController",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "AboutAppViewController",
            targets: ["AboutAppViewController"]),
    ],
    dependencies: [
        .package(
            name: "SnapKit",
            url: "https://github.com/SnapKit/SnapKit",
            .upToNextMajor(from: "5.0.1")
        )
    ],
    targets: [
        .target(
            name: "AboutAppViewController",
            dependencies: [
                "SnapKit"
            ]
        ),
        .testTarget(
            name: "AboutAppViewControllerTests",
            dependencies: ["AboutAppViewController"]
        )
    ]
)
