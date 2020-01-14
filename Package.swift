// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "RTParser",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor-community/vapor-ext.git", from: "0.1.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        .package(url: "https://github.com/mczachurski/Swiftgger.git", from: "1.2.1"),
        .package(url: "https://github.com/tid-kijyun/Kanna.git", from: "5.0.0")
    ],
    targets: [
        .target(name: "OpenApi", dependencies: [ "Vapor", "Swiftgger"]),
        .target(name: "Data", dependencies: ["Vapor", "OpenApi", "FluentSQLite"]),
        .target(name: "LawHierarchy", dependencies: ["Vapor", "Data", "FluentSQLite", "Kanna"]),
        .target(name: "LawParser", dependencies: ["Vapor", "Data", "FluentSQLite", "LawHierarchy"]),
        .testTarget(name: "LawParserTests", dependencies: ["LawParser"]),
        .target(name: "TimerJobs", dependencies: ["Vapor"]),
        .target(
            name: "App",
            dependencies: [
                "OpenApi",
                "Data",
                "LawHierarchy",
                "LawParser",
                "TimerJobs",
                "Vapor",
                "VaporExt",
                "FluentSQLite",
                "Kanna"
            ]
        ),
        .target(name: "Run", dependencies: ["App"])
    ]
)
