// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "BreezeCore",
    products:[
        .library(
            name: "BreezeCore",
            targets:["BreezeCore"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "1.7.4"),
    ],
    targets: [
        .target(name: "BreezeCore", dependencies: ["SwiftSoup"]),
        .testTarget(name: "BreezeCoreTests", dependencies: ["BreezeCore"]),
    ]
)
