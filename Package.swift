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
    dependencies: [
        .package(url: "https://github.com/SouHanaQiao/AMapFoundation-NO-IDFA-XC", from: "1.8.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .binaryTarget(
            name: "AMapSearch-NO-IDFA",
            url: "https://github.com/SouHanaQiao/AMapSearch-NO-IDFA-XC/releases/download/9.5.0/AMapSearch-NO-IDFA.zip",
            checksum: "9c8504d851d2fcd3d6089155cdda64090748436eda6fc2ce4364816a0c4d4470"),
        .target(name: "AMapSearch-NO-IDFA-XC", dependencies: [
            .product(name: "AMapFoundation-NO-IDFA-XC", package: "AMapFoundation-NO-IDFA-XC"),
            .target(name: "AMapSearch-NO-IDFA"),
        ], linkerSettings: [
            .linkedFramework("SystemConfiguration"),
            .linkedFramework("CoreTelephony"),
            .linkedLibrary("z")
        ]),
        .testTarget(
            name: "AMapSearch-NO-IDFA-XCTests",
            dependencies: ["AMapSearch-NO-IDFA-XC"]),
    ]
)
