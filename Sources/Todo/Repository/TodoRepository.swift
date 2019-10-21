import Vapor
import FluentSQLite
import Data

public protocol TodoRepository: Service {
    func getAllTodos(for user: User) -> Future<[Todo]>
    func create(todo: Todo) -> Future<Todo>
    func delete(todo: Todo) -> Future<Todo>
}

public final class TodoRepositoryImpl: TodoRepository {
    private let databaseConnection: SQLiteDatabase.ConnectionPool

    required init(databaseConnection:  SQLiteDatabase.ConnectionPool) {
        self.databaseConnection = databaseConnection
    }

    public func getAllTodos(for user: User)  -> EventLoopFuture<[Todo]> {
        return databaseConnection.withConnection { connection in
            return try Todo.query(on: connection)
                .filter(\.userID == user.requireID())
                .all()
        }
    }

    public func create(todo: Todo) -> EventLoopFuture<Todo> {
        return databaseConnection.withConnection { connection in
            return todo.save(on: connection)
        }
    }

    public func delete(todo: Todo) -> EventLoopFuture<Todo> {
        return databaseConnection.withConnection { connection in
            return todo.delete(on: connection).transform(to: todo)
        }
    }
}

extension TodoRepositoryImpl: ServiceType {
    public static let serviceSupports: [Any.Type] = [TodoRepository.self]

    public static func makeService(for worker: Container) throws -> Self {
        let connectionPool = try worker.connectionPool(to: .sqlite)
        return .init(databaseConnection: connectionPool)
    }
}
