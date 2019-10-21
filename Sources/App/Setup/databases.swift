import Vapor
//import FluentMySQL
//import FluentPostgreSQL
import FluentSQLite

public func databases(config: inout DatabasesConfig, env: Environment) throws {
//    let postgreSqQLDatasource = Environment.get("EXAMPLE_POSTGRESQL")
//    let mySQLDatasource = Environment.get("EXAMPLE_MYSQL")

    // Configure a SQLite database
    let sqlite = try SQLiteDatabase(storage: .memory)

    // Register the configured SQLite database to the database config.
    config.enableLogging(on: .sqlite)
    config.add(database: sqlite, as: .sqlite)
}

