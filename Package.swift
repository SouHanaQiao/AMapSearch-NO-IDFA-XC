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
        .binaryTarget(name: "AMapSearch-NO-IDFA", path: "artifacts/AMapSearch-NO-IDFA.zip"),
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
    ],
    swiftLanguageVersions: [.v5]
)
