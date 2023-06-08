// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AMapSearch-NO-IDFA-XC",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AMapSearch-NO-IDFA-XC",
            targets: ["AMapSearch-NO-IDFA-XC"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AMapSearch-NO-IDFA-XC"),
        .binaryTarget(
            name: "AMapSearch-NO-IDFA",
            url: "https://github.com/SouHanaQiao/AMapSearch-NO-IDFA-XC/releases/download/9.5.0/AMapSearch-NO-IDFA.zip",
            checksum: "8c27211c3fd9a10dafa33f02cd561c65a338f61b33e1812809c9e8111cc18611"),
        .testTarget(
            name: "AMapSearch-NO-IDFA-XCTests",
            dependencies: ["AMapSearch-NO-IDFA-XC"]),
    ]
)