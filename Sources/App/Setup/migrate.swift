import Vapor
import Fluent
import Data

public func migrate(migrations: inout MigrationConfig) throws {
    migrations.add(model: Law.self, database: .sqlite)
}
