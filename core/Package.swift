// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "BreezeCore",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products:[
        .library(
            name: "BreezeCore",
            targets:["BreezeCore"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "1.7.4"),
        .package(url: "https://github.com/OpenCombine/OpenCombine.git", from: "0.12.0")
    ],
    targets: [
        .target(name: "BreezeCore", dependencies: [
            "SwiftSoup",
            "OpenCombine",
            .product(name: "OpenCombineFoundation", package: "OpenCombine"),
            .product(name: "OpenCombineDispatch", package: "OpenCombine")
        ]),
        .testTarget(name: "BreezeCoreTests", dependencies: ["BreezeCore"]),
    ]
)
