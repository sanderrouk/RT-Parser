import Vapor
import Data

public protocol TodoService: Service {
    func index(for user: User) -> Future<[Todo]>
    func createTodo(with title: String, for user: User) throws -> Future<Todo>
    func delete(todo: Todo, ownedBy user: User) throws -> Future<Todo>
}

public final class TodoServiceImpl: TodoService {

    private let todoRepository: TodoRepository

    required public init(todoRepository: TodoRepository) {
        self.todoRepository = todoRepository
    }

    public func index(for user: User) -> EventLoopFuture<[Todo]> {
        return todoRepository.getAllTodos(for: user)
    }

    public func createTodo(with title: String, for user: User) throws -> EventLoopFuture<Todo> {
        let todo = try Todo(title: title, userID: user.requireID())
        return todoRepository.create(todo: todo)
    }

    public func delete(todo: Todo, ownedBy user: User) throws -> EventLoopFuture<Todo> {
        // ensure the todo being deleted belongs to this user
        guard try todo.userID == user.requireID() else {
            throw Abort(.forbidden)
        }

        return todoRepository.delete(todo: todo)
    }
}

extension TodoServiceImpl: ServiceType {
    public static let serviceSupports: [Any.Type] = [TodoService.self]

    public static func makeService(for container: Container) throws -> Self {
        let todoRepository = try container.make(TodoRepository.self)
        return .init(todoRepository: todoRepository)
    }
}
