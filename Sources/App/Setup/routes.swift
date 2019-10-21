import Crypto
import Vapor
import Data
import OpenApi
import Todo
import User

/// Register your application's routes here.
public func routes(_ router: Router, _ container: Container) throws {
    // Route Groups
    let emptyRouteGroup = ""
    let v1RouteGroup: [PathComponentsRepresentable] =  ["api", "v1"]

    let todoService = try container.make(TodoService.self)
    let todoController = TodoController(todoService: todoService, group: v1RouteGroup)

    let userService = try container.make(UserService.self)
    let userController = UserController(
        userService: userService,
        group: v1RouteGroup
    )

    let controllers: [RouteCollection] = [
        ApiSpecController(group: emptyRouteGroup),
        ReDocController(group: emptyRouteGroup),
        todoController,
        userController
    ]

    try controllers.forEach { try router.register(collection: $0) }
}
