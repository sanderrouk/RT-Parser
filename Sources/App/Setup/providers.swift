import Vapor
//import FluentPostgreSQL
//import FluentMySQL
import FluentSQLite
import Leaf
import Authentication

func setupProviders(config: inout Config, services: inout Services) throws {
    //    try services.register(FluentPostgreSQLProvider())
    //    try services.register(FluentMySQLProvider())
    try services.register(FluentSQLiteProvider())
    try services.register(LeafProvider())
    try services.register(AuthenticationProvider())

    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    config.prefer(MemoryKeyedCache.self, for: KeyedCache.self)
}
