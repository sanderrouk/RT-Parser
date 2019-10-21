import Vapor
import FluentSQLite
import Data

public protocol UserRepository: Service {
    func createOrUpdate(user: User) -> Future<User>
    func getAllUsersWithTodos() -> Future<[UserWithTodos]>
}

public class UserRepositoryImpl: UserRepository {
    private let databaseConnection: SQLiteDatabase.ConnectionPool

    required init(databaseConnection:  SQLiteDatabase.ConnectionPool) {
        self.databaseConnection = databaseConnection
    }

    public func createOrUpdate(user: User) -> EventLoopFuture<User> {
        return databaseConnection.withConnection { connection in
            return user.save(on: connection)
        }
    }

    public func getAllUsersWithTodos() -> EventLoopFuture<[UserWithTodos]> {
        return databaseConnection.withConnection { connection in
            return User.query(on: connection)
                .all()
                .flatMap {
                    fetchChildren(of: $0, via: \Todo.userID, on: connection) { user, todos in
                        return UserRepositoryImpl.make(user: user, with: todos)
                    }
            }
        }
    }

    private static func make(user: User, with todos: [Todo]) -> UserWithTodos {
        return UserWithTodos(id: user.id ?? 0, name: user.name, email: user.email, todos: todos)
    }
}

extension UserRepositoryImpl: ServiceType {
    public static let serviceSupports: [Any.Type] = [UserRepository.self]

    public static func makeService(for worker: Container) throws -> Self {
        let connectionPool = try worker.connectionPool(to: .sqlite)
        return .init(databaseConnection: connectionPool)
    }
}
