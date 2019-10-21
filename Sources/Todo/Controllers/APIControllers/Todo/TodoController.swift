import Vapor
import Data

public final class TodoController: RouteCollection {

    private let todoService: TodoService
    private let group: [PathComponentsRepresentable]

    public init(todoService: TodoService,
                group: PathComponentsRepresentable...) {
        self.todoService = todoService
        self.group = group
    }

    public func boot(router: Router) throws {
        // bearer / token auth protected routes
        let routeGroup = router
            .grouped(User.tokenAuthMiddleware())
            .grouped(group)

        routeGroup.get("todos", use: index)
        routeGroup.post("todos", use: create)
        routeGroup.delete("todos", Todo.parameter, use: delete)
    }

    public func index(_ req: Request) throws -> Future<[Todo]> {
        // fetch auth'd user
        let user = try req.requireAuthenticated(User.self)

        // query all todo's belonging to user
        return todoService.index(for: user)
    }

    /// Creates a new todo for the auth'd user.
    public func create(_ req: Request) throws -> Future<Todo> {
        // fetch auth'd user
        let user = try req.requireAuthenticated(User.self)

        // decode request content
        return try req.content.decode(CreateTodoRequest.self).flatMap { [todoService] todo in
            // save new todo
            return try todoService.createTodo(with: todo.title, for: user)
        }
    }

    /// Deletes an existing todo for the auth'd user.
    public func delete(_ req: Request) throws -> Future<HTTPStatus> {
        // fetch auth'd user
        let user = try req.requireAuthenticated(User.self)

        // decode request parameter (todos/:id)
        return try req.parameters.next(Todo.self).flatMap { [todoService] todo -> Future<Todo> in
            // delete model
            return try todoService.delete(todo: todo, ownedBy: user)
            }.transform(to: .ok)
    }
}


