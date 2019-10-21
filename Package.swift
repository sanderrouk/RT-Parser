// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "RTParser",
    // Do consider updating the version numbers
    dependencies: [
        // Vapor core
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // .env Support (Has other stuff as well)
        .package(url: "https://github.com/vapor-community/vapor-ext.git", from: "0.1.0"),

        // DB Engines
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),

        // API Documentation
        .package(url: "https://github.com/mczachurski/Swiftgger.git", from: "1.2.1"),
    ],
    targets: [
        .target(name: "OpenApi", dependencies: [ "Vapor", "Swiftgger"]),
        .target(name: "Data", dependencies: ["Vapor", "OpenApi", "FluentSQLite"]),
        .target(name: "LawHierarchy", dependencies: ["Vapor", "Data", "FluentSQLite"]),
        .target(
            name: "App",
            dependencies: [
                "OpenApi",
                "Data",
                "LawHierarchy",
                "Vapor",
                "VaporExt",
                "FluentSQLite"
            ]
        ),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

