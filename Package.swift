// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FastReplaceBenchmarks",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "FastReplaceBenchmarks",
            targets: ["FastReplaceBenchmarks"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stefanspringer1/FastReplace", from: "1.0.0"),
        .package(path: "../CodepointMacro"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "FastReplaceBenchmarks",
            dependencies: [
                "FastReplace",
                "CodepointMacro",
            ]
        ),
    ]
)
