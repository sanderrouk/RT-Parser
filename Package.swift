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
//        .package(url: "https://github.com/vapor/fluent-postgresql.git", from: "1.0.0"),
//        .package(url: "https://github.com/vapor/fluent-mysql.git", from: "3.0.0"),

        // API Documentation
        .package(url: "https://github.com/mczachurski/Swiftgger.git", from: "1.2.1"),

        // Localisation
        .package(url: "https://github.com/miroslavkovac/Lingo.git", from: "3.0.0"),

        // Templating engine
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.2"),

        // Auth
        .package(url: "https://github.com/vapor/auth.git", from: "2.0.0")
    ],
    targets: [
        .target(name: "OpenApi", dependencies: [ "Vapor", "Swiftgger"]),
        .target(name: "Data", dependencies: ["Vapor", "Authentication", "OpenApi", "FluentSQLite"]),
        .target(name: "User", dependencies: ["Vapor", "FluentSQLite", "OpenApi", "Data"]),
        .target(name: "Todo", dependencies: ["Vapor", "FluentSQLite", "OpenApi", "Data"]),
        .target(
            name: "App",
            dependencies: [
                "OpenApi",
                "Data",
                "User",
                "Todo",
                "Vapor",
                "VaporExt",
                "FluentSQLite",
                //            "FluentMySQL",
                //            "FluentPostgreSQL",
                "Lingo",
                "Leaf",
                "Authentication",
            ]
        ),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

