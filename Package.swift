// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "EmpusaServer",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.83.1")
    ],
    targets: [
        .executableTarget(
            name: "EmpusaServer",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
            ]
        ),
        .testTarget(name: "EmpusaTests", dependencies: [
            .target(name: "EmpusaServer"),
            .product(name: "XCTVapor", package: "vapor"),

            // Workaround for https://github.com/apple/swift-package-manager/issues/6940
            .product(name: "Vapor", package: "vapor"),
        ])
    ]
)
