import Vapor
import FluentSQLite

func setupProviders(config: inout Config, services: inout Services) throws {
    try services.register(FluentSQLiteProvider())

    config.prefer(MemoryKeyedCache.self, for: KeyedCache.self)
}
