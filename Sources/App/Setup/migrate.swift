import Vapor
import Fluent
import Data

public func migrate(migrations: inout MigrationConfig) throws {
    migrations.add(model: User.self, database: .sqlite)
    migrations.add(model: UserToken.self, database: .sqlite)
    migrations.add(model: Todo.self, database: .sqlite)
}
